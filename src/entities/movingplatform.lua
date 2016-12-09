local MovingPlatform = class("MovingPlatform")

function MovingPlatform:initialize(size, startx, starty, endx, endy, speed, delay)

    self.movingplatform = true

    local canvas = love.graphics.newCanvas(assets.img_platform:getWidth() * size, assets.img_platform:getHeight())
    local platQuad = love.graphics.newQuad(0, 0, canvas:getWidth(), canvas:getHeight(), assets.img_platform:getWidth(), assets.img_platform:getHeight())
    canvas:renderTo(function() love.graphics.draw(assets.img_platform, platQuad, 0, 0) end)

    self.image = love.graphics.newImage(canvas:newImageData():encode('png'))
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.stops = {}
    table.insert(self.stops, { x = startx, y = starty })
    table.insert(self.stops, { x = endx, y = endy })

    self.startpos = self.stops[1]
    self.endpos = self.stops[2]

    self.speed = speed
    self.delay = delay
    self.velocity = { x = 0, y = 0 } 
    self.collidable = true
    self.moving = false
    self.direction = true
end

return MovingPlatform
