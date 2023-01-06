local Banners = {}

local waiting = {
    img = love.graphics.newImage('assets/sprites/message.png'),
}
waiting.x = love.graphics.getWidth() / 2 - waiting.img:getWidth() * Scale / 2
waiting.y = love.graphics.getHeight() / 2 - waiting.img:getHeight() * Scale / 2 - waiting.img:getHeight() / 2.4

function Banners:waiting()
    love.graphics.draw(waiting.img, waiting.x, waiting.y, 0, Scale)
end

local gameover = {
    img = love.graphics.newImage('assets/sprites/gameover.png'),
}
gameover.x = love.graphics.getWidth() / 2 - gameover.img:getWidth() * Scale / 2
gameover.y = love.graphics.getHeight() / 2 - gameover.img:getHeight() * Scale / 2

function Banners:gameover()
    love.graphics.draw(gameover.img, gameover.x, gameover.y, 0, Scale)
end

local numbers = {
    [0] = love.graphics.newImage('assets/sprites/0.png'),
    [1] = love.graphics.newImage('assets/sprites/1.png'),
    [2] = love.graphics.newImage('assets/sprites/2.png'),
    [3] = love.graphics.newImage('assets/sprites/3.png'),
    [4] = love.graphics.newImage('assets/sprites/4.png'),
    [5] = love.graphics.newImage('assets/sprites/5.png'),
    [6] = love.graphics.newImage('assets/sprites/6.png'),
    [7] = love.graphics.newImage('assets/sprites/7.png'),
    [8] = love.graphics.newImage('assets/sprites/8.png'),
    [9] = love.graphics.newImage('assets/sprites/9.png')
}
numbers.x = love.graphics.getWidth() / 2 -- - numbers[1]:getWidth() * Scale / 2
numbers.y = numbers[1]:getHeight() * 3.5

local function numberToTable(number)
    local numberStr = tostring(number)
    local numberTable = {}

    for i = 1, #numberStr do
        table.insert(numberTable, tonumber(numberStr:sub(i, i)))
    end

    return numberTable
end

function Banners:score(Score)
    local scoreTable = numberToTable(Score)

    for i = 1, #scoreTable do
        love.graphics.draw(numbers[scoreTable[i]],
            -- Offset based on numbers of number and their index
            numbers.x - numbers[1]:getWidth() * Scale * #scoreTable / 2 + (numbers[1]:getWidth() * Scale + 7) * (i - 1),
            numbers.y, 0,
            Scale,
            Scale)
    end
end

return Banners
