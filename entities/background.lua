local Class = require "hump.class"
local constants = require "constants"

local Background = Class {
    image = love.graphics.newImage("images/particle.png"),
    particles = false,

    SPEW_TIME = 0.05,
    offTime = 0,

    bgColor = {
        r = 35,
        g = 35,
        b = 45
    },

    init = function(self)
        self.particles = love.graphics.newParticleSystem(self.image, 1000)
        self.particles:setEmissionRate(2500)
        self.particles:setSpread(2 * math.pi)
        self.particles:setSpeed(50, 400)
        self.particles:setSizes(0.3, 0.8)
        self.particles:setSizeVariation(1.0)
        self.particles:setEmitterLifetime(-1)
        self.particles:setParticleLifetime(2)
        self.particles:setRadialAcceleration(-200, 200)
        self.particles:setTangentialAcceleration(-400, 400)
    end
}

function Background:update(dt)
    if love.timer.getTime() > self.offTime then
        self.particles:stop()
    end

    self.particles:update(dt)
end

function Background:draw()
    love.graphics.setBackgroundColor(self.bgColor.r,
                                     self.bgColor.g,
                                     self.bgColor.b)

    local blend_mode, alpha_mode = love.graphics.getBlendMode()
    love.graphics.setBlendMode("add", "alphamultiply")
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.particles, 0, 0)
    love.graphics.setBlendMode(blend_mode, alpha_mode)
end

function Background:beat(songTime)
    local intense = false

    -- Song programming controlling particles completely.
    if songTime < 17 or
       (songTime > 34.5 and songTime < 52) or
       (songTime > 139.5 and songTime < 144) or
       (songTime > 161 and songTime < 165.5) then
        return
    end

    -- Song programming controlling intensity.
    if (songTime > 52 and  songTime < 87) or
       (songTime > 122 and songTime < 139.5) or
       (songTime > 165.5 and songTime < 200.5) then
        intense = true
    end

    if intense then
        -- Change background color.
        self.bgColor.r = math.random() * 50
        self.bgColor.g = math.random() * 50
        self.bgColor.b = math.random() * 50
    else
        self.bgColor.r = 35
        self.bgColor.g = 35
        self.bgColor.b = 45
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
    self.offTime = love.timer.getTime() + self.SPEW_TIME
end

function Background:halfBeat(songTime)
    -- Song programming.
    if songTime < 165.8 or songTime > 200.2 then
       return
    end

    -- New particle position.
    self.particles:setPosition(math.random() * constants.SCREEN.x,
                               math.random() * (constants.SCREEN.y - 150))

    -- Do the thing.
    self.particles:start()
    self.offTime = love.timer.getTime() + self.SPEW_TIME
end

return Background
