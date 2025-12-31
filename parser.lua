local inspect = require("libraries/inspect")
local pos = require("types").pos
local ST = require("types").sentence_types

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

function Parser:peekt() return self.t[self.i].type     end
function Parser:peekv() return self.t[self.i].val      end
function Parser:peek()  return self.t[self.i]          end
function Parser:prevt() return self.t[self.i - 1].type end
function Parser:prevv() return self.t[self.i - 1].val  end
function Parser:eof()   return self.i > #self.t        end

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
    local sentences = {}
    while not self:eof() do
        table.insert(sentences, self:sentence())
    end
    return setmetatable(sentences, Parser)
end

function Parser:sentence()
    if self:match(pos.INTJ) then
        local recipient

        if self:match(pos.COMMA) then
            recipient = self:peek()
            self:advance()
        end

        return make(ST.GREETING, { recipient = recipient })
    end

    error("unhandled")
end

local function parser(pos)
    local p = Parser.new(pos)
    return p:parse()
end

return parser
