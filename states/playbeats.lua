local Gamestate = require "hump.gamestate"
local Timer = require "hump.timer"
local Vector = require "hump.vector"
local beats = require "beats"

local playbeats = {}

function playbeats:init()
    love.graphics.setBackgroundColor(25, 65, 25)
    self.soundtrack = love.audio.newSource("level1.mp3", "static")
    self.beats = beats
    self.nextbeat = 1
    self.lastbeat = #self.beats
    self:interpolate()

    self.beatcircle = {
        pos = Vector(100, 250),
        radius = 10
    }

    self.eighthcircle = {
        {
            pos = Vector(200, 200),
            radius = 10
        },
        {
            pos = Vector(200, 300),
            radius = 10
        }
    }

    self.sixteenthcircle = {
        {
            pos = Vector(300, 200),
            radius = 10
        },
        {
            pos = Vector(400, 200),
            radius = 10
        },
        {
            pos = Vector(300, 300),
            radius = 10
        },
        {
            pos = Vector(400, 300),
            radius = 10
        }
    }
end

function playbeats:enter(previous)
    self.playing = false
    self.nextbeat = 1
    self.lastbeat = #self.beats
    self.nexteighth = 1
    self.lasteighth = #self.eighths
    self.nextsixteeth = 1
    self.lastsixteenth = #self.sixteenths
end

function playbeats:update(dt)
    if not self.playing then
        self.playing = true
        self.songtime = 0.0
        love.audio.play(self.soundtrack)
        return
    end

    self.songtime = self.songtime + dt

    if self.songtime >= self.beats[self.nextbeat] then
        print(string.format("Beat #%d @ %.4f.", self.nextbeat, self.beats[self.nextbeat]))

        self.beatcircle.radius = 50
        Timer.tween(0.2, self.beatcircle, {radius = 10}, 'bounce')

        if self.nextbeat < self.lastbeat then
            self.nextbeat = self.nextbeat + 1
        end
    end

    if self.songtime >= self.eighths[self.nexteighth] then
        local which = ((self.nexteighth - 1) % 2) + 1

        self.eighthcircle[which].radius = 35
        Timer.tween(0.2, self.eighthcircle[which], {radius = 10}, 'bounce')

        if self.nexteighth < self.lasteighth then
            self.nexteighth = self.nexteighth + 1
        end
    end

    if self.songtime >= self.sixteenths[self.nextsixteeth] then
        local which = ((self.nextsixteeth - 1) % 4) + 1

        self.sixteenthcircle[which].radius = 20
        Timer.tween(0.2, self.sixteenthcircle[which], {radius = 10}, 'bounce')

        if self.nextsixteeth < self.lastsixteenth then
            self.nextsixteeth = self.nextsixteeth + 1
        end
    end
end

function playbeats:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print(string.format("Playing beat track at %.2f...", self.songtime), 50, 100)
    
    love.graphics.setColor(180, 25, 25)
    love.graphics.circle("fill", self.beatcircle.pos.x, self.beatcircle.pos.y,
                         self.beatcircle.radius, 30)

    love.graphics.setColor(25, 180, 25)
    love.graphics.circle("fill", self.eighthcircle[1].pos.x, self.eighthcircle[1].pos.y,
                         self.eighthcircle[1].radius, 30)
    love.graphics.circle("fill", self.eighthcircle[2].pos.x, self.eighthcircle[2].pos.y,
                         self.eighthcircle[2].radius, 30)

    love.graphics.setColor(25, 25, 180)
    love.graphics.circle("fill", self.sixteenthcircle[1].pos.x, self.sixteenthcircle[1].pos.y,
                         self.sixteenthcircle[1].radius, 30)
    love.graphics.circle("fill", self.sixteenthcircle[2].pos.x, self.sixteenthcircle[2].pos.y,
                         self.sixteenthcircle[2].radius, 30)
    love.graphics.circle("fill", self.sixteenthcircle[3].pos.x, self.sixteenthcircle[3].pos.y,
                         self.sixteenthcircle[3].radius, 30)
    love.graphics.circle("fill", self.sixteenthcircle[4].pos.x, self.sixteenthcircle[4].pos.y,
                         self.sixteenthcircle[4].radius, 30)
end

function playbeats:interpolate()
    self.eighths = {}
    self.nexteighth = 1
    self.sixteenths = {}
    self.nextsixteeth = 1

    for i, beattime in ipairs(self.beats) do
        if i < self.lastbeat then
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

return playbeats
