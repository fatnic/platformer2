local Character = class("Character")

function Character:initialize(image, x, y, args)
    local args = args or {}
    self.image = image
    self.position = { x = x or 0, y = y or 0 }
    self.rotation = args.rotation or 0
    self.scale = args.scale or { x = 1, y = 1 }
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.velocity = { x = 0, y = 0 }
    self.acceleration = 20
    self.speed = 40
    self.jumpheight = 5
    self.collidable = true

    self.jumping = false
    self.grounded = false

    self.uuid = lume.uuid()

    self.collisions = { x = 0, y = 0 }
end

function Character:moveLeft(dt)
    if self.velocity.x < self.speed then self.velocity.x = self.velocity.x - (self.acceleration * dt) end
end

function Character:moveRight(dt)
    if self.velocity.x < self.speed then self.velocity.x = self.velocity.x + (self.acceleration * dt) end
end

function Character:jump(dt)
    if not self.jumping and self.grounded then
        self.jumping = true
        self.grounded = false
        self.velocity.y = -self.jumpheight
    end
end

return Character
