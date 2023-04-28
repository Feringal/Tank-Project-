-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

function math.angle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

imageTank = love.graphics.newImage("images/tank.png")

print("je vais charger le module tank")
local tank = require("tank")
print("l'adresse du moduleTank dans main est " .. tostring(moduleTank))
print("je vais charger le module tirs")
local moduleTirs = require("tirs")

local tourelle = require("tourelle")

local infoJeu = {
    score = 0,
    largeur = love.graphics.getWidth(),
    hauteur = love.graphics.getHeight()
}

function love.load()
end

function love.update(dt)
    tank.update(dt)
    moduleTirs.update(dt, infoJeu)
    tourelle.update(dt)
end

function love.draw()
    moduleTirs.draw()
    tank.draw()
    tourelle.draw()

    love.graphics.print(moduleTirs.GetNumberOfTirs())
end

function love.keypressed(key)
    if key == "space" then
        moduleTirs.Tire(tank.x, tank.y, tank.angle, 300)
    end
end
