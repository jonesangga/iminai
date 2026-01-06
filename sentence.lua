local inspect = require("libraries/inspect")

local Copular = {}
Copular.__index = Copular

function Copular.new(subject, copula, pred)
    return setmetatable({
        type    = "COPULAR",
        subject = subject,
        copula  = copula,
        pred    = pred,
    }, Copular)
end

function Copular:eval(ctx)
    if self.subject.val == "ai" then
        if self.copula.val == "iz" then
            local user = ctx:get("user")
            user.name = self.pred.val
            ctx.print("helo, " .. user.name)
        end

    else
        ctx.print("ai nat nou")
    end
end

local InterCopular = {}
InterCopular.__index = InterCopular

function InterCopular.new(wh, subject, copula)
    return setmetatable({
        type    = "INTER_COPULAR",
        wh      = wh,
        subject = subject,
        copula  = copula,
    }, InterCopular)
end

function InterCopular:eval(ctx)
    self.wh:eval(ctx)

    if self.subject.val == "ai" then
        ctx.subject = "user"
    elseif self.subject.val == "yu" then
        ctx.subject = "imi"
    end

    if self.copula.val == "iz" then
    end
    local prop = ctx:get(ctx.subject)[ctx.adj]
    if prop then
        ctx.print("ai iz " .. prop)
    else
        ctx.print("ai nat nou")
    end
end

local Greeting = {}
Greeting.__index = Greeting

function Greeting.new(phrase, recipient)
    return setmetatable({
        type      = "GREETING",
        phrase    = phrase,
        recipient = recipient
    }, Greeting)
end

function Greeting:eval(ctx)
    ctx.print("helo")
end

local Wh = {}
Wh.__index = Wh

function Wh.new(wh, adj)
    return setmetatable({
        type = "WH",
        wh   = wh,
        adj  = adj,
    }, Wh)
end

function Wh:eval(ctx)
    if self.wh.val == "hu" then
        ctx.wh = "hu"
        ctx.adj = "name"
    elseif self.wh.val == "hau" then
        if self.adj.val == "oult" then
            ctx.adj = "age"
        end
    end
end

local Unknown = {}
Unknown.__index = Unknown

function Unknown.new(t)
    return setmetatable({
        type = "UNKNOWN",
        t    = t
    }, Unknown)
end

function Unknown:eval(ctx)
    ctx.print("unknown")
end

return {
    Copular = Copular,
    InterCopular = InterCopular,
    Greeting = Greeting,
    Wh = Wh,
    Unknown = Unknown,
}
