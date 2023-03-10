local bird = require('bird')
local base = require('base')
local pipes = require('pipes')
local banners = require('banners')
local sound = require('sound')

local backgrounds = {
    love.graphics.newImage('assets/sprites/background-night.png'),
    love.graphics.newImage('assets/sprites/background-day.png'),
}

function love.load()
    math.randomseed(os.time())
    Background = backgrounds[math.random(2)]
    Gameover = false
    Waiting = true
    Score = 0
    BirdIsPassing = false
    BirdWasPassing = false
    bird:load()
    base:load()
    pipes:load()
end

function love.keypressed(key)
    if (key == 'space' or key == 'j') and Waiting then
        Waiting = false
        sound:playSwooshSound()
    end

    if (key == 'space' or key == 'j') and not Gameover then
        bird.jumping = true
    elseif key == 'return' and Gameover then
        love.load()
        sound:playSwooshSound()
    end

    if key == 'escape' or key == 'q' then
        love.event.quit()
    end
end

local function updateScore()
    if BirdIsPassing then
        if not BirdWasPassing then
            sound:playPointSound()
            Score = Score + 1
        end
    end
    BirdWasPassing = BirdIsPassing
end

local function checkPassing()
    for i = 1, #pipes.pipes do
        if bird.x >= pipes.pipes[i].top.x and bird.x + bird.width <= pipes.pipes[i].top.x + pipes.pipes[i].top.width then
            BirdIsPassing = true
            return
        end
    end
    BirdIsPassing = false
end

function love.update(dt)
    if Waiting then
        bird:waiting(dt)
        return
    end
    if not Gameover then
        checkPassing()
        updateScore()
        Gameover = bird:isCollidingWPipes(pipes.pipes) or bird:isCollidingWBase()
        if Gameover then
            sound:playDieSound()
        end
        base:update(dt)
        pipes:update(dt)
    end
    bird:update(dt)
end

function love.draw()
    love.graphics.draw(Background, 0, 0, 0, Scale, Scale)
    pipes:draw()
    base:draw()
    bird:draw()


    if Waiting then
        banners:waiting()
    else
        banners:score(Score)
    end


    if Gameover then
        banners:gameover()
    end
end
