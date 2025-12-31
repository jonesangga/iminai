local inspect = require("libraries/inspect")

local Tokens = {}
Tokens.__index = Tokens

local sep = string.rep("-", 70)

function Tokens:print()
    print(sep)
    print("Tokens:")
    inspect(self)
    print(sep)
end

local function lexer(text)
    -- Insert space before and after punctuations.
    local text = text:gsub("([%.%,%!%?%;:])", " %1 ")

    local t = {}
    for w in text:gmatch("%S+") do
        table.insert(t, w)
    end
    return setmetatable(t, Tokens)
end

return lexer
