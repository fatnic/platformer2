local SpriteSystem = tiny.processingSystem(class "SpriteSystem")

SpriteSystem.filter = tiny.requireAll('image', 'position')

function SpriteSystem:process(e, dt)
    local rot = e.rotation or 0
    local sx, sy = e.scale and e.scale.x or 1, e.scale and e.scale.y or 1
    local ox, oy = e.offset and e.offset.x or 1, e.offset and e.offset.y or 1

    love.graphics.draw(e.image, e.position.x, e.position.y, rot, sx, sy)
end

return SpriteSystem
