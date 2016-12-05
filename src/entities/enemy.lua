local Enemy = class("Enemy", Character)

function Enemy:initialize(x, y, args)
    local args = args or {}
    Character.initialize(self, assets.img_enemy, x, y, args)

    self.velocity = { x = 0, y = 0 }
    self.acceleration = 20
    self.speed = 40
    self.jumpheight = 6
    self.collidable = true

    self.isEnemy = true
    self.hasAI = true

    self.direction = lume.randomchoice({-1, 1}) 
end

return Enemy
