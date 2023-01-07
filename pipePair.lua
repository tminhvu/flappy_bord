local base = require "base"
local bird = require "bird"

PipePair = {
    img = nil,
    width = 0,
    gap = 0,
    top = {
        x = 0,
        y = 0,
        height = 0,
        width = 0
    },
    bottom = {
        x = 0,
        y = 0,
        height = 0,
        width = 0
    },
    debug = false
}

function PipePair:new(index, pipeImage)
    local o = {}
    setmetatable(o, { __index = self })

    o.img = pipeImage
    o.width = o.img:getWidth() * Scale

    o.gap = bird.height * 4
    o.gapBetweenPairs = o.width * 3.2

    o.top = {
        x = love.graphics.getWidth() + o.gapBetweenPairs * index,
        y = 0,
        height = math.random(110, 390),
        width = o.width
    }

    o.bottom = {
        x = o.top.x,
        y = o.top.height + o.gap,
        height = base.y - o.top.height - o.gap,
        width = o.width
    }

    o.debug = false

    return o
end

function PipePair:update(dt)
    if self.top.x <= -self.width then
        self.top.x = self.top.x + self.gapBetweenPairs * 5
        self.top.height = math.random(110, 390)

        self.bottom.x = self.top.x
        self.bottom.y = self.top.height + self.gap
        self.bottom.height = base.y - self.top.height - self.gap
    end
    self.top.x = self.top.x - base.speed * dt
    self.bottom.x = self.bottom.x - base.speed * dt
end

function PipePair:draw()
    love.graphics.draw(self.img, self.top.x, self.top.height, 0, Scale, -Scale)

    love.graphics.draw(self.img, self.bottom.x, self.bottom.y, 0, Scale, Scale)

    if self.debug then
        love.graphics.rectangle('line', self.top.x, self.top.y, self.width, self.top.height)
        love.graphics.rectangle('line', self.bottom.x, self.bottom.y, self.width, self.bottom.height)
    end
end

function PipePair:topContainsPoint(pointX, pointY)
    return pointX > self.top.x and pointX < self.top.x + self.top.width and
        pointY < self.top.height
end

function PipePair:bottomContainsPoint(pointX, pointY)
    return pointX > self.bottom.x and
        pointX < self.bottom.x + self.bottom.width and pointY > self.bottom.y
end
