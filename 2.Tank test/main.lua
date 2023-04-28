tankImg = love.graphics.newImage("images/tank.png")

local tank = require("tank")

function love.load()
    -- Change la taille de la fenetre
    gameWindow = love.window.setMode(1200, 800)

    -- Change le nom de la fenetre
    love.window.setTitle("World of Tankcraft")

    -- Ces deux variables sont-elles utiles ?
    largeur = love.graphics.getWidth()
    hauteur = love.graphics.getHeight()

    -- Centre le tank dans la fenetre
    tank.x = love.graphics.getWidth() / 2
    tank.y = love.graphics.getHeight() / 2
end

function love.update(dt)
    tank.update(dt)
end

function love.draw()
    -- Dessine le tank et la tourelle
    tank.draw()
end
