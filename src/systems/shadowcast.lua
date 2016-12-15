local ShadowCastSystem = tiny.processingSystem(class("ShadowCastSystem"))

ShadowCastSystem.filter = tiny.requireAll('shadowcast', 'position', 'width', 'height')

function ShadowCastSystem:onAdd(e)
    e.shadowbody = World.lights:newRectangle(e.position.x + e.width / 2, e.position.y + e.height / 2, e.width, e.height)
end

function ShadowCastSystem:process(e, dt)
    e.shadowbody:setPosition(e.position.x + e.width / 2, e.position.y + e.height / 2)   
end

return ShadowCastSystem
