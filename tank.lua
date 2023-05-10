local tank = {}
tank.x = 0
tank.y = 0
tank.angle = 0
tank.speed = 250
tank.vx = 0
tank.vy = 0
tankImg = love.graphics.newImage("images/tankAmi/tank.png")

tank.imgGun = love.graphics.newImage("images/tankAmi/gun.png")

local gun = {}
gun.x = 0
gun.y = 0
gun.angle = 0

function tank.update(dt)
    if love.keyboard.isDown("d") then
        tank.angle = tank.angle + 2 * dt
    end

    if love.keyboard.isDown("q") then
        tank.angle = tank.angle - 2 * dt
    end

    if love.keyboard.isDown("z") then
        local vx = tank.speed * math.cos(tank.angle)
        local vy = tank.speed * math.sin(tank.angle)
        tank.x = tank.x + vx * dt
        tank.y = tank.y + vy * dt
    end

    if love.keyboard.isDown("s") then
        local vx = tank.speed * math.cos(tank.angle)
        local vy = tank.speed * math.sin(tank.angle)
        tank.x = tank.x - vx * dt
        tank.y = tank.y - vy * dt
    end

    gun.x = tank.x
    gun.y = tank.y

    -- La tourelle tourne en suivant la souris
    local mX, mY = love.mouse.getPosition()
    gun.angle = (math.atan2(mY - gun.y, mX - gun.x))
end

function tank.draw()
    -- Dessin du tank
    love.graphics.draw(tankImg, tank.x, tank.y, tank.angle, 1, 1, tankImg:getWidth() / 2, tankImg:getHeight() / 2)

    -- Dessin de la tourelle
    love.graphics.draw(
        tank.imgGun,
        gun.x,
        gun.y,
        gun.angle,
        1,
        1,
        tank.imgGun:getWidth() / 2,
        tank.imgGun:getHeight() / 2
    )
end

return tank
