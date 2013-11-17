local Gamestate = require "hump.gamestate"
local Repo = require "entities.repo"
local Background = require "entities.background"
local Insultomatic = require "entities.insultomatic"
local beats = require "beats"

local play = {}

function play:init()
    self.soundtrack = love.audio.newSource("level1.mp3", "static")
    self.beats = beats
    self.nextBeat = 1
    self.lastBeat = #self.beats
    self:interpolateBeats()

    self.background = Background()
    self.repo = Repo()
    self.insults = Insultomatic()

    self.sourceKey = false
end

function play:enter(previous)
    self.playing = false
    self.nextBeat = 1
    self.lastBeat = #self.beats
    self.nextEighth = 1
    self.lastEighth = #self.eighths
    
    self.songStartTime = 0

    self.sourceKey = false

    self.repo:activate("j", true)
end

function play:update(dt)
    if not self.playing then
        self.playing = true
        self.songStartTime = love.timer.getMicroTime()
        love.audio.play(self.soundtrack)
        return
    end

    local songTime = love.timer.getMicroTime() - self.songStartTime
    if songTime >= self.beats[self.nextBeat] then
        self.background:beat(songTime)
        self.repo:beat(songTime)
        self.insults:beat(songTime)

        if self.nextBeat < self.lastBeat then
            self.nextBeat = self.nextBeat + 1
        end
    end

    if songTime >= self.eighths[self.nextEighth] then
        local which = ((self.nextEighth - 1) % 2) + 1

        self.background:halfBeat(songTime)

        if self.nextEighth < self.lastEighth then
            self.nextEighth = self.nextEighth + 1
        end
    end

    self.background:update(dt)
    self.repo:update(dt)
    self.insults:update(dt)
end

function play:draw()
    local songTime = love.timer.getMicroTime() - self.songStartTime

    self.background:draw()
    self.repo:draw(songTime)
    --self.insults:draw()
end

function play:keypressed(key)
    if key == "h" or key == "j" or key == "k" or key == "l" then
        if not self.sourceKey then
            self.sourceKey = key
        else
            if self.repo.active[self.sourceKey] then
                if self.repo.active[key] then
                    self.repo:merge(self.sourceKey, key)
                else
                    self.repo:branch(self.sourceKey, key)
                end
            end
        end
    end
end

function play:keyreleased(key)
    if key == "h" or key == "j" or key == "k" or key == "l" then
        if self.sourceKey == key then
            self.sourceKey = false
        end
    end
end

function play:interpolateBeats()
    self.eighths = {}
    self.nextEighth = 1

    for i, beatTime in ipairs(self.beats) do
        if i < self.lastBeat then
            local difference = self.beats[i + 1] - beatTime

            self.eighths[self.nextEighth] = beatTime
            self.eighths[self.nextEighth + 1] = beatTime + (difference / 2)
            self.nextEighth = self.nextEighth + 2
        end
    end
end

return play
