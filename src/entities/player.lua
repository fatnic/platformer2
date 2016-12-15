local Player = class("Player", Character)

function Player:initialize(x, y, args)
    local args = args or {}
    Character.initialize(self, assets.img_player, x, y, args)

    self.controllable = true

    self.velocity = { x = 0, y = 0 }
    self.acceleration = 30
    self.speed = 50
    self.jumpheight = 8
    self.collidable = true

    self.isPlayer = true
    self.updatable = true

    -- self.shadowcast = nil
    -- self.light = World.lights:newLight(self.position.x + self.width / 2, self.position.y + self.height / 2, 255, 128, 64, 300)
end

function Player:update(dt)
    -- self.light:setPosition(self.position.x + self.width / 2, self.position.y + self.height / 2)
    -- self.light:setRange(lume.random(300,350))
end

return Player
