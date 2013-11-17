local Class = require "hump.class"
local Vector = require "hump.vector"
local Timer = require "hump.timer"
local constants = require "constants"

local Grade = Class {
    font = love.graphics.newFont("fonts/pricedown.ttf", 120),

    DROP_SHADOW_DISTANCE = 3,

    percent = false,
    grade = false,

    gradePos = Vector(-1000, 250),
    percentPos = Vector(620, 350),

    init = function(self, scoreboard)
        self.scoreboard = scoreboard
    end
}

function Grade:update(dt)
end

function Grade:draw(songTime)
    if songTime < 200.5 then
        return
    end

    if not self.percent then
        self.percent = ((self.scoreboard.score + 7090) / 16720) * 100
        if self.percent > 97 then
            self.grade = "A+"
        elseif self.percent > 93 then
            self.grade = "A"
        elseif self.percent > 90 then
            self.grade = "A-"
        elseif self.percent > 87 then
            self.grade = "B+"
        elseif self.percent > 83 then
            self.grade = "B"
        elseif self.percent > 80 then
            self.grade = "B-"
        elseif self.percent > 77 then
            self.grade = "C+"
        elseif self.percent > 73 then
            self.grade = "C"
        elseif self.percent > 70 then
            self.grade = "C-"
        elseif self.percent > 67 then
            self.grade = "D+"
        elseif self.percent > 63 then
            self.grade = "D"
        elseif self.percent > 60 then
            self.grade = "D-"
        else
            self.grade = "F"
        end

        Timer.tween(1.5, self.gradePos, {x = 100}, "bounce")
        Timer.tween(1.5, self.percentPos, {x = 110}, "bounce")
    end

    love.graphics.setFont(self.font)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Grade " .. self.grade, self.gradePos.x + self.DROP_SHADOW_DISTANCE, self.gradePos.y + self.DROP_SHADOW_DISTANCE)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Grade " .. self.grade, self.gradePos.x, self.gradePos.y)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print(string.format("%.2f%%", self.percent), self.percentPos.x + self.DROP_SHADOW_DISTANCE, self.percentPos.y + self.DROP_SHADOW_DISTANCE)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(string.format("%.2f%%", self.percent), self.percentPos.x, self.percentPos.y)
end

return Grade
