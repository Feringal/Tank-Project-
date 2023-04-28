local tourelle = {}

local tirs = require("tirs")
local tank = require("tank")

local intervalleTir = 3

tourelle.x = 700
tourelle.y = 100
tourelle.timer = intervalleTir

function tourelle.update(dt)
    tourelle.timer = tourelle.timer - dt
    if tourelle.timer <= 0 then
        -- on affiche boum
        print("boum")
        local angle = math.angle(tourelle.x, tourelle.y, tank.x, tank.y)
        tirs.Tire(tourelle.x, tourelle.y, angle, 500)
        -- on fait repartir le timer
        tourelle.timer = intervalleTir
    end
end

function tourelle.draw()
    love.graphics.circle("fill", tourelle.x, tourelle.y, 20)
end

return tourelle
