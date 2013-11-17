local Class = require "hump.class"
local Vector = require "hump.vector"
local Timer = require "hump.timer"
local constants = require "constants"

local Scoreboard = Class {
    font = love.graphics.newFont("fonts/pricedown.ttf", 72),

    wubWubFactor = {
        value = 1.0
    },
    WUB_WUB_TIME = 0.1,
    WUB_WUB_MAGNITUDE = 25,

    DROP_SHADOW_DISTANCE = 3,

    offset = Vector(0, 0),
    direction = Vector(1, 0),

    score = 0,

    color = {r = 255, g = 255, b = 255}
}

function Scoreboard:update(dt)
    self.offset.x = self.direction.x * self.wubWubFactor.value
    self.offset.y = self.direction.y * self.wubWubFactor.value
end

function Scoreboard:draw()
    local xMin = 0 + self.offset.x
    local xMax = constants.SCREEN.x + self.offset.x
    local y = 20 + self.offset.y

    love.graphics.setFont(self.font)

    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(tostring(self.score),
                         xMin + self.DROP_SHADOW_DISTANCE,
                         y + self.DROP_SHADOW_DISTANCE,
                         xMax + self.DROP_SHADOW_DISTANCE,
                         "center")

    love.graphics.setColor(self.color.r, self.color.g, self.color.b)
    love.graphics.printf(tostring(self.score), xMin, y, xMax, "center")
end

function Scoreboard:beat(songTime)
    self.direction.x = math.random() * 2 - 1
    self.direction.y = math.random() * 2 - 1
    self.direction:normalize_inplace()

    self.wubWubFactor.value = self.WUB_WUB_MAGNITUDE
    Timer.tween(self.WUB_WUB_TIME, self.wubWubFactor, {value = 1.0}, 'bounce')
end

function Scoreboard:add(amount)
    self.score = self.score + amount
end

function Scoreboard:remove(amount)
    self.score = self.score - amount
    self.color.g = 50
    self.color.b = 50
    Timer.tween(0.5, self.color, {g = 255, b = 255}, "cubic")
end

return Scoreboard
