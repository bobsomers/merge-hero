local Gamestate = require "hump.gamestate"
local Repo = require "entities.repo"

local play = {}

function play:init()
    love.graphics.setBackgroundColor(20, 20, 45)
    
    self.repo = Repo()
end

function play:update(dt)
    self.repo:update(dt)
end

function play:draw()
    self.repo:draw()
end

return play
