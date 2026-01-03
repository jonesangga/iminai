local Enum = require("util").Enum

local pos = Enum{
    "N", "PRON", "INTJ", "DET", "PART", "NUM", "UNKNOWN",
    "COMMA",
    "TO_EN",
}

local SentenceTypes = Enum{
    "UNKNOWN", "GREETING", "CMD",
}

local punct = {
    [","] = pos.COMMA,
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
