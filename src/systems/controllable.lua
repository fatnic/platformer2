local ControllableSystem = tiny.processingSystem(class("ControllableSystem"))

ControllableSystem.filter = tiny.requireAll('controllable')

function ControllableSystem:initialize(input)
    self.input = input
end

function ControllableSystem:process(e, dt)

    if self.input:down 'left' then 
        e:moveLeft(dt) 
    end

    if self.input:down 'right' then 
        e:moveRight(dt) 
    end

    if self.input:pressed 'jump' then 
        e:jump(dt) 
    end

end

return ControllableSystem
