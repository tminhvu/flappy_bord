local Sound = {}

local jump = love.audio.newSource('assets/audio/wing.wav', 'static')
local point = love.audio.newSource('assets/audio/point.wav', 'static')
local swoosh = love.audio.newSource('assets/audio/swoosh.wav', 'static')
local hit = love.audio.newSource('assets/audio/hit.wav', 'static')
local die = love.audio.newSource('assets/audio/die.wav', 'static')

function Sound:playJumpSound()
    jump:play()
end

function Sound:playPointSound()
    point:play()
end

function Sound:playSwooshSound()
    swoosh:play()
end

function Sound:playHitSound()
    hit:play()
end

function Sound:playDieSound()
    die:play()
end

return Sound
