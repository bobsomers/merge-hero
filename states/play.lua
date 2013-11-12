local Gamestate = require "hump.gamestate"

local play = {}

function play:init()
    love.graphics.setBackgroundColor(20, 20, 45)
end

function play:update(dt)

end

function play:draw()
    love.graphics.print("Hello, world!", 50, 100)
end

return play
