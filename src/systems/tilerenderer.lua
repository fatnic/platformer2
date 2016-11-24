local TileRendererSystem = tiny.system(class("TileRendererSystem"))

function TileRendererSystem:initialize(args)
    local args = args or {}

    if args.hidden then
        for _, l in pairs(args.hidden) do World.map.layers[l].visible = false end
    end
end

function TileRendererSystem:update(dt)
    World.map:draw()
end

return TileRendererSystem
