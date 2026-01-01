local lust  = require("libraries/lust")
local lexer = require("lexer")

local describe, it, expect = lust.describe, lust.it, lust.expect

describe("lexer", function()
    it("empty", function()
        expect( lexer("") ).to.equal( { } )
        expect( lexer("   ") ).to.equal( { } )
    end)

    it("helo", function()
        expect( lexer(" helo ") ).to.equal( { "helo" } )
        expect( lexer(" !en helo ") ).to.equal( { "!en", "helo" } )
    end)
end)
