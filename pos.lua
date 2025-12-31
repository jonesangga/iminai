local inspect = require("libraries/inspect")

local vocab = require("vocab")
local punct = require("types").punct
local pos = require("types").pos

local Pos = {}
Pos.__index = Pos

local sep = string.rep("-", 70)

function Pos:print()
    print(sep)
    print("Pos:")
    inspect(self)
    print(sep)
end

local function get_pos(tokens)
    local t = {}
    for _, token in ipairs(tokens) do
        if vocab[token] then
            table.insert(t, { val = token, type = vocab[token] })
        elseif punct[token] then
            table.insert(t, { val = token, type = punct[token] })
        else
            table.insert(t, { val = token, type = pos.UNKNOWN })
        end
    end
    return setmetatable(t, Pos)
end

return get_pos
