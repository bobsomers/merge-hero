local Class = require "hump.class"
local Timer = require "hump.timer"
local constants = require "constants"

local OhSnap = Class {
    font = love.graphics.newFont("fonts/pricedown.ttf", 700),

    SHOW_TIME = 4,

    x = {
        value = 620
    },

    init = function(self)
        Timer.add(37.5, function()
            Timer.tween(self.SHOW_TIME, self.x, {value = -3100}, "linear")
        end)
    end
}

function OhSnap:update(dt)
end

function OhSnap:draw(songTime)
    love.graphics.setFont(self.font)
    love.graphics.setColor(20, 20, 35)
    love.graphics.print("OHHH SNAP", self.x.value, -100)
end

return OhSnap
