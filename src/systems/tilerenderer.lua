local TileRendererSystem = tiny.system(class("TileRendererSystem"))

function TileRendererSystem:initialize(args)
    local args = args or {}

    local hidden = {'collision'}
    for _, l in pairs(hidden) do 
        if World.map.layers[l] then
            World.map.layers[l].visible = false 
        end
    end

    local collisions = World.map.layers['collision'].objects

    for _, c in pairs(collisions) do
        World.bump:add({properties = c.properties}, c.x, c.y, c.width, c.height)
    end

    World.map.totalwidth = World.map.width * World.map.tilewidth
    World.map.totalheight = World.map.height * World.map.tileheight
end

function TileRendererSystem:update(dt)
    World.map:draw()
end

return TileRendererSystem
