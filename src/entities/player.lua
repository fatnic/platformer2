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

end

function Player:update(dt)
end

return Player
