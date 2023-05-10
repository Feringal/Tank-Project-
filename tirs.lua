local tank = require("tank")
local gun = require("tank")
local listeEnnemis = require("ennemis")

local tirs = {}
-- a remplacer par image d'obus
-- local imgTirs = 0

-- Returns the distance between two points.
function math.dist(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

function Tire(x, y, angle, vitesse, type)
    local projectile = {}
    projectile.x = x
    projectile.y = y
    projectile.angle = angle
    projectile.vitesse = vitesse
    projectile.type = type
    table.insert(tirs, projectile)
end

function tirs.update(dt)
    -- Gestion des projectiles

    for n = #tirs, 1, -1 do
        local p = tirs[n]

        local vx = p.vitesse * math.cos(p.angle)
        local vy = p.vitesse * math.sin(p.angle)
        p.x = p.x + vx * dt
        p.y = p.y + vy * dt

        if p.x > largeur or p.x < 0 or p.y > hauteur or p.y < 0 then
            table.remove(tirs, n)
        else
            for ne = #listeEnnemis, 1, -1 do
                local e = listeEnnemis[ne]
                if math.dist(p.x, p.y, e.x, e.y) < imgEnnemi:getWidth() / 2 then
                    table.remove(tirs, n)
                    table.remove(listeEnnemis, ne)
                end
            end
        end
    end
end

function tirs.draw()
    for k, v in ipairs(tirs) do
        if v.type == "ami" then
            love.graphics.setColor(0, 1, 0, 1)
        else
            love.graphics.setColor(1, 0, 0, 1)
        end
        love.graphics.circle("fill", v.x, v.y, 3)
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.print("Nombre de tirs : " .. #tirs, 10, 10)
end

function tirs.declenche(key)
    if key == "space" then
        local mX, mY = love.mouse.getPosition()
        tirAngle = (math.atan2(mY - tank.y, mX - tank.x))
        Tire(tank.x, tank.y, tirAngle, 500, "ami")
    end
end

return tirs
