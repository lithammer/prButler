-- Adds /frame for getting frame name where the mouse pointer is
SlashCmdList["FRAMENAME"] = function()
    DEFAULT_CHAT_FRAME:AddMessage("|cff00FF00   "..GetMouseFocus():GetName())
end
SLASH_FRAMENAME1 = "/frame"

-- Adds /rl for reloading UI
SlashCmdList["RELOADUI"] = function()
    ReloadUI()
end
SLASH_RELOADUI1 = "/rl"

-- Returns hex representation of num
function num2hex(num)
    local hexstr = "0123456789abcdef"
    local s = ""

    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end

    if s == "" then s = "0" end

    return s
end