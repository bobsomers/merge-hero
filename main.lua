local Gamestate = require "hump.gamestate"
local Timer = require "hump.timer"

local play = require "states.play"
local recbeats = require "states.recbeats"
local playbeats = require "states.playbeats"

function love.load()
    math.randomseed(os.time())

    Gamestate.registerEvents()
    Gamestate.switch(playbeats)
end

function love.update(dt)
    Timer.update(dt)
end
