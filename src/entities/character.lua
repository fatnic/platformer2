local Character = class("Character")

function Character:initialize(image, x, y, args)
    local args = args or {}
    self.image = image
    self.position = { x = x or 0, y = y or 0 }
    self.rotation = args.rotation or 0
    self.scale = args.scale or { x = 1, y = 1 }
end

return Character
