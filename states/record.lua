local Gamestate = require "hump.gamestate"

local record = {}

function record:init()
    love.graphics.setBackgroundColor(65, 25, 25)
    self.soundtrack = love.audio.newSource("level1.mp3", "static")
end

function record:enter(previous)
    self.countdown = 10.0
    self.beats = {}
    self.nextbeat = 1
    self.done = false

    self.songStartTime = 0
end

function record:update(dt)
    if self.countdown > 0 then
        self.countdown = self.countdown - dt
        if self.countdown <= 0 then
            self.songStartTime = love.timer.getTime()
            love.audio.play(self.soundtrack)
        end
    end
end

function record:draw()
    if self.done then
        love.graphics.print("Recording finished.", 50, 100)
    elseif self.countdown > 0 then
        love.graphics.print(string.format("Recording beat track in %.2f...", self.countdown), 50, 100)
    else
        love.graphics.print(string.format("Recording beat track at %.2f...", love.timer.getTime() - self.songStartTime), 50, 100)
    end
end

function record:keypressed(key)
    if key == " " then
        self.beats[self.nextbeat] = love.timer.getTime() - self.songStartTime
        self.nextbeat = self.nextbeat + 1
        print("BEAT")
    elseif key == "escape" then
        print("Stopping audio.")
        love.audio.stop(self.soundtrack)
        
        print("Saving beat track.")
        if self:savetrack() then
            print("Saved as " .. love.filesystem.getSaveDirectory() .. "/beats.lua.")
        else
            print("Failed to save!")
        end

        self.done = true
    end
end

function record:savetrack()
    local data = [[
local track = {
]]

    for _, beattime in ipairs(self.beats) do
        data = data .. string.format("    %f,\n", beattime)
    end

    data = data .. [[
}

return track
]]

    return love.filesystem.write("track.lua", data)
end

return record
