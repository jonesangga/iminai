local inspect = require("libraries/inspect")
local pos     = require("types").pos
local ST      = require("types").SentenceTypes

local function make(tag, props)
    props = props or {}
    props.tag = tag
    return props
end

local Parser = {}
Parser.__index = Parser

local sep = string.rep("-", 70)

function Parser:print()
    print(sep)
    print("AST:")
    inspect(self)
    print(sep)
end

function Parser.new(pos)
    return setmetatable({ t = pos, i = 1 }, Parser)
end

function Parser:peekt() return self.t[self.i].type end
function Parser:peek()  return self.t[self.i]      end
function Parser:prev()  return self.t[self.i - 1]  end
function Parser:eof()   return self.i > #self.t    end

function Parser:check(type)
    return not self:eof() and self:peekt() == type
end

function Parser:advance()
    if not self:eof() then
        self.i = self.i + 1
    end
end

function Parser:match(...)
    local types = {...}
    for _, type in ipairs(types) do
        if self:check(type) then
            self:advance()
            return true
        end
    end

    return false
end

function Parser:parse()
    local is_cmd, cmd_type

    if self:match(pos.TO_EN) then
        is_cmd = true
        cmd_type = self:prev().type
    end

    local sentences = {}
    while not self:eof() do
        table.insert(sentences, self:sentence())
    end

    if is_cmd then
        sentences.tag = ST.CMD
        sentences.cmd_type = cmd_type
    end

    return setmetatable(sentences, Parser)
end

function Parser:sentence()
    if self:match(pos.INTJ) then
        local phrase = self:prev()
        local recipient

        if self:match(pos.COMMA) then
            recipient = self:peek()
            self:advance()
        end

        return make(ST.GREETING, { phrase = phrase, recipient = recipient })

    else
        local t = {}
        while not self:eof() do
            table.insert(t, self:peek())
            self:advance()
        end
        return make(ST.UNKNOWN, { t = t })
    end
end

local function parser(pos)
    local p = Parser.new(pos)
    return p:parse()
end

return parser
