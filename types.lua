local Enum = require("util").Enum

local pos = Enum{
    "N", "V", "PRON", "ADJ", "INTJ", "DET", "PART", "NUM", "WH", "X",
    "COMMA", "QMARK",
    "TO_EN",
}

local SentenceTypes = Enum{
    "X", "INTER_COPULAR", "GREETING", "CMD",
}

local punct = {
    [","] = pos.COMMA,
    ["?"] = pos.QMARK,
}

local cmd = {
    ["!en"] = pos.TO_EN,
}

return {
    punct = punct,
    cmd = cmd,
    pos = pos,
    SentenceTypes = SentenceTypes,
}
