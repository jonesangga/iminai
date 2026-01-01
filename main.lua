local inspect = require("libraries/inspect")
local lexer = require("lexer")
local pos = require("pos")
local parser = require("parser")
local eval = require("eval")

local M = {}
M.print = print

function M.repl()
    M.print("Iminai. Ctrl+D to quit.")

    local tokens, poss, ast

    while true do
        io.write("> ")
        line = io.read()

        if not line then break end

        if #line ~= 0 then
            tokens = lexer(line)
            -- tokens:print()

            poss = pos(tokens)
            -- poss:print()

            ast = parser(poss)
            -- ast:print()

            eval.eval(ast)
        end
    end
end

function M.run_string(line)
    local tokens, poss, ast

    if #line ~= 0 then
        tokens = lexer(line)
        poss = pos(tokens)
        ast = parser(poss)
        eval.eval(ast)
    end
end

function M.setup(printfn, writefn)
    eval.print = printfn
    eval.write = writefn
    M.print = printfn
end

-- Run as script.
if arg[0] == "main.lua" then
    if #arg == 0 then
        M.repl()
    end
    return
end

return M
