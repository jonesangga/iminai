local lust = require("libraries/lust")
local main = require("main")
local vocab = require("vocab")
local en = require("imola_en")
local inspect = require("libraries/inspect")

local describe, it, expect = lust.describe, lust.it, lust.expect

local text = ""
local function printfn(s)
    text = text .. tostring(s) .. '\n'
end

local function writefn(s)
    text = text .. tostring(s)
end

main.setup(printfn, writefn)

local function runner(src, output)
    text = ""
    main.run_string(src)
    expect( text ).to.diff( output )
end

describe("all vocabs", function()
    for k, _ in pairs(vocab) do
        it(k, function()
            runner("!en " .. k, en[k] .. '\n')
        end)
    end
end)
