local Gamestate = require "hump.gamestate"
local constants = require "constants"
local play = require "states.play"

local title = {}

function title:init()
    self.titleFont = love.graphics.newFont("fonts/pricedown.ttf", 96)
    self.explainFont = love.graphics.newFont("fonts/pricedown.ttf", 32)

    self.branchImage = love.graphics.newImage("images/branch.png")
    self.mergeImage = love.graphics.newImage("images/merge.png")

    self.enterAlpha = {
        value = 255
    }
end

function title:update(dt)

end

function title:draw()
    love.graphics.setBackgroundColor(35, 35, 45)

    love.graphics.setFont(self.titleFont)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("merge hero", 50, 50)

    love.graphics.setFont(self.explainFont)
    love.graphics.setColor(200, 200, 255)
    love.graphics.print("by bob somers", 277, 142)

    love.graphics.setFont(self.explainFont)
    love.graphics.setColor(255, 255, 255)

    love.graphics.print("collect commits", 150, 230)
    love.graphics.print("avoid feature creep", 100, 280)

    local color = {r = 0, g = 240, b = 0}
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.circle("fill", 420, 250, 15, 20)
    love.graphics.setColor(color.r * 0.3, color.g * 0.3, color.b * 0.3)
    love.graphics.print("c", 420 - 8, 250 - 20)

    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 420 - 15, 300 - 15, 30, 30)
    love.graphics.setColor(color.r * 0.3, color.g * 0.3, color.b * 0.3)
    love.graphics.print("f", 420 - 6, 300 - 20)

    love.graphics.setColor(255, 255, 255)
    love.graphics.print("while holding an active lane key,", 20, 350)
    love.graphics.print("press an inactive lane key to branch", 50, 390)
    love.graphics.print("press an active lane key to merge", 50, 580)

    love.graphics.draw(self.branchImage, 180, 430)
    love.graphics.draw(self.mergeImage, 180, 620)

    local alpha = 255 * (math.sin(2 * math.pi * 0.75 * love.timer.getTime()) + 1) / 2
    love.graphics.setColor(255, 255, 255, alpha)
    love.graphics.print("enter to start >>", 320, 750)
end

function title:keypressed(key)
    if key == "return" then
        Gamestate.switch(play)
    end
end

return title
