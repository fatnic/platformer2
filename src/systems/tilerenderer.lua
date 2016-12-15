local TileRendererSystem = tiny.system(class("TileRendererSystem"))

function TileRendererSystem:initialize(args)
    local args = args or {}

    -- hide object layers
    local hidden = {'collision', 'movingplatforms', 'lighting'}
    for _, l in pairs(hidden) do 
        if World.map.layers[l] then
            World.map.layers[l].visible = false 
        end
    end

    -- create collisions and shadows
    local collisions = World.map.layers['collision'].objects
    for _, c in pairs(collisions) do
        World.bump:add({properties = c.properties}, c.x, c.y, c.width, c.height)
        World.lights:newRectangle(c.x + c.width / 2, c.y + c.height / 2, c.width, c.height - 2)
    end

    -- add lighting
    local lighting = World.map.layers['lighting'].objects
    for _, c in pairs(lighting) do
        local _, r, g, b = colorise.hex2rgba(c.properties.color)
        World.lights:newLight(c.x, c.y, r, g, b, c.properties.radius)
    end

    -- generate moving platforms
    local movingplatforms = World.map.layers['movingplatforms'].objects
    local mp = {}
    for _, c in pairs(movingplatforms) do
        local speed = c.properties.speed or nil
        local delay = c.properties.delay or nil
        if mp[c.properties.name] == nil then mp[c.properties.name] = { width = c.width, height = c.height, stops = {} } end
        mp[c.properties.name]['stops'][c.properties.stop] = { stop = c.properties.stop, x = c.x, y = c.y, speed = speed, delay = delay }
    end
    for _, s in pairs(mp) do
        local p = MovingPlatform:new(s.width, s.height, 2, 1)
        for _, stop in pairs(s.stops) do p:addStop(stop.x, stop.y, stop.speed, stop.delay) end
        World.ecs:addEntity(p)
    end

    World.map.totalwidth = World.map.width * World.map.tilewidth
    World.map.totalheight = World.map.height * World.map.tileheight
end

function TileRendererSystem:update(dt)
    World.map:draw()
end

return TileRendererSystem
