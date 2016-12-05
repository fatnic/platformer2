tiny = require 'ext.tiny'
class = require 'ext.middleclass'
sti = require 'ext.sti'
bump = require 'ext.bump'
Gamera = require 'ext.gamera'
lume = require 'ext.lume'

TileRendererSystem = require 'src.systems.tilerenderer'
ControllableSystem = require 'src.systems.controllable'
CollidableSystem = require 'src.systems.collidable'
SpriteSystem = require 'src.systems.sprite'
PlatformingSystem = require 'src.systems.platforming'
AISystem = require 'src.systems.ai'

Character = require 'src.entities.character'
Player = require 'src.entities.player'
Enemy = require 'src.entities.enemy'

assets = require 'assets'

World = {}

baton = require 'ext.baton'
Input = baton.new({
    left  = {'key:a', 'key:left'},
    right = {'key:d', 'key:right'},
    jump  = {'key:w', 'key:up'},
})

function love.load()
    World.ecs  = tiny.world()
    World.bump = bump.newWorld(16)
    World.map  = sti('assets/maps/grid.lua')

    World.ecs:addSystem(TileRendererSystem())
    World.ecs:addSystem(ControllableSystem(Input))
    World.ecs:addSystem(PlatformingSystem())
    World.ecs:addSystem(CollidableSystem())
    World.ecs:addSystem(SpriteSystem())
    World.ecs:addSystem(AISystem())

    player = Player:new(50, 50)
    World.ecs:addEntity(player)

    for i = 1, 5 do
        enemy = Enemy:new(lume.random(World.map.totalwidth), 0)
        World.ecs:addEntity(enemy)
    end

    World.camera = Gamera.new(0, 0, World.map.totalwidth, World.map.totalheight)
end

function love.update(dt)
    love.window.setTitle('fps: ' .. love.timer.getFPS())
    Input:update()
    World.camera:setPosition(player.position.x, player.position.y)
end

function love.draw()
    local dt = love.timer.getDelta()
    World.camera:draw(function(l,r,w,h) 
        World.ecs:update(dt)
    end)
end
