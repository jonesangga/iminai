local StrictMT = {
    __index = function(t, k)
        error("access to undefined key '" .. tostring(k) .. "'", 2)
    end,

    __newindex = function(t, k, v)
        error("assign to undefined key '" .. tostring(k) .. "'", 2)
    end,
}

-- Create enum with reverse lookup.
local function Enum(list)
    local t = {}
    for i, name in ipairs(list) do
        t[name] = i
        t[i] = name
    end
    return setmetatable(t, StrictMT)
end

return {
    Enum = Enum,
}
