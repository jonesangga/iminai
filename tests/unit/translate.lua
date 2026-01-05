local vocab = require("vocab")
local en = require("imola_en")

for k, _ in pairs(vocab) do
    if not en[k] then
        error("FAIL " .. k .. " not found in en")
    end
end

for k, _ in pairs(en) do
    if not vocab[k] then
        error("FAIL " .. k .. " not found in vocab")
    end
end

print("PASS translate")
