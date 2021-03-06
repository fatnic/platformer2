local CollidableSystem = tiny.processingSystem(class("CollidableSystem"))

CollidableSystem.filter = tiny.requireAll('position', 'width', 'height', 'collidable')

function CollidableSystem:onAdd(entity)

    if not entity.hitbox then 
        entity.hitbox = {}
        entity.hitbox.width = entity.width
        entity.hitbox.height = entity.height
        entity.hitbox.offset = { x = 0; y = 0 }
    end

    local offsetx = entity.hitbox.offset and entity.hitbox.offset.x or 0
    local offsety = entity.hitbox.offset and entity.hitbox.offset.y or 0

    World.bump:add(entity, entity.position.x, entity.position.y, entity.hitbox.width + offsetx, entity.hitbox.height + offsety)
end

function CollidableSystem:process(e, dt)
    World.bump:update(e, e.position.x, e.position.y)
end

return CollidableSystem
