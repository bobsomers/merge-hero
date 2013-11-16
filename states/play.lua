local Gamestate = require "hump.gamestate"
local Repo = require "entities.repo"
local Background = require "entities.background"

local play = {}

function play:init()

    self.background = Background()
    self.repo = Repo()
end

function play:update(dt)
    self.background:update(dt)
    self.repo:update(dt)
end

function play:draw()
    self.background:draw()
    self.repo:draw()
end

function play:keypressed(key)
    if key == "a" then
        self.background:beat(false)
    elseif key == "s" then
        self.background:beat(true)
    elseif key == "d" then
        self.background:halfBeat()
    end
end

return play
