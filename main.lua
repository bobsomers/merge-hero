local Gamestate = require "hump.gamestate"
local Timer = require "hump.timer"

local play = require "states.play"

function love.load()
    math.randomseed(os.time())

    Gamestate.registerEvents()
    Gamestate.switch(play)
end

function love.update(dt)
    Timer.update(dt)
end
