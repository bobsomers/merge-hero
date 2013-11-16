local Class = require "hump.class"
local Vector = require "hump.vector"
local Timer = require "hump.timer"
local constants = require "constants"

local Insultomatic = Class {
    font = love.graphics.newFont("fonts/pricedown.ttf", 72),

    wubWubFactor = {
        value = 1.0
    },
    WUB_WUB_TIME = 0.1,
    WUB_WUB_MAGNITUDE = 25,

    DROP_SHADOW_DISTANCE = 3,

    messages = {
        "maybe i should\noutsource you?",
        "can't handle\nthe pressure?",
        "let's go\ncode monkey!",
    },

    offset = Vector(0, 0),
    direction = Vector(1, 0),

    init = function(self)

    end
}

function Insultomatic:update(dt)
    self.offset.x = self.direction.x * self.wubWubFactor.value
    self.offset.y = self.direction.y * self.wubWubFactor.value
end

function Insultomatic:draw()
    local xMin = 0 + self.offset.x
    local xMax = constants.SCREEN.x + self.offset.x
    local y = 200 + self.offset.y

    love.graphics.setFont(self.font)

    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(self.messages[1],
                         xMin + self.DROP_SHADOW_DISTANCE,
                         y + self.DROP_SHADOW_DISTANCE,
                         xMax + self.DROP_SHADOW_DISTANCE,
                         "center")

    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(self.messages[1], xMin, y, xMax, "center")
end

function Insultomatic:beat(songTime)
    self.direction.x = math.random() * 2 - 1
    self.direction.y = math.random() * 2 - 1
    self.direction:normalize_inplace()

    self.wubWubFactor.value = self.WUB_WUB_MAGNITUDE
    Timer.tween(self.WUB_WUB_TIME, self.wubWubFactor, {value = 1.0}, 'bounce')
end

return Insultomatic
