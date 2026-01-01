local inspect = require("libraries/inspect")
local pos     = require("types").pos
local ST      = require("types").SentenceTypes
local en      = require("imola_en")

local eval = {}
eval.print = print
eval.write = io.write

function to_en(sentences)
    local f = function(node)
        local tag = node.tag
        if tag == ST.GREETING then
            local t = en[node.phrase.val]
            eval.print(t)
        elseif tag == ST.UNKNOWN then
            for i, t in ipairs(node.t) do
                local v = en[t.val]
                if i > 1 then eval.write(' ') end
                eval.write(v)
            end
            eval.write('\n')
        else
            error("unhandled sentence type " .. ST[tag])
        end
    end

    for _, node in ipairs(sentences) do
        f(node)
    end
end

function eval_sentence(node, env)
    local tag = node.tag

    if tag == ST.GREETING then
        eval.print("helo")

    elseif tag == ST.UNKNOWN then
        eval.print("unknown eval")

    else
        error("unhandled sentence type " .. ST[tag])
    end
end

function eval_cmd(ast, env)
    local t = ast.cmd_type

    if t == pos.TO_EN then
        to_en(ast)

    else
        error("cmd: unhandled sentence type " .. ST[t])
    end
end

function eval.eval(ast, env)
    if ast.tag == ST.CMD then
        eval_cmd(ast, env)
    else
        for _, node in ipairs(ast) do
            eval_sentence(node, env)
        end
    end
end

return eval
