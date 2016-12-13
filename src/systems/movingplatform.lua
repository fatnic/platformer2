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

        local speed = stop.speed or 1
        local delay = stop.delay or 1

        table.insert(e.stops, #e.stops, table.remove(e.stops, 1))

        flux.to(e.position, speed, { x = stop.x, y = stop.y }):ease('quadinout'):delay(delay):oncomplete(function() 
            e.moving = false 
            e.velocity = { x = 0, y = 0 }
        end):onupdate(function() 
            local vx = e.position.x - e.prevpos.x
            local vy = e.position.y - e.prevpos.y
            e.velocity = { x = vx, y = vy }
            e.prevpos = scopy(e.position)
        end)

    end

end

return MovingPlatformSystem
