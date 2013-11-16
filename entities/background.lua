local Class = require "hump.class"
local constants = require "constants"

local Background = Class {
    image = love.graphics.newImage("images/particle.png"),
    particles = false,

    SPEW_TIME = 0.05,
    time = 0,
    offTime = 0,
    bgColor = {
        r = 35,
        g = 35,
        b = 35
    },

    init = function(self)
        self.particles = love.graphics.newParticleSystem(self.image, 1000)
        self.particles:setEmissionRate(2500)
        self.particles:setSpread(2 * math.pi)
        self.particles:setSpeed(50, 400)
        self.particles:setSizes(0.3, 0.8)
        self.particles:setSizeVariation(1.0)
        self.particles:setLifetime(-1)
        self.particles:setParticleLife(2)
        self.particles:setRadialAcceleration(-200, 200)
        self.particles:setTangentialAcceleration(-400, 400)
    end
}

function Background:update(dt)
    self.time = self.time + dt

    if self.time > self.offTime then
        self.particles:stop()
    end

    self.particles:update(dt)
end

function Background:draw()
    love.graphics.setBackgroundColor(self.bgColor.r,
                                     self.bgColor.g,
                                     self.bgColor.b)

    local color_mode = love.graphics.getColorMode()
    local blend_mode = love.graphics.getBlendMode()
    love.graphics.setColorMode("modulate")
    love.graphics.setBlendMode("additive")
    love.graphics.draw(self.particles, 0, 0)
    love.graphics.setColorMode(color_mode)
    love.graphics.setBlendMode(blend_mode)
end

function Background:beat(intense)
    if intense then
        -- Change background color.
        self.bgColor.r = math.random() * 50
        self.bgColor.g = math.random() * 50
        self.bgColor.b = math.random() * 50
    else
        self.bgColor.r = 35
        self.bgColor.g = 35
        self.bgColor.b = 35
    end

    -- New particle color.
    local r = math.random() * 200 + 50
    local g = math.random() * 200 + 50
    local b = math.random() * 200 + 50
    self.particles:setColors(r, g, b, 255, r, g, b, 0)

    -- New particle position.
    self.particles:setPosition(math.random() * constants.SCREEN.x,
                               math.random() * (constants.SCREEN.y - 150))

    -- Do the thing.
    self.particles:start()
    self.offTime = self.time + self.SPEW_TIME
end

function Background:halfBeat()
    -- New particle position.
    self.particles:setPosition(math.random() * constants.SCREEN.x,
                               math.random() * (constants.SCREEN.y - 150))

    -- Do the thing.
    self.particles:start()
    self.offTime = self.time + self.SPEW_TIME
end

return Background
