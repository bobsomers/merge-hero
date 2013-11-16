local Gamestate = require "hump.gamestate"

local recbeats = {}

function recbeats:init()
    love.graphics.setBackgroundColor(65, 25, 25)
    self.soundtrack = love.audio.newSource("level1.mp3", "static")
end

function recbeats:enter(previous)
    self.countdown = 10.0
    self.beats = {}
    self.nextbeat = 1
    self.done = false

    self.songStartTime = 0
end

function recbeats:update(dt)
    if self.countdown > 0 then
        self.countdown = self.countdown - dt
        if self.countdown <= 0 then
            self.songStartTime = love.timer.getMicroTime()
            love.audio.play(self.soundtrack)
        end
    end
end

function recbeats:draw()
    if self.done then
        love.graphics.print("Recording finished.", 50, 100)
    elseif self.countdown > 0 then
        love.graphics.print(string.format("Recording beat track in %.2f...", self.countdown), 50, 100)
    else
        love.graphics.print(string.format("Recording beat track at %.2f...", love.timer.getMicroTime() - self.songStartTime), 50, 100)
    end
end

function recbeats:keypressed(key)
    if key == " " then
        self.beats[self.nextbeat] = love.timer.getMicroTime() - self.songStartTime
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

function recbeats:savetrack()
    local data = [[
local beats = {
]]

    for _, beattime in ipairs(self.beats) do
        data = data .. string.format("    %f,\n", beattime)
    end

    data = data .. [[
}

return beats
]]

    return love.filesystem.write("beats.lua", data)
end

--[[
function recbeats:interpolate()
    print("Interpolating beats.")

    self.eighths = {}
    self.nexteighth = 1
    self.sixteenths = {}
    self.nextsixteeth = 1

    for i, beattime in ipairs(self.beats) do
        if i < self.nextbeat - 1 then
            local difference = self.beats[i + 1] - beattime

            self.eighths[self.nexteighth] = beattime
            self.eighths[self.nexteighth + 1] = beattime + (difference / 2)
            self.nexteighth = self.nexteighth + 2

            self.sixteenths[self.nextsixteeth] = beattime
            self.sixteenths[self.nextsixteeth + 1] = beattime + (difference / 4)
            self.sixteenths[self.nextsixteeth + 2] = beattime + (difference / 2)
            self.sixteenths[self.nextsixteeth + 3] = beattime + (3 * difference / 4)
            self.nextsixteeth = self.nextsixteeth + 4
        end
    end
end
--]]

return recbeats
