tiny = require 'ext.tiny'
class = require 'ext.middleclass'
sti = require 'ext.sti'
bump = require 'ext.bump'

assets = {}
assets.img_player = love.graphics.newImage('assets/images/player.png')

TileRendererSystem = require 'src.systems.tilerenderer'
ControllableSystem = require 'src.systems.controllable'
CollidableSystem = require 'src.systems.collidable'
SpriteSystem = require 'src.systems.sprite'
PlatformingSystem = require 'src.systems.platforming'

Character = require 'src.entities.character'
Player = require 'src.entities.player'

World = {}

baton = require 'ext.baton'
Input = baton.new({
    left  = {'key:a', 'key:left'},
    right = {'key:d', 'key:right'},
    jump  = {'key:w', 'key:up'},
})

function love.load()
    World.ecs = tiny.world()
    World.bump = bump.newWorld(16)
    World.map = sti('assets/maps/grid.lua')

    World.ecs:addSystem(TileRendererSystem({hidden = {'collision', 'lighting'}}))
    World.ecs:addSystem(ControllableSystem(Input))
    World.ecs:addSystem(CollidableSystem())
    World.ecs:addSystem(PlatformingSystem())
    World.ecs:addSystem(SpriteSystem())

    player = Player:new(50, 50)
    World.ecs:addEntity(player)
end

function love.update(dt)
    love.window.setTitle('fps: ' .. love.timer.getFPS())
    Input:update()
end

function love.draw()
    local dt = love.timer.getDelta()
    World.ecs:update(dt)
end
