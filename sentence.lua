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
    if self.wh.val == "hu" then
        if self.subject.val == "yu" then
            if self.copula.val == "iz" then
                local name = ctx:get("imi"):get_name()
                ctx.print("ai iz " .. name)
            end

        elseif self.subject.val == "ai" then
            if self.copula.val == "iz" then
                local user = ctx:get("user")
                if user and user.name then
                    ctx.print("yu iz " .. user.name)
                else
                    ctx.print("ai nat nou yu")
                end
            end

        else
            ctx.print("ai nat nou")
        end

    else
        error("unknown wh-word")
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
    Unknown = Unknown,
}
