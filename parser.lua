local inspect = require("libraries/inspect")
local pos     = require("types").pos
local ST      = require("types").SentenceTypes
local S       = require("sentence")

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
    return self:prev()
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

function Parser:consume(type, msg)
    if self:check(type) then
        return self:advance()
    end
    error(msg or "parser error")
end

function Parser:parse()
    local sentences = {}

    while not self:eof() do
        table.insert(sentences, self:sentence())
    end

    return setmetatable(sentences, Parser)
end

function Parser:sentence()
    if self:check(pos.PRON) then
        local subject = self:advance()
        -- print("got pron " .. subject.val)
        local copula = self:consume(pos.V)
        -- print("got copula " .. copula.val)

        local pred
        if self:check(pos.X) then
            pred = self:advance()
        end
        -- print("got pred " .. pred.val)
        return S.Copular.new(subject, copula, pred)

    elseif self:check(pos.WH) then
        return self:wh_question()

    elseif self:match(pos.INTJ) then
        local phrase = self:prev()
        local recipient

        if self:match(pos.COMMA) then
            recipient = self:advance()
        end

        return S.Greeting.new(phrase, recipient)

    else
        local t = {}
        while not self:eof() do
            table.insert(t, self:advance())
        end
        return S.Unknown.new(t)
    end
end

function Parser:wh_question()
    local wh = self:wh_phrase()
    local np = self:np()
    local vp = self:vp()
    self:consume(pos.QMARK)
    return S.InterCopular.new(wh, np, vp)
end

function Parser:wh_phrase()
    local wh = self:advance()
    if wh.val == "hau" then
        if self:check(pos.ADJ) then
            local adj = self:advance()
            return S.Wh.new(wh, adj)
        end
    else
        return S.Wh.new(wh)
    end
end

function Parser:np()
    local np
    if self:check(pos.PRON) then
        np = self:advance()
    end
    return np
end

function Parser:vp()
    local vp
    if self:check(pos.V) then
        vp = self:advance()
    end
    return vp
end


local function parser(pos)
    local p = Parser.new(pos)
    return p:parse()
end

return parser
