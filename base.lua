local base = {}

function base:load()
    self.img = love.graphics.newImage('assets/sprites/base.png')
    self.x = 0
    self.y = love.graphics.getHeight() - self.img:getHeight() * Scale
    self.speed = 220
end

function base:moveLeft(dt)
    if self.x <= 288 * 1.6 - self.img:getWidth() * Scale then
        self.x = 0
    end
    self.x = self.x - self.speed * dt
end

function base:update(dt)
    self:moveLeft(dt)
end

function base:draw()
    love.graphics.draw(self.img, self.x, self.y, 0, Scale, Scale)
end

return base
