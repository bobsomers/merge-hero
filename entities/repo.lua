local Class = require "hump.class"
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

    image = love.graphics.newImage("images/particle.png"),

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
    self.particles.h:update(dt)
    self.particles.j:update(dt)
    self.particles.k:update(dt)
    self.particles.l:update(dt)
end

function Repo:draw()
    local y = (constants.SCREEN.y - 100)
    local scaledY = y * 2
    local radius = 50
    local stencilRadius = 42
    local spacing = (constants.SCREEN.x - (8 * radius)) / 5


    local x = {
        h = spacing + radius,
        j = 2 * spacing + 3 * radius,
        k = 3 * spacing + 5 * radius,
        l = 4 * spacing + 7 * radius
    }

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

return Repo
