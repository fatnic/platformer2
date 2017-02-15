local ControllableSystem = tiny.processingSystem(class("ControllableSystem"))

ControllableSystem.filter = tiny.requireAll('controllable')

function ControllableSystem:initialize()
end

function ControllableSystem:process(e, dt)

    if World.input:down 'left' then 
        e:moveLeft(dt) 
    end

    if World.input:down 'right' then 
        e:moveRight(dt) 
    end

    if World.input:pressed 'jump' then 
        e:jump(dt) 
    end

end

return ControllableSystem
