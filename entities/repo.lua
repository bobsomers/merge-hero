local Class = require "hump.class"
local Vector = require "hump.vector"
local Timer = require "hump.timer"
local constants = require "constants"

local Repo = Class {
    active = {
        h = false,
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

    image = love.graphics.newImage("images/particle.png"),

    SPEW_TIME = 0.05,
    offTime = 0,

    init = function(self)
        local particleBuffer = 500
        local emissionRate = 250
        local direction = math.pi / 2
        local speedMin = 100
        local speenMax = 150
        local sizeMin = 0.4
        local sizeMax = 0.6
        local sizeVariation = 0.5
        local lifetime = -1
        local particleLife = 1.5

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

        self.particles.h:start()
        self.particles.j:start()
        self.particles.k:start()
        self.particles.l:start()
    end
}

function Repo:update(dt)
    if love.timer.getMicroTime() > self.offTime then
        self.particles.h:setSpread(0)
        self.particles.j:setSpread(0)
        self.particles.k:setSpread(0)
        self.particles.l:setSpread(0)

        self.particles.h:setRadialAcceleration(0)
        self.particles.j:setRadialAcceleration(0)
        self.particles.k:setRadialAcceleration(0)
        self.particles.l:setRadialAcceleration(0)

        self.particles.h:setTangentialAcceleration(0)
        self.particles.j:setTangentialAcceleration(0)
        self.particles.k:setTangentialAcceleration(0)
        self.particles.l:setTangentialAcceleration(0)
    end

    self.particles.h:update(dt)
    self.particles.j:update(dt)
    self.particles.k:update(dt)
    self.particles.l:update(dt)
end

function Repo:draw()
    local y = (constants.SCREEN.y - 100)
    local scaledY = y * 2
    local radius = 50 * self.wubWubFactor.value
    local stencilRadius = 42 * self.wubWubFactor.value
    local spacing = (constants.SCREEN.x - (8 * radius)) / 5

    local x = {
        h = spacing + radius,
        j = 2 * spacing + 3 * radius,
        k = 3 * spacing + 5 * radius,
        l = 4 * spacing + 7 * radius
    }

    love.graphics.setColor(240, 25, 25)
    love.graphics.line(x.h, 0, x.h, constants.SCREEN.y)
    love.graphics.setColor(25, 240, 25)
    love.graphics.line(x.j, 0, x.j, constants.SCREEN.y)
    love.graphics.setColor(25, 25, 240)
    love.graphics.line(x.k, 0, x.k, constants.SCREEN.y)
    love.graphics.setColor(240, 240, 25)
    love.graphics.line(x.l, 0, x.l, constants.SCREEN.y)

    local color_mode = love.graphics.getColorMode()
    local blend_mode = love.graphics.getBlendMode()
    love.graphics.setColorMode("modulate")
    love.graphics.setBlendMode("additive")

    self.particles.h:setPosition(x.h, y)
    love.graphics.draw(self.particles.h, 0, 0)

    self.particles.j:setPosition(x.j, y)
    love.graphics.draw(self.particles.j, 0, 0)

    self.particles.k:setPosition(x.k, y)
    love.graphics.draw(self.particles.k, 0, 0)

    self.particles.l:setPosition(x.l, y)
    love.graphics.draw(self.particles.l, 0, 0)

    love.graphics.setColorMode(color_mode)
    love.graphics.setBlendMode(blend_mode)

    love.graphics.push()
    love.graphics.scale(1.0, 0.5)

    love.graphics.setColor(240, 25, 25)
    love.graphics.setInvertedStencil(function()
        love.graphics.circle("fill", x.h, scaledY, stencilRadius, 30)
    end)
    love.graphics.circle("fill", x.h, scaledY, radius, 30)

    love.graphics.setColor(25, 240, 25)
    love.graphics.setInvertedStencil(function()
        love.graphics.circle("fill", x.j, scaledY, stencilRadius, 30)
    end)
    love.graphics.circle("fill", x.j, scaledY, radius, 30)

    love.graphics.setColor(25, 25, 240)
    love.graphics.setInvertedStencil(function()
        love.graphics.circle("fill", x.k, scaledY, stencilRadius, 30)
    end)
    love.graphics.circle("fill", x.k, scaledY, radius, 30)

    love.graphics.setColor(240, 240, 25)
    love.graphics.setInvertedStencil(function()
        love.graphics.circle("fill", x.l, scaledY, stencilRadius, 30)
    end)
    love.graphics.circle("fill", x.l, scaledY, radius, 30)

    love.graphics.setStencil()

    love.graphics.pop()
end

function Repo:beat(songTime)
    local spread = math.pi / 2
    local radialAccelMin = 100
    local radialAccelMax = 300
    local tangentialAccelMin = -200
    local tangentialAccelMax = 200

    self.particles.h:setSpread(spread)
    self.particles.j:setSpread(spread)
    self.particles.k:setSpread(spread)
    self.particles.l:setSpread(spread)

    self.particles.h:setRadialAcceleration(radialAccelMin, radialAccelMax)
    self.particles.j:setRadialAcceleration(radialAccelMin, radialAccelMax)
    self.particles.k:setRadialAcceleration(radialAccelMin, radialAccelMax)
    self.particles.l:setRadialAcceleration(radialAccelMin, radialAccelMax)

    self.particles.h:setTangentialAcceleration(tangentialAccelMin, tangentialAccelMax)
    self.particles.j:setTangentialAcceleration(tangentialAccelMin, tangentialAccelMax)
    self.particles.k:setTangentialAcceleration(tangentialAccelMin, tangentialAccelMax)
    self.particles.l:setTangentialAcceleration(tangentialAccelMin, tangentialAccelMax)

    self.offTime = love.timer.getMicroTime() + self.SPEW_TIME

    self.wubWubFactor.value = self.WUB_WUB_MAGNITUDE
    Timer.tween(self.WUB_WUB_TIME, self.wubWubFactor, {value = 1.0}, 'bounce')
end

return Repo
