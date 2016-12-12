local MovingPlatformSystem = tiny.processingSystem(class("MovingPlatformSystem"))

MovingPlatformSystem.filter = tiny.requireAll('movingplatform')

function MovingPlatformSystem:onAdd(e)
    e.position = scopy(e.stops[1])
    e.prevpos = scopy(e.position)
    table.insert(e.stops, #e.stops, table.remove(e.stops, 1))
end

function MovingPlatformSystem:process(e, dt)

    if not e.moving then

        e.moving = true
        local stop = scopy(e.stops[1])

        table.insert(e.stops, #e.stops, table.remove(e.stops, 1))

        flux.to(e.position, e.speed, { x = stop.x, y = stop.y }):ease('quadinout'):delay(e.delay):oncomplete(function() 
            e.moving = false 
        end):onupdate(function() 
            local vx = e.position.x - e.prevpos.x
            local vy = e.position.y - e.prevpos.y
            e.velocity = { x = vx, y = vy }
            e.prevpos = scopy(e.position)
        end)

    end

end

return MovingPlatformSystem
