local ST = require("types").sentence_types

local eval = {}
eval.print = print

function eval_sentence(node, env)
    local tag = node.tag

    if tag == ST.GREETING then
        eval.print("helou")

    else
        error("unhandled sentence type " .. ST[tag])
    end
end

function eval.eval(ast, env)
    for _, node in ipairs(ast) do
        eval_sentence(node, env)
    end
end

return eval
