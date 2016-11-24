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

    e.velocity.x = e.velocity.x * friction
    e.velocity.y = e.velocity.y + gravity

    local goal = { x = 0, y = 0  }

    goal.x = e.position.x + e.velocity.x
    goal.y = e.position.y + e.velocity.y

    e.position.x = goal.x
    e.position.y = goal.y
end

return PlatformingSystem
