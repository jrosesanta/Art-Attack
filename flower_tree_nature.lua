-- Art Attack by Kevin Smith

-- Setup function to initialize the game state
local function setup()
  -- Setup canvas as a black rectangle
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(),
                         love.graphics.getHeight())

  -- Setup the player object
  player = {}
  player.x = 100
  player.y = 100
  player.width = 50
  player.height = 50
  player.velocity = 200

  -- Setup the enemy objects
  enemies = {}
  enemies[1] = {x = 300, y = 75, width = 50, height = 50, image = love.graphics.newImage("enemy.png")}
  enemies[2] = {x = 500, y = 125, width = 50, height = 50, image = love.graphics.newImage("enemy.png")}
  enemies[3] = {x = 700, y = 175, width = 50, height = 50, image = love.graphics.newImage("enemy.png")}

  -- Setup score variables
  score = 0
  timeRemaining = 30

  -- Setup background music and sound effects
  music = love.audio.newSource("background.mp3")
  music:play()
  soundExplosion = love.audio.newSource("explosion.wav")
end

-- Update function to update the game state
function love.update(dt)
  -- Update the player position
  if love.keyboard.isDown('left') then
    player.x = player.x - (player.velocity * dt)
  elseif love.keyboard.isDown('right') then
    player.x = player.x + (player.velocity * dt)
  end

  -- Keep the player inside the screen
  if player.x < 0 then
    player.x = 0
  elseif player.x > love.graphics.getWidth() - player.width then
    player.x = love.graphics.getWidth() - player.width
  end

  -- Update enemies
  for i, enemy in ipairs(enemies) do
    if enemy.x > player.x and enemy.x > 0 then
      enemy.x = enemy.x - (player.velocity * dt)
    else
      enemy.x = love.graphics.getWidth()
    end
    if CheckCollision(player.x, player.y, player.width,
                      player.height, enemy.x, enemy.y,
                      enemy.width, enemy.height) then
      -- Add to score
      score = score + 1
      soundExplosion:play()
      -- Remove the enemy from the table
      table.remove(enemies, i)
    end
  end
  
  -- Update timer
  timeRemaining = timeRemaining - (1 * dt)

  if timeRemaining <= 0 then
    love.audio.stop(music)
    love.event.quit()
  end
end

-- Render function to draw the game
function love.draw()
  -- Draw player
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", player.x, player.y,
                          player.width, player.height)
  -- Draw enemies
  for i, enemy in ipairs(enemies) do
    love.graphics.setColor(255, 255, 0)
    love.graphics.draw(enemy.image, enemy.x, enemy.y, 0, 1, 1, 0, 0)
  end
  -- Draw score
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Score: " .. score, 0, 0)
  -- Draw Timer
  love.graphics.print("Time Remaining: " .. math.ceil(timeRemaining), 0, 15)
end

-- Collision detection function
function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

-- Call setup function
setup()