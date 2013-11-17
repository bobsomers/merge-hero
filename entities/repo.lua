local Class = require "hump.class"
local Vector = require "hump.vector"
local Timer = require "hump.timer"
local constants = require "constants"
local tracks = require "tracks"

local Repo = Class {
    font = love.graphics.newFont("fonts/pricedown.ttf", 48),

    active = {
        h = true,
        j = false,
        k = false,
        l = false
    },

    particles = {
        h = false,
        j = false,
        k = false,
        l = false
    },

    wubWubFactor = {
        value = 1.0
    },
    WUB_WUB_TIME = 0.1,
    WUB_WUB_MAGNITUDE = 1.5,

    TARGET_SPEED = 200,
    tracks = tracks,
    nextTarget = {
        h = 1,
        j = 1,
        k = 1,
        l = 1
    },

    image = love.graphics.newImage("images/particle.png"),

    SPEW_TIME = 0.05,
    offTime = {
        h = 0,
        j = 0,
        k = 0,
        l = 0
    },

    BRANCH_MERGE_TIME = 0.25,

    RADIUS = 50,
    STENCIL_RADIUS = 42,

    init = function(self)
        self.targetY = constants.SCREEN.y - 100
        self.scaledTargetY = self.targetY * 2

        local tempSpacing = self:calcSpacing(self.RADIUS)
        self.emissionPos = {
            h = Vector(self:targetX("h", tempSpacing, self.RADIUS), self.targetY),
            j = Vector(self:targetX("j", tempSpacing, self.RADIUS), self.targetY),
            k = Vector(self:targetX("k", tempSpacing, self.RADIUS), self.targetY),
            l = Vector(self:targetX("l", tempSpacing, self.RADIUS), self.targetY)
        }

        local particleBuffer = 750
        local emissionRate = 1500
        local direction = math.pi / 2
        local speedMin = 300
        local speenMax = 350
        local sizeMin = 0.4
        local sizeMax = 0.6
        local sizeVariation = 0.5
        local lifetime = -1
        local particleLife = 0.5

        self.particles.h = love.graphics.newParticleSystem(self.image, particleBuffer)
        self.particles.h:setEmissionRate(emissionRate)
        self.particles.h:setDirection(direction)
        self.particles.h:setSpeed(speedMin, speedMax)
        self.particles.h:setSizes(sizeMin, sizeMax)
        self.particles.h:setSizeVariation(sizeVariation)
        self.particles.h:setColors(240, 25, 25, 255, 240, 25, 25, 0)
        self.particles.h:setLifetime(lifetime)
        self.particles.h:setParticleLife(particleLife)

        self.particles.j = love.graphics.newParticleSystem(self.image, particleBuffer)
        self.particles.j:setEmissionRate(emissionRate)
        self.particles.j:setDirection(direction)
        self.particles.j:setSpeed(speedMin, speedMax)
        self.particles.j:setSizes(sizeMin, sizeMax)
        self.particles.j:setSizeVariation(sizeVariation)
        self.particles.j:setColors(25, 240, 25, 255, 25, 240, 25, 0)
        self.particles.j:setLifetime(lifetime)
        self.particles.j:setParticleLife(particleLife)

        self.particles.k = love.graphics.newParticleSystem(self.image, particleBuffer)
        self.particles.k:setEmissionRate(emissionRate)
        self.particles.k:setDirection(direction)
        self.particles.k:setSpeed(speedMin, speedMax)
        self.particles.k:setSizes(sizeMin, sizeMax)
        self.particles.k:setSizeVariation(sizeVariation)
        self.particles.k:setColors(25, 25, 240, 255, 25, 25, 240, 0)
        self.particles.k:setLifetime(lifetime)
        self.particles.k:setParticleLife(particleLife)

        self.particles.l = love.graphics.newParticleSystem(self.image, particleBuffer)
        self.particles.l:setEmissionRate(emissionRate)
        self.particles.l:setDirection(direction)
        self.particles.l:setSpeed(speedMin, speedMax)
        self.particles.l:setSizes(sizeMin, sizeMax)
        self.particles.l:setSizeVariation(sizeVariation)
        self.particles.l:setColors(240, 240, 25, 255, 240, 240, 25, 0)
        self.particles.l:setLifetime(lifetime)
        self.particles.l:setParticleLife(particleLife)

        self.particles.h:stop()
        self.particles.j:stop()
        self.particles.k:stop()
        self.particles.l:stop()
    end
}

function Repo:update(dt)
    local microTime = love.timer.getMicroTime()
    for _, lane in ipairs({"h", "j", "k", "l"}) do
        if microTime > self.offTime[lane] then
            self.particles[lane]:setSpread(0)
            self.particles[lane]:setRadialAcceleration(0)
            self.particles[lane]:setTangentialAcceleration(0)
        end
    end

    self.particles.h:update(dt)
    self.particles.j:update(dt)
    self.particles.k:update(dt)
    self.particles.l:update(dt)
end

function Repo:draw(songTime)
    local radius = self.RADIUS * self.wubWubFactor.value
    local stencilRadius = self.STENCIL_RADIUS * self.wubWubFactor.value
    local spacing = self:calcSpacing(radius)

    local x = {
        h = self:targetX("h", spacing, radius),
        j = self:targetX("j", spacing, radius),
        k = self:targetX("k", spacing, radius),
        l = self:targetX("l", spacing, radius)
    }

    -- Lanes.
    love.graphics.setColor(240, 25, 25)
    love.graphics.line(x.h, 0, x.h, constants.SCREEN.y)
    love.graphics.setColor(25, 240, 25)
    love.graphics.line(x.j, 0, x.j, constants.SCREEN.y)
    love.graphics.setColor(25, 25, 240)
    love.graphics.line(x.k, 0, x.k, constants.SCREEN.y)
    love.graphics.setColor(240, 240, 25)
    love.graphics.line(x.l, 0, x.l, constants.SCREEN.y)

    -- Lane targets.
    for _, lane in ipairs({"h", "j", "k", "l"}) do
        local i = self.nextTarget[lane]
        while true do
            if not self.tracks[lane][i] then
                break
            end

            local deltaT = self.tracks[lane][i] - songTime
            local distance = self.TARGET_SPEED * deltaT

            local y = self.targetY - distance

            if y < -50 then
                break
            elseif y > self.targetY then
                self:ping(lane)
                self.nextTarget[lane] = self.nextTarget[lane] + 1
            else
                local color = self:laneColor(lane)
                love.graphics.setColor(color.r, color.g, color.b)
                love.graphics.circle("fill", x[lane], y, 15, 20)
            end

            i = i + 1
        end
    end

    -- Lane particles.
    local color_mode = love.graphics.getColorMode()
    local blend_mode = love.graphics.getBlendMode()
    love.graphics.setColorMode("modulate")
    love.graphics.setBlendMode("additive")

    self.particles.h:setPosition(self.emissionPos.h.x, self.emissionPos.h.y)
    love.graphics.draw(self.particles.h, 0, 0)

    self.particles.j:setPosition(self.emissionPos.j.x, self.emissionPos.j.y)
    love.graphics.draw(self.particles.j, 0, 0)

    self.particles.k:setPosition(self.emissionPos.k.x, self.emissionPos.k.y)
    love.graphics.draw(self.particles.k, 0, 0)

    self.particles.l:setPosition(self.emissionPos.l.x, self.emissionPos.l.y)
    love.graphics.draw(self.particles.l, 0, 0)

    love.graphics.setColorMode(color_mode)
    love.graphics.setBlendMode(blend_mode)

    -- Lane goals.
    love.graphics.push()
    love.graphics.scale(1.0, 0.5)

    love.graphics.setColor(240, 25, 25)
    love.graphics.setInvertedStencil(function()
        love.graphics.circle("fill", x.h, self.scaledTargetY, stencilRadius, 30)
    end)
    love.graphics.circle("fill", x.h, self.scaledTargetY, radius, 30)

    love.graphics.setColor(25, 240, 25)
    love.graphics.setInvertedStencil(function()
        love.graphics.circle("fill", x.j, self.scaledTargetY, stencilRadius, 30)
    end)
    love.graphics.circle("fill", x.j, self.scaledTargetY, radius, 30)

    love.graphics.setColor(25, 25, 240)
    love.graphics.setInvertedStencil(function()
        love.graphics.circle("fill", x.k, self.scaledTargetY, stencilRadius, 30)
    end)
    love.graphics.circle("fill", x.k, self.scaledTargetY, radius, 30)

    love.graphics.setColor(240, 240, 25)
    love.graphics.setInvertedStencil(function()
        love.graphics.circle("fill", x.l, self.scaledTargetY, stencilRadius, 30)
    end)
    love.graphics.circle("fill", x.l, self.scaledTargetY, radius, 30)

    love.graphics.setStencil()

    love.graphics.pop()

    -- Lane leters.
    love.graphics.setFont(self.font)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("h", x.h - 11, self.targetY + 23)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("h", x.h - 14, self.targetY + 20)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("j", x.j - 10, self.targetY + 23)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("j", x.j - 13, self.targetY + 20)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("k", x.k - 8, self.targetY + 23)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("k", x.k - 11, self.targetY + 20)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("l", x.l - 5, self.targetY + 23)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("l", x.l - 8, self.targetY + 20)
end

function Repo:beat(songTime)
    self.wubWubFactor.value = self.WUB_WUB_MAGNITUDE
    Timer.tween(self.WUB_WUB_TIME, self.wubWubFactor, {value = 1.0}, "bounce")
end

function Repo:activate(which, activate)
    self.active[which] = activate
    if activate then
        self.particles[which]:start()
    else
        self.particles[which]:stop()
    end
end

function Repo:branch(from, to)
    self:activate(to, true)

    local spacing = self:calcSpacing(self.RADIUS)
    local fromX = self:targetX(from, spacing, self.RADIUS)
    local toX = self:targetX(to, spacing, self.RADIUS)

    self.emissionPos[to].x = fromX
    self.emissionPos[to].y = self.targetY
    Timer.tween(self.BRANCH_MERGE_TIME, self.emissionPos[to], {x = toX}, "in-out-sine")
end

function Repo:merge(from, to)

    local spacing = self:calcSpacing(self.RADIUS)
    local fromX = self:targetX(from, spacing, self.RADIUS)
    local toX = self:targetX(to, spacing, self.RADIUS)

    self.emissionPos[from].x = fromX
    self.emissionPos[from].y = self.targetY
    Timer.tween(self.BRANCH_MERGE_TIME, self.emissionPos[from], {x = toX}, "in-out-sine", function()
        self:activate(from, false)
    end)
end

function Repo:calcSpacing(radius)
    return (constants.SCREEN.x - (8 * radius)) / 5
end

function Repo:targetX(which, spacing, radius)
    if which == "h" then
        return spacing + radius
    elseif which == "j" then
        return 2 * spacing + 3 * radius
    elseif which == "k" then
        return 3 * spacing + 5 * radius
    elseif which == "l" then
        return 4 * spacing + 7 * radius
    end

    return constants.SCREEN.x / 2
end

function Repo:laneColor(lane)
    if lane == "h" then
        return {r = 240, g = 0, b = 0}
    elseif lane == "j" then
        return {r = 0, g = 240, b = 0}
    elseif lane == "k" then 
        return {r = 0, g = 0, b = 240}
    elseif lane == "l" then
        return {r = 240, g = 240, b = 0}
    end

    return {r = 255, g = 255, b = 255}
end

function Repo:ping(lane)
    self.particles[lane]:setSpread(2 * math.pi)
    self.particles[lane]:setRadialAcceleration(50, 500)
    self.particles[lane]:setTangentialAcceleration(-500, 500)

    self.offTime[lane] = love.timer.getMicroTime() + self.SPEW_TIME
end

return Repo
