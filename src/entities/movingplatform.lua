local MovingPlatform = class("MovingPlatform")

function MovingPlatform:initialize(width, height, speed, delay)

    self.movingplatform = true

    local canvas = love.graphics.newCanvas(width, height)
    local platQuad = love.graphics.newQuad(0, 0, canvas:getWidth(), canvas:getHeight(), assets.img_platform:getWidth(), assets.img_platform:getHeight())
    canvas:renderTo(function() love.graphics.draw(assets.img_platform, platQuad, 0, 0) end)

    self.image = love.graphics.newImage(canvas:newImageData():encode('png'))
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.stops = {}

    self.velocity = { x = 0, y = 0 } 
    self.collidable = true
    self.moving = false
    self.direction = true
    self.prevpos = { x = 0, y = 0 }
    self.shadowcast = true
end

function MovingPlatform:addStop(sx, sy, speed, delay)
    table.insert(self.stops, { x = sx, y = sy, speed = speed, delay = delay})
end

return MovingPlatform
