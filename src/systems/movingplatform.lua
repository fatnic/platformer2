local MovingPlatformSystem = tiny.processingSystem(class("MovingPlatformSystem"))

MovingPlatformSystem.filter = tiny.requireAll('movingplatform')

function MovingPlatformSystem:onAdd(e)
    e.position = e.stops[1]
    table.insert(e.stops, #e.stops, table.remove(e.stops, 1))
end

function MovingPlatformSystem:process(e, dt)

    if not e.moving then

        e.moving = true

        Timer.after(e.delay, function() 
            Timer.tween(e.speed, e.position, { x = e.stops[1].x, y = e.stops[1].y }, 'linear', function() 
                -- why isnt this rotatiing within the tween???? try a different library
                table.insert(e.stops, #e.stops, table.remove(e.stops, 1))
                e.moving = false
            end) 
        end)

    end

    --  calculate x velocity for entity calc
end

return MovingPlatformSystem
