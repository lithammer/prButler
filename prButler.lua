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

-- Format gold with colors
function formatgold(style, amount)
	local gold, silver, copper = floor(amount * .0001), floor(mod(amount * .01, 100)), floor(mod(amount, 100))
	if style == 1 then 
		return (gold > 0 and gold.."|cffffd700g|r " or "") .. (silver > 0 and silver.."|cffc7c7cfs|r " or "")
			.. ((copper > 0 or (gold == 0 and silver == 0)) and copper.."|cffeda55fc|r" or "")
	elseif style == 2 or not style then	
		return format("%.1f|cffffd700g|r", amount / 10000)
	elseif style == 3 then
		return format("|cffffd700%s|r.|cffc7c7cf%s|r.|cffeda55f%s|r", gold, silver, copper)
	end
end

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