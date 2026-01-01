local lust = require("libraries/lust")
local main = require("main")
local inspect = require("libraries/inspect")

local describe, it, expect = lust.describe, lust.it, lust.expect

local text = ""
local function append(s)
    text = text .. tostring(s)
end

main.setup(append)

local function runner(src, output)
    text = ""
    main.run_string(src)
    expect( text ).to.diff( output )
end

local tests = {
    {
        name = "greet",
        src = "helo",
        out = "helo",
    },
    {
        name = "greet Imi",
        src = "helo, Imi",
        out = "helo",
    },
}

describe("TEST 1", function()
    for _, test in ipairs(tests) do
        it(test.name, function()
            runner(test.src, test.out)
        end)
    end
end)
