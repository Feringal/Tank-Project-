local tank = require("tank")

local rayonChasse = 200

-- Returns the distance between two points.
function math.dist(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1, y1, x2, y2)
    return math.atan2(y2 - y1, x2 - x1)
end

largeur = love.graphics.getWidth()
hauteur = love.graphics.getHeight()

local listeZonesSpawn = {}
-- Spawner haut
listeZonesSpawn[1] = {
    x = 1200 / 3,
    y = 5,
    angle = math.pi / 2
}
-- Spawner droit
listeZonesSpawn[2] = {
    x = 1200 - 90,
    y = 220,
    angle = math.pi
}
-- Spawner gauche
listeZonesSpawn[3] = {
    x = 5,
    y = 800 / 1.5,
    angle = 0
}
-- Spawner bas
listeZonesSpawn[4] = {
    x = 1200 / 2,
    y = 800 - 45,
    angle = math.pi * 1.5
}

local ennemis = {}

local vSpawn = 2.5
local tSpawn = vSpawn

local listeEnnemis = {}
imgEnnemi = love.graphics.newImage("images/TankEnnemi/tankE.png")

local EtatsTankE = {}
EtatsTankE.E_X = "X"
EtatsTankE.E_CHANGEDIR = "CHD"
EtatsTankE.E_AVANCE = "AV"
EtatsTankE.E_CHASSE = "CHASSE"
EtatsTankE.E_TIR = "TIR"

function spawnEnnemis()
    local ennemi = {}
    ennemi.x = 0
    local randomSpawn = math.random(1, #listeZonesSpawn)
    local x = listeZonesSpawn[randomSpawn].x
    local y = listeZonesSpawn[randomSpawn].y
    ennemi.x = x + imgEnnemi:getWidth() / 2
    ennemi.y = y + imgEnnemi:getHeight() / 2
    ennemi.angle = listeZonesSpawn[randomSpawn].angle
    ennemi.etat = EtatsTankE.E_X
    ennemi.angleCible = ennemi.angle
    table.insert(listeEnnemis, ennemi)
end

function love.load()
end

function ennemis.update(dt)
    tSpawn = tSpawn - dt
    if tSpawn <= 0 then
        spawnEnnemis()
        tSpawn = vSpawn
    end

    for n = #listeEnnemis, 1, -1 do
        local e = listeEnnemis[n]

        -- Fait une rotation en direction de son angle cible
        if e.angle <= e.angleCible then
            e.angle = e.angle + 1 * dt
        elseif e.angle >= e.angleCible then
            e.angle = e.angle - 1 * dt
        end

        if e.etat == EtatsTankE.E_X then
            e.etat = EtatsTankE.E_AVANCE
            e.dist = 3
        elseif e.etat == EtatsTankE.E_AVANCE then
            local vx = 120 * math.cos(e.angle)
            local vy = 120 * math.sin(e.angle)

            e.x = e.x + vx * dt
            e.y = e.y + vy * dt

            e.dist = e.dist - dt
            if e.dist <= 0 then
                e.etat = EtatsTankE.E_CHANGEDIR
            else
                local dist = math.dist(e.x, e.y, tank.x, tank.y)
                if dist <= rayonChasse then
                    e.etat = EtatsTankE.E_CHASSE
                end
            end
        elseif e.etat == EtatsTankE.E_CHASSE then
            local angleToTank = math.angle(e.x, e.y, tank.x, tank.y)
            e.angle = angleToTank
            local vx = 120 * math.cos(e.angle)
            local vy = 120 * math.sin(e.angle)

            e.x = e.x + vx * dt
            e.y = e.y + vy * dt

            local dist = math.dist(e.x, e.y, tank.x, tank.y)
            if dist > rayonChasse then
                e.etat = EtatsTankE.E_AVANCE
                e.dist = 1
            elseif dist <= rayonChasse / 2 then
                e.etat = EtatsTankE.E_TIR
            end
        elseif e.etat == EtatsTankE.E_CHANGEDIR then
            e.angleCible = e.angleCible + math.pi / 2
            e.etat = EtatsTankE.E_AVANCE
            e.dist = love.math.random(1, 3)
        elseif e.etat == EtatsTankE.E_TIR then
            local angleToTank = math.angle(e.x, e.y, tank.x, tank.y)
            e.angle = angleToTank
            local dist = math.dist(e.x, e.y, tank.x, tank.y)
            if dist > rayonChasse then
                e.etat = EtatsTankE.E_CHANGEDIR
            end
        end

        -- supprime l'ennemi quand il sort de l'ecran
        if
            e.x + (imgEnnemi:getWidth() / 2) > love.graphics.getWidth() or e.x - (imgEnnemi:getWidth() / 2) < 0 or
                e.y + (imgEnnemi:getHeight() / 2) > love.graphics.getHeight() or
                e.y - (imgEnnemi:getHeight() / 2) < 0
         then
            table.remove(listeEnnemis, n)
        end
    end
end

function ennemis.draw()
    -- Dessine les ennemis
    for n = 1, #listeEnnemis do
        local e = listeEnnemis[n]
        love.graphics.draw(imgEnnemi, e.x, e.y, e.angle, 1, 1, imgEnnemi:getWidth() / 2, imgEnnemi:getHeight() / 2)
        love.graphics.print(e.etat, e.x, e.y - 40)
        love.graphics.print(e.dist, e.x, e.y - 60)

        love.graphics.circle("line", e.x, e.y, rayonChasse)
    end

    -- Dessine les spawners
    for z = 1, #listeZonesSpawn do
        local zone = listeZonesSpawn[z]
        love.graphics.rectangle("fill", zone.x, zone.y, 85, 40)
    end

    love.graphics.print("Temps d'apparition : " .. tSpawn, 10, 30)
    love.graphics.print("Nombre de tanks : " .. #listeEnnemis, 10, 50)
end

return ennemis
