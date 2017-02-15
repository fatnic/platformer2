local Enemy = class("Enemy", Character)

function Enemy:initialize(x, y, args)
    local args = args or {}
    Character.initialize(self, assets.img_enemy, x, y, args)

    self.isEnemy = true
    self.hasAI = true
    self.updatable = true

    self.jumpheight = 6

    self.direction = -1

end

function Enemy:update(dt)
end

return Enemy
