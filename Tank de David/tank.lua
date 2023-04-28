-- Module Tank
print("je suis le module")
local tank = {}
tank.x = 50
tank.y = 200
tank.speed = 100
tank.angle = 0
tank.tourne = function(self, angle)
    self.angle = self.angle + angle
end

function tank.update(dt)
    if love.keyboard.isDown("right") then
        tank:tourne(2 * dt)
    elseif love.keyboard.isDown("left") then
        tank:tourne(-2 * dt)
    end
    if love.keyboard.isDown("up") then
        tank.x = tank.x + tank.speed * dt * math.cos(tank.angle)
        tank.y = tank.y + tank.speed * dt * math.sin(tank.angle)
    end
end

function tank.draw()
    love.graphics.draw(imageTank, tank.x, tank.y, tank.angle, 1, 1, imageTank:getWidth() / 2, imageTank:getHeight() / 2)
end

return tank
