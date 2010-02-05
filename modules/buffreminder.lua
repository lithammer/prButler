local buffList = {}
local class = select(2, UnitClass("Player"))

if class == "DEATHKNIGHT" then
	buffList = {
		--"Horn of Winter",
	}
elseif class == "PRIEST" then
	buffList = {
		"Inner Fire",
	}
elseif class == "WARLOCK" then
	buffList = {
		"Fel Armor",
	}
end

if buffReminder then
	local f = CreateFrame("Frame", _, UIParent)
	
	f:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
	f:SetFrameStrata("LOW")
	f:SetWidth(48)
	f:SetHeight(48)
	--[[f:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		tile = true,
		tileSize = 16,
		edgeSize = 1,
		insets = { top = 1, right = 1, bottom = 1, left = 1 },
	})]]--
	f:SetBackdropColor(0.1, 0.1, 0.1, 0)
	f:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

	f.icon = f:CreateTexture(nil, "BACKGROUND")
	f.icon:SetPoint("CENTER", f, "CENTER", 0, 0)
	f.icon:SetWidth(48)
	f.icon:SetHeight(48)
		

	local function BuffReminder_OnEvent(self, event, unit, spell)
		if UnitLevel("player") < 70 or CanExitVehicle() then
			return
		end

		local inCombat = UnitAffectingCombat("player")
			
		for _, k in ipairs(buffList) do
			local icon = select(3, GetSpellInfo(k))

			if not UnitBuff("player", k) and inCombat then
				f.icon:SetTexture(icon)
				--f.icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
				self:Show()
				PlaySound("RaidWarning")
			else
				self:Hide()
			end
		end
	end

	f:SetScript("OnEvent", BuffReminder_OnEvent)
	f:RegisterEvent("UNIT_AURA")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:RegisterEvent("PLAYER_REGEN_ENABLED")
	f:RegisterEvent("PLAYER_REGEN_DISABLED")
end
