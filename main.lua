local Gamestate = require "hump.gamestate"
local Timer = require "hump.timer"

local title = require "states.title"
local record = require "states.record"

function love.load()
    math.randomseed(os.time())

    Gamestate.registerEvents()
    Gamestate.switch(title)
end

function love.update(dt)
    Timer.update(dt)
end
