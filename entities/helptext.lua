local Class = require "hump.class"
local constants = require "constants"

local HelpText = Class {
    font = love.graphics.newFont("fonts/pricedown.ttf", 42),

    MESSAGE_SPEED = 200,
    DROP_SHADOW_DISTANCE = 3,

    targetY = constants.SCREEN.y - 100,

    messages = {
        {
            x = 20,
            time = 4.3,
            message = "branch >>"
        },
        {
            x = 400,
            time = 8.6,
            message = "<< merge"
        },
        {
            x = 20,
            time = 12.9,
            message = "branch >>"
        },
        {
            x = 20,
            time = 13.5,
            message = "merge >>"
        },
        {
            x = 50,
            time = 16.5,
            message = "good"
        },
        {
            x = 455,
            time = 16.5,
            message = "luck"
        },
    },
    nextMessage = 1
}

function HelpText:update(dt)
end

function HelpText:draw(songTime)
    love.graphics.setFont(self.font)

    local i = self.nextMessage
    while true do
        if not self.messages[i] then
            break
        end

        local deltaT = self.messages[i].time - songTime
        local distance = self.MESSAGE_SPEED * deltaT

        local y = self.targetY - distance

        if y < -50 then
            break
        elseif y > constants.SCREEN.y then
            self.nextMessage = self.nextMessage + 1
        else
            love.graphics.setColor(0, 0, 0)
            love.graphics.print(self.messages[i].message,
                                self.messages[i].x + self.DROP_SHADOW_DISTANCE,
                                y + self.DROP_SHADOW_DISTANCE)

            love.graphics.setColor(255, 255, 255)
            love.graphics.print(self.messages[i].message, self.messages[i].x, y)
        end

        i = i + 1
    end
end

return HelpText
