local base = require "base"
local Bird = {}

local birdAssets = {
    {
        love.graphics.newImage('assets/sprites/bluebird-upflap.png'),
        love.graphics.newImage('assets/sprites/bluebird-midflap.png'),
        love.graphics.newImage('assets/sprites/bluebird-downflap.png')
    },
    {
        love.graphics.newImage('assets/sprites/redbird-upflap.png'),
        love.graphics.newImage('assets/sprites/redbird-midflap.png'),
        love.graphics.newImage('assets/sprites/redbird-downflap.png')
    },
    {
        love.graphics.newImage('assets/sprites/yellowbird-upflap.png'),
        love.graphics.newImage('assets/sprites/yellowbird-midflap.png'),
        love.graphics.newImage('assets/sprites/yellowbird-downflap.png')
    }
}

function Bird:load()
    self.color = math.random(3)
    self.img = birdAssets[self.color][2]

    self.x = love.graphics.getWidth() * 0.2 + self.img:getWidth() / 2
    self.y = (love.graphics.getHeight() - self.img:getHeight() * Scale) / 2

    self.height = self.img:getHeight() * Scale
    self.width = self.img:getWidth() * Scale

    self.originalY = self.y
    self.waitingBounceDirection = 1
    self.waitingBounceDistance = self.height / 5
    self.waitingBounceSpeed = 45

    self.flapSpeed = 9
    self.flapDirection = 1
    self.flapPosition = 2
    self.flapDelay = 1

    self.flyFallConstant = 1400
    self.flyVertSpeed = 0
    self.flyJumpSpeed = -420

    self.rotateAngle = 0
    self.rotateSpeed = 3

    self.rotateUpSpeed = self.rotateSpeed * 4
    self.rotateDownSpeed = self.rotateSpeed / 2

    self.maxUpAngle = -0.3
    self.maxDownAngle = 1

    self.jumping = false

    self.debug = false
end

function Bird:flap(dt)
    if self.flapDelay > 1 then
        self.img = birdAssets[self.color][self.flapPosition]

        self.flapPosition = self.flapPosition + self.flapDirection

        if self.flapPosition == 3 or self.flapPosition == 1 then
            self.flapDirection = self.flapDirection * (-1)
        end

        self.flapDelay = 0
    end
    self.flapDelay = self.flapDelay + self.flapSpeed * dt
end

--[[
 vertSpeed = 0;
 method Update()
 {
      if (PlayerTappedScreen)
      {
             vertSpeed = jumpSpeed;
      }
      Position.Y += vertSpeed * deltaTime;
      vertSpeed -= fallingConstant * deltaTime;
 }
--]]

function Bird:jump(_)
    self.flyVertSpeed = self.flyJumpSpeed
end

function Bird:fall(dt)
    self.y = self.y + self.flyVertSpeed * dt
    self.flyVertSpeed = self.flyVertSpeed + self.flyFallConstant * dt
end

function Bird:rotate(dt)
    if self.flyVertSpeed < 0 then
        if self.rotateAngle > self.maxUpAngle then
            self.rotateAngle = self.rotateAngle - self.rotateUpSpeed * dt
        end
    elseif self.flyVertSpeed > self.img:getHeight() * Scale * 2 then
        if self.rotateAngle < self.maxDownAngle then
            self.rotateAngle = self.rotateAngle + self.rotateDownSpeed * dt
        end
    end
end

function Bird:rotateUp()
    self.rotateSpeed = math.abs(self.rotateSpeed) * -1
end

function Bird:update(dt)
    if self.y + self.height < base.y then
        self:flap(dt)

        if self.jumping then
            self:jump(dt)
        end

        self:fall(dt)

        self.jumping = false
    end
    self:rotate(dt)
end

function Bird:waiting(dt)
    self:flap(dt)

    self.y = self.y + self.waitingBounceSpeed * dt * self.waitingBounceDirection

    if self.y >= self.originalY + self.waitingBounceDistance then
        self.waitingBounceDirection = -1
    elseif self.y <= self.originalY - self.waitingBounceDistance then
        self.waitingBounceDirection = 1
    end
end

function Bird:isCollidingWPipes(pipePair)
    for i = 1, #pipePair do
        local top = pipePair[i]:topContainsPoint(self.x + self.width, self.y) or
            pipePair[i]:topContainsPoint(self.x, self.y)
        local bottom = pipePair[i]:bottomContainsPoint(self.x + self.width, self.y + self.height) or
            pipePair[i]:bottomContainsPoint(self.x, self.y + self.height)

        if top or bottom then
            return true
        end
    end
    return false
end

function Bird:isCollidingWBase()
    return self.y + self.height >= base.y
end

function Bird:draw()
    love.graphics.draw(self.img,
        self.x + self.width / 2,
        self.y + self.height / 2,
        self.rotateAngle,
        Scale, Scale,
        self.img:getWidth() / 2,
        self.img:getHeight() / 2)

    if self.debug then
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    end
end

return Bird
