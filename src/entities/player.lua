local Player = class("Player", Character)

function Player:initialize(x, y, args)
    local args = args or {}
    Character.initialize(self, assets.img_player, x, y, args)

    self.controllable = true

    self.velocity = { x = 0, y = 0 }
    self.acceleration = 20
    self.speed = 40
end

function Player:moveLeft(dt)
    if self.velocity.x < self.speed then self.velocity.x = self.velocity.x - (self.acceleration * dt) end
end

function Player:moveRight(dt)
    if self.velocity.x < self.speed then self.velocity.x = self.velocity.x + (self.acceleration * dt) end
end

function Player:jump(dt)

end

return Player
