-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local tank = require("tank")
local tirs = require("tirs")
local ennemis = require("ennemis")
local listeEnnemis = require("ennemis")

etatJeu = "jeu"

function love.load()
    -- Change la taille de la fenetre
    gameWindow = love.window.setMode(1200, 800)

    -- Change le nom de la fenetre
    love.window.setTitle("World of Tankcraft")

    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()

    -- Centre le tank dans la fenetre
    tank.x = love.graphics.getWidth() / 2
    tank.y = love.graphics.getHeight() / 2

    -- Centre la pause
    pauseX = largeur / 2
    pauseY = 10
end

function updatePause(dt)
    pauseX = pauseX
end

function updateJeu(dt)
    tirs.update(dt)
    tank.update(dt)
    ennemis.update(dt)
end

function love.update(dt)
    if etatJeu == "pause" then
        updatePause(dt)
    elseif etatJeu == "jeu" then
        updateJeu(dt)
    end
end

function drawPause()
    love.graphics.print("PAUSE", pauseX, pauseY)
end

function drawJeu()
    ennemis.draw()
    tirs.draw()

    tank.draw()
end

function love.draw()
    if etatJeu == "pause" then
        drawPause()
    elseif etatJeu == "jeu" then
        drawJeu()
    end
end

function love.keypressed(key)
    if etatJeu == "pause" then
        if key == "escape" then
            etatJeu = "jeu"
        end
    elseif etatJeu == "jeu" then
        if key == "space" then
            tirs.declenche(key)
        end
        if key == "escape" then
            etatJeu = "pause"
        end
    end
end
