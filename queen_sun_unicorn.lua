-- Importing the libs
local physics = require("physics")
local display = require("display")
local transition = require("transition")
local lfs = require("lfs")

-- Setting up the variables
local artattacks = {}
local attackOn = false
local attackDelay = 1000
local attackVelocity = 5
local attackAngVelocity = 3

-- Updating the background and making it the right size
local background = display.newImageRect("background.jpg", display.actualContentWidth, display.actualContentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY

-- Setting up the physical properties
physics.start()
physics.setGravity(0, 0)

-- Function to start the art attack
function artattacks:startAttack()
	-- Making sure the attack isn't already going on
	if not attackOn then
		attackOn = true
		
		-- Setting up the timer to start the attack
		local attackTimer = timer.performWithDelay(attackDelay, function()
			-- Finding the art attack images
			for file in lfd.dir("artattacks") do
				if string.find(file, ".png") or string.find(file, ".jpg") then
					-- Creating the art attack image
					local artattack = display.newImage("artattacks/" .. file)
					
					-- Setting up the physics
					physics.addBody(artattack, { density = 1.0, friction = 0.3, bounce = 0.2, rotation = math.random() * 360 })
					
					-- Setting up the starting random location and velocity
					artattack.x = math.random(display.contentWidth)
					artattack.y = math.random(display.contentHeight)
					artattack:setLinearVelocity(math.random(-attackVelocity, attackVelocity), math.random(-attackVelocity, attackVelocity))
					artattack.angularVelocity = math.random(-attackAngVelocity, attackAngVelocity)
					
					-- Setting up the collision with the walls
					artattack.collision = wallCollision
					artattack:addEventListener("collision", artattack)
				end
			end
		end, 0)
	end
end

-- Function to stop the art attack
function artattacks:endAttack()
	-- Making sure the attack isn't already going on
	if attackOn then
		attackOn = false
		
		-- Setting up a loop to find all the art attack images
		for _, artattack in pairs(display.getCurrentStage().children) do
			if artattack.collision then
				transition.cancel(artattack)
				transition.to(artattack, { time = 1000, alpha = 0, xScale = 0.5, yScale = 0.5, onComplete = function(obj)
					display.remove(obj)
				end})
			end
		end
		
		-- Cancelling the attack timer
		timer.cancel(attackTimer)
	end
end

-- Collision function for the art attack images
function wallCollision(self, event)
	-- Making sure it's not a wallcollision
	if event.other.name == "edge" then
		-- Reversing the velocity
		self:setLinearVelocity(self:getLinearVelocity().x * -1, self:getLinearVelocity().y * -1)
		self.angularVelocity = self.angularVelocity * -1
	end
end

return artattacks