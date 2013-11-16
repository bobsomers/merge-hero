local Gamestate = require "hump.gamestate"
local Repo = require "entities.repo"
local Background = require "entities.background"
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
end

function play:enter(previous)
    self.playing = false
    self.nextBeat = 1
    self.lastBeat = #self.beats
    self.nextEighth = 1
    self.lastEighth = #self.eighths
    self.nextSixteeth = 1
    self.lastSixteenth = #self.sixteenths
    
    self.songStartTime = 0
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
        if songTime > 17 then
            self.background:beat(true)
        else
            self.background:beat(false)
        end

        if self.nextBeat < self.lastBeat then
            self.nextBeat = self.nextBeat + 1
        end
    end

    if songTime >= self.eighths[self.nextEighth] then
        local which = ((self.nextEighth - 1) % 2) + 1

        -- TODO

        if self.nextEighth < self.lastEighth then
            self.nextEighth = self.nextEighth + 1
        end
    end

    if songTime >= self.sixteenths[self.nextSixteeth] then
        local which = ((self.nextSixteeth - 1) % 4) + 1

        -- TODO

        if self.nextSixteeth < self.lastSixteenth then
            self.nextSixteeth = self.nextSixteeth + 1
        end
    end

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

function play:interpolateBeats()
    self.eighths = {}
    self.nextEighth = 1
    self.sixteenths = {}
    self.nextSixteeth = 1

    for i, beatTime in ipairs(self.beats) do
        if i < self.lastBeat then
            local difference = self.beats[i + 1] - beatTime

            self.eighths[self.nextEighth] = beatTime
            self.eighths[self.nextEighth + 1] = beatTime + (difference / 2)
            self.nextEighth = self.nextEighth + 2

            self.sixteenths[self.nextSixteeth] = beatTime
            self.sixteenths[self.nextSixteeth + 1] = beatTime + (difference / 4)
            self.sixteenths[self.nextSixteeth + 2] = beatTime + (difference / 2)
            self.sixteenths[self.nextSixteeth + 3] = beatTime + (3 * difference / 4)
            self.nextSixteeth = self.nextSixteeth + 4
        end
    end
end

return play
