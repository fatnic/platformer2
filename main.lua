tiny = require 'ext.tiny'
class = require 'ext.middleclass'
sti = require 'ext.sti'
bump = require 'ext.bump'
colorise = require 'ext.colorise'
lightworld = require 'ext.lightworld'
lume = require 'ext.lume'
flux = require 'ext.flux'

require 'helpers'

TileRendererSystem = require 'src.systems.tilerenderer'
ControllableSystem = require 'src.systems.controllable'
CollidableSystem = require 'src.systems.collidable'
SpriteSystem = require 'src.systems.sprite'
PlatformingSystem = require 'src.systems.platforming'
MovingPlatformSystem = require 'src.systems.movingplatform'
AISystem = require 'src.systems.ai'
UpdatingSystem = require 'src.systems.updating'
ShadowCastSystem = require 'src.systems.shadowcast'

Character = require 'src.entities.character'
Player = require 'src.entities.player'
Enemy = require 'src.entities.enemy'
MovingPlatform = require 'src.entities.movingplatform'

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
    World.lights = lightworld({ ambient = { 50, 50, 50 }, blur = 2 })

    World.ecs:addSystem(ControllableSystem(Input))
    World.ecs:addSystem(TileRendererSystem())
    World.ecs:addSystem(PlatformingSystem())
    World.ecs:addSystem(MovingPlatformSystem())
    World.ecs:addSystem(CollidableSystem())
    World.ecs:addSystem(AISystem())
    World.ecs:addSystem(UpdatingSystem())
    World.ecs:addSystem(SpriteSystem())
    World.ecs:addSystem(ShadowCastSystem())

    player = Player:new(50, 50)
    World.ecs:addEntity(player)

    for i = 1, 5 do
        World.ecs:addEntity(Enemy:new(lume.random(World.map.totalwidth), 0))
    end

    -- World.lights:newLight(250, 150, 255, 128, 64, 300)
    -- World.lights:newLight(700, 440, 255, 0, 0, 300)
end

function love.update(dt)
    love.window.setTitle('fps: ' .. love.timer.getFPS())

    Input:update()
    flux.update(dt)
end

function love.draw()
    local dt = love.timer.getDelta()

    World.lights:draw(function() 
        World.ecs:update(dt)
        World.lights:update(dt)
    end)

end
