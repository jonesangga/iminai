local inspect = require("libraries/inspect")

local InterCopular = {}
InterCopular.__index = InterCopular

function InterCopular.new(wh, subject, copula)
    return setmetatable({
        type    = "INTER_COPULAR",
        wh      = wh,
        subject = subject,
        copula  = copula
    }, InterCopular)
end

function InterCopular:eval(env)
    if self.wh.val == "hu" then
        if self.subject.val == "yu" then
            if self.copula.val == "iz" then
                local name = env:get("imi"):get_name()
                print("ai iz " .. name)
            end

        else
            print("ai nat nou")
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

function Greeting:eval(env)
    print("helo")
end

local Unknown = {}
Unknown.__index = Unknown

function Unknown.new(t)
    return setmetatable({
        type = "UNKNOWN",
        t    = t
    }, Unknown)
end

function Unknown:eval(env)
    print("unknown")
end

return {
    InterCopular = InterCopular,
    Greeting = Greeting,
    Unknown = Unknown,
}
