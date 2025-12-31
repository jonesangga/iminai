local Enum = require("util").Enum

local pos = Enum{
    "INTJ", "UNKNOWN",
    "COMMA",
}

local sentence_types = Enum{
    "GREETING",
}

local punct = {
    [","] = pos.COMMA,
}

return {
    punct = punct,
    pos = pos,
    sentence_types = sentence_types,
}
