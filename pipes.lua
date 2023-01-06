require "pipePair"
local Pipes = {}

local pipes = {
    love.graphics.newImage('assets/sprites/pipe-green.png'),
    love.graphics.newImage('assets/sprites/pipe-red.png'),
}

function Pipes:load()
    self.pipeImage = pipes[math.random(2)]
    self.pipes = {
        PipePair:new(0, self.pipeImage),
        PipePair:new(1, self.pipeImage),
        PipePair:new(2, self.pipeImage),
        PipePair:new(3, self.pipeImage),
        PipePair:new(4, self.pipeImage),
    }
end

function Pipes:update(dt)
    for i = 1, #self.pipes do
        self.pipes[i]:update(dt)
    end
end

function Pipes:draw()
    for _, pipe in pairs(self.pipes) do
        pipe:draw()
    end
end

return Pipes
