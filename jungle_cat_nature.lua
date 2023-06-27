--variables used to keep track of score, current frame, and enemy attack
local score = 0
local frame = 0
local enemyAttack = false

--setup function which sets background color, player position, and title
function setup()
  love.graphics.setBackgroundColor(255, 255, 255)
  playerPosX = love.graphics.getWidth()/2
  playerPosY = love.graphics.getHeight()/2
  love.window.setTitle('Art Attack')
end
 
--update function responsible for deciding when to fire an enemy attack
function update(dt)
  if frame % 100 == 0 and not enemyAttack then
    fireEnemyAttack()
  end
end

--draw function will draw the player, enemies and score text
function draw()
  love.graphics.print('Score: ' .. score, 400, 20, 0, 2, 2)
  drawPlayer()
  drawEnemies()
end

--draw player function which draws the player at the playerPosX, playerPosY variables
function drawPlayer()
  love.graphics.rectangle('fill', playerPosX, playerPosY, 20, 20)
end

--draw enemies function which draws enemies at the enemyPosX and enemyPosY variables
function drawEnemies()
  for i=1, #enemyPosX do
  	love.graphics.rectangle('fill', enemyPosX[i], enemyPosY[i], 20, 20)
  end
end

--fire enemy attack responsible for creating enemies and setting enemyAttack boolean
function fireEnemyAttack()
  enemyPosX = {100, 250, 400, 550, 700}
  enemyPosY = {100, 250, 400, 550, 700}
  enemyAttack = true
end

--mousepressed function responsible for player shooting, enemy hit and destroying, score increase
function mousepressed(x, y, button, isTouch) 
  if button == 1 and enemyAttack then
    for i=#enemyPosX, 1, -1 do
        if x > enemyPosX[i] and x < enemyPosX[i] + 20 and y > enemyPosY[i] and y < enemyPosY[i] + 20 then
            table.remove(enemyPosX, i)
            table.remove(enemyPosY, i)
            score = score + 100
        end
    end
  end
  if #enemyPosX == 0 then
    enemyAttack = false
  end
end

--keypressed function responsible for moving player
function keypressed(key)
if key == 'left' then 
  playerPosX = playerPosX - 10
end
if key == 'right' then 
  playerPosX = playerPosX + 10
end
if key == 'up' then 
  playerPosY = playerPosY - 10
end
if key == 'down' then
  playerPosY = playerPosY + 10
end
end