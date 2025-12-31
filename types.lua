local Enum = require("util").Enum

local pos_types = Enum{
    "INTJ", "UNKNOWN",
    "COMMA",
}

local sentence_types = Enum{
    "GREETING",
}

local punct = {
    [","] = pos_types.COMMA,
}

return {
    punct = punct,
    pos_types = pos_types,
    sentence_types = sentence_types,
}
