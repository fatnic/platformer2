local PlatformingSystem = tiny.processingSystem(class("PlatformingSystem"))

PlatformingSystem.filter = tiny.requireAll('velocity', 'acceleration', 'position', 'speed')

function PlatformingSystem:initialize(args)
    local args = args or {}
    self.gravity = args.gravity or 0.3
    self.friction = args.friction or 0.8
    self.airresistance = args.airresistance or 0.84
end

function PlatformingSystem:process(e, dt)
    local friction = e.friction or self.friction
    local airresistance = e.airresistance or self.airresistance
    local gravity = e.gravity or self.gravity

    local colFilter = function(item, other)
        if other.isEnemy then return 'cross' end
        if other.isPlayer then return 'cross' end
        return 'slide'
    end

    e.collisions = { x = 0, y = 0 }

    if e.grounded then 
        e.velocity.x = e.velocity.x * friction
    else
        e.velocity.x = e.velocity.x * airresistance
    end

    e.velocity.y = e.velocity.y + gravity

    goal = { x = 0, y = 0  }

    goal.x = e.position.x + e.velocity.x
    goal.y = e.position.y + e.velocity.y

    if goal.x ~= e.position.x or goal.y ~= e.position.y then

        actual = { x = 0, y = 0 }
        actual.x, actual.y, cols, len = World.bump:check(e, goal.x, goal.y, colFilter)
        e.position.x, e.position.y = actual.x, actual.y
        World.bump:update(e, e.position.x, e.position.y)

        for _, c in pairs(cols) do

            if e.isEnemy and c.other.isPlayer then break end
            if e.isPlayer and c.other.isEnemy then break end
            if e.isEnemy and c.other.isEnemy then break end

            e.collisions.x = c.normal.x
            e.collisions.y = c.normal.y

            if c.normal.y == -1 then
                e.jumping = false
                e.grounded = true
                e.velocity.y = 0
            elseif c.normal.y == 1 then
                e.velocity.y = 0
            end

            if c.other.properties and c.other.properties.jumpboost then
                e.velocity.y = -e.jumpheight * 1.6
                e.jumping = true
                e.grounded = false
            end
        end

    end
end

return PlatformingSystem
