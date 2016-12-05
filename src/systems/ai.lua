local AISystem = tiny.processingSystem(class("AISystem"))

AISystem.filter = tiny.requireAll('hasAI')

function AISystem:process(e, dt)

    future = { x = 0, y = 0  }
    local ahead = lume.sign(e.velocity.x) * 32

    future.x = e.position.x + e.velocity.x + ahead
    future.y = e.position.y + e.velocity.y

    if future.x ~= e.position.x or future.y ~= e.position.y then

        actual = { x = 0, y = 0 }
        actual.x, actual.y, cols, len = World.bump:check(e, future.x, future.y, colFilter)

        for _, c in pairs(cols) do
            if not c.other.isEnemy or not c.other.isPlayer then
                if c.normal.x ~= 0 then e:jump(dt) end
            end
        end

    end

    if e.collisions.x ~= 0 then e.direction = e.collisions.x end
    
    if e.direction == -1 then e:moveLeft(dt) end
    if e.direction ==  1 then e:moveRight(dt) end

end

return AISystem
