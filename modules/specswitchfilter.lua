local _, config = ...

if not config.specSwitchFilter then return end

local spamFilterMatch1 = string.gsub(ERR_LEARN_ABILITY_S:gsub('%.', '%.'), '%%s', '(.*)')
local spamFilterMatch2 = string.gsub(ERR_LEARN_SPELL_S:gsub('%.', '%.'), '%%s', '(.*)')
local spamFilterMatch3 = string.gsub(ERR_SPELL_UNLEARNED_S:gsub('%.', '%.'), '%%s', '(.*)')
local spamFilterMatch4 = string.gsub(ERR_LEARN_PASSIVE_S:gsub('%.', '%.'), '%%s', '(.*)')
local primarySpecSpellName = GetSpellInfo(63645)
local secondarySpecSpellName = GetSpellInfo(63644)

HideSpam = CreateFrame('Frame')
HideSpam:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
HideSpam:RegisterUnitEvent('UNIT_SPELLCAST_START', 'player')
HideSpam:RegisterUnitEvent('UNIT_SPELLCAST_STOP', 'player')
HideSpam:RegisterUnitEvent('UNIT_SPELLCAST_INTERRUPTED', 'player')

HideSpam.filter = function(self, event, msg, ...)
	if strfind(msg, spamFilterMatch1) then
		return true
	elseif strfind(msg, spamFilterMatch2) then
		return true
	elseif strfind(msg, spamFilterMatch3) then
		return true
	elseif strfind(msg, spamFilterMatch4) then
		return true
	end
	return false, msg, ...
end

HideSpam:SetScript('OnEvent', function(self, event, ...)
	local unit, spellName = ...
	
	if event == 'UNIT_SPELLCAST_START' then
		if unit == 'player' and (spellName == primarySpecSpellName or spellName == secondarySpecSpellName) then
			ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', self.filter)
		end
	
	elseif event == 'UNIT_SPELLCAST_STOP' or event == 'UNIT_SPELLCAST_INTERRUPTED' then
		if unit == 'player' and (spellName == primarySpecSpellName or spellName == secondarySpecSpellName) then
			ChatFrame_RemoveMessageEventFilter('CHAT_MSG_SYSTEM', self.filter)
		end
	
	elseif event == 'ACTIVE_TALENT_GROUP_CHANGED' then
		local id, name, description, icon, background, role = GetSpecializationInfo(GetSpecialization())

		if name then
			local text = 'Switched to |cffffffff'..name..' ('..role..')|r talent spec.'

			DEFAULT_CHAT_FRAME:AddMessage(text, 255, 255, 0)
		end
	end
end)
