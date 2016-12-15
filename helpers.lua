local inspect = require 'ext.inspect'

function pprint(t)
    print(inspect(t))
end

function scopy(t)
    local c = {}
    for k, v in pairs(t) do c[k] = v end
    return c
end

function dcopy(t)
    local copy = {}
    for k ,v in pairs(t) do
        if type(v) == 'table' then dcopy(v) end
        copy[k] = v
    end
    return copy
end
