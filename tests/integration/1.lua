local lust = require("libraries/lust")
local main = require("main")
local inspect = require("libraries/inspect")

local describe, it, expect = lust.describe, lust.it, lust.expect

local text = ""

local function _print(s)
    text = text .. tostring(s) .. '\n'
end

local function _write(s)
    text = text .. tostring(s)
end

main.setup(_print, _write)

local function runner(src, output)
    text = ""
    main.run_string(src)
    expect( text ).to.diff( output )
end

local tests = {
    {
        name = "greet",
        src = "helo",
        out = "helo\n",
    },
    {
        name = "greet Imi",
        src = "helo, Imi",
        out = "helo\n",
    },
    {
        name = "hu question",
        src = "hu yu iz?",
        out = "ai iz Imi\n",
    },
    {
        name = "hu question 2",
        src = "hu ai iz?",
        out = "ai nat nou\n",
    },
}

describe("TEST 1", function()
    for _, test in ipairs(tests) do
        it(test.name, function()
            runner(test.src, test.out)
        end)
    end
end)
