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

local function is_digit(c)
    local b = c:byte()
    return b and 48 <= b and b <= 57  -- 0-9
end

local function is_alpha(c)
    local b = c:byte()
    return b and ((65 <= b and b <= 90)      -- A-Z
                  or (97 <= b and b <= 122)  -- a-z
                  or b == 95)                -- underscore (_)
end

local function is_alnum(c)
    return is_alpha(c) or is_digit(c)
end

local function lexer(src)
    local start   = 1
    local current = 1
    local length  = #src
    local tokens  = {}

    local function eof()     return current > length                                              end
    local function advance() local c = src:sub(current, current); current = current + 1; return c end
    local function peek()    return src:sub(current, current)                                     end
    local function add(s)    table.insert(tokens, s)                                              end

    local function skip_whitespace()
        while current <= length and src:byte(current) <= 32 do
            current = current + 1
        end
    end

    local function is_punct(c)
        return c == ',' or c == '.' or c == '!'
    end

    -- First, check if it is a command.
    skip_whitespace()
    start = current
    if peek() == '!' then
        advance()
        while is_alnum(peek()) do
            advance()
        end
        add(src:sub(start, current - 1))
    end

    while true do
        skip_whitespace()
        if eof() then break end

        start = current
        local c = advance()

        if is_punct(c) then
            add(c)
        else
            while is_alnum(peek()) do
                advance()
            end
            add(src:sub(start, current - 1))
        end
    end

    return setmetatable(tokens, Tokens)
end

return lexer
