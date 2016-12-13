local MovingPlatform = class("MovingPlatform")

function MovingPlatform:initialize(size, stops, speed, delay)

    self.movingplatform = true

    local canvas = love.graphics.newCanvas(assets.img_platform:getWidth() * size, assets.img_platform:getHeight())
    local platQuad = love.graphics.newQuad(0, 0, canvas:getWidth(), canvas:getHeight(), assets.img_platform:getWidth(), assets.img_platform:getHeight())
    canvas:renderTo(function() love.graphics.draw(assets.img_platform, platQuad, 0, 0) end)

    self.image = love.graphics.newImage(canvas:newImageData():encode('png'))
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.stops = {}
    for _, v in pairs(stops) do
        table.insert(self.stops, { x = v[1], y = v[2] })
    end

    self.speed = speed
    self.delay = delay
    self.velocity = { x = 0, y = 0 } 
    self.collidable = true
    self.moving = false
    self.direction = true
    self.prevpos = { x = 0, y = 0 }
end

return MovingPlatform
