local Ctx = {}
Ctx.__index = Ctx

function Ctx.new(names, parent)
    return setmetatable({ names = names or {}, parent = parent }, Ctx)
end

--- This might be useful later. For example when Imi is asked for thought experiment.
-- function Ctx:branch(names)
    -- return Ctx.new(names, self)
-- end

--- This will be used when we support profiles.
-- function Ctx:add_profile(profile)
    -- for key, val in pairs(profile) do
        -- self.names[key] = val
    -- end
-- end

function Ctx:define(key, val)
    self.names[key] = val
end

function Ctx:get(key)
    if self.names[key] ~= nil then
        return self.names[key]
    elseif self.parent then
        return self.parent:get(key)
    else
        error("unbound variable " .. key)
    end
end

function Ctx:set(key, val)
    if self.names[key] ~= nil then
        self.names[key] = val
    elseif self.parent then
        self.parent:set(key, val)
    else
        error("unbound variable " .. key)
    end
end

return Ctx
