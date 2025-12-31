local inspect = require("libraries/inspect")

local vocab = require("vocab")
local punct = require("types").punct
local PT = require("types").pos_types

local Pos = {}
Pos.__index = Pos

local sep = string.rep("-", 70)

function Pos:print()
    print(sep)
    print("Pos:")
    inspect(self)
    print(sep)
end

local function pos(tokens)
    local t = {}
    for _, token in ipairs(tokens) do
        if vocab[token] then
            table.insert(t, { val = token, type = vocab[token] })
        elseif punct[token] then
            table.insert(t, { val = token, type = punct[token] })
        else
            table.insert(t, { val = token, type = PT.UNKNOWN })
        end
    end
    return setmetatable(t, Pos)
end

return pos
