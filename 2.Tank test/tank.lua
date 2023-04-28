local tank = {}
tank.x = 0
tank.y = 0
tank.angle = 0
tank.speed = 500
tank.vx = 0
tank.vy = 0
tank.imgGun = love.graphics.newImage("images/gun.png")

local gun = {}
gun.x = 0
gun.y = 0
gun.angle = 0

function tank.update(dt)
    -- Le tank se deplace
    if love.keyboard.isDown("d") then
        tank.x = tank.x + (tank.speed * dt)
        tank.angle = 0
    end
    if love.keyboard.isDown("q") then
        tank.x = tank.x - (tank.speed * dt)
        tank.angle = 180
    end
    if love.keyboard.isDown("s") then
        tank.y = tank.y + (tank.speed * dt)
        tank.angle = 90
    end
    if love.keyboard.isDown("z") then
        tank.y = tank.y - (tank.speed * dt)
        tank.angle = -90
    end

    local dD = love.keyboard.isDown("d")
    local dQ = love.keyboard.isDown("q")
    local dS = love.keyboard.isDown("s")
    local dZ = love.keyboard.isDown("z")

    -- Le sprite du tank se tourne dans les diagonales
    if dD and dZ then
        tank.angle = -45
    end
    if dD and dS then
        tank.angle = 45
    end
    if dS and dQ then
        tank.angle = 135
    end
    if dQ and dZ then
        tank.angle = 225
    end

    gun.x = tank.x
    gun.y = tank.y

    -- La tourelle tourne en suivant la souris
    local mX, mY = love.mouse.getPosition()
    gun.angle = (math.atan2(mY - gun.y, mX - gun.x))
end

function tank.draw()
    -- Dessin du tank
    love.graphics.draw(
        tankImg,
        tank.x,
        tank.y,
        math.rad(tank.angle),
        0.5,
        0.5,
        tankImg:getWidth() / 2,
        tankImg:getHeight() / 2
    )

    -- Dessin de la tourelle
    love.graphics.draw(
        tank.imgGun,
        gun.x,
        gun.y,
        gun.angle,
        0.5,
        0.5,
        tank.imgGun:getWidth() / 2,
        tank.imgGun:getHeight() / 2
    )
end

return tank
