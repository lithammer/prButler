local _, ns = ...

if not ns.specSwitchFilter then return end

local spamFilterMatch1 = string.gsub(ERR_LEARN_ABILITY_S:gsub('%.', '%.'), '%%s', '(.*)')
local spamFilterMatch2 = string.gsub(ERR_LEARN_SPELL_S:gsub('%.', '%.'), '%%s', '(.*)')
local spamFilterMatch3 = string.gsub(ERR_SPELL_UNLEARNED_S:gsub('%.', '%.'), '%%s', '(.*)')
local primarySpecSpellName = GetSpellInfo(63645)
local secondarySpecSpellName = GetSpellInfo(63644)

local groupNamesCaps = {
	'Primary',
	'Secondary'
}

specCache = {}
	
HideSpam = CreateFrame('Frame')
HideSpam:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
HideSpam:RegisterEvent('UNIT_SPELLCAST_START')
HideSpam:RegisterEvent('UNIT_SPELLCAST_STOP')
HideSpam:RegisterEvent('UNIT_SPELLCAST_INTERRUPTED')

HideSpam.filter = function(self, event, msg, ...)
	if strfind(msg, spamFilterMatch1) then
		return true
	elseif strfind(msg, spamFilterMatch2) then
		return true
	elseif strfind(msg, spamFilterMatch3) then
		return true
	end
	return false, msg, ...
end

HideSpam:SetScript('OnEvent', function( self, event, ...)

	local unit, spellName = ...
	
	if(event == 'UNIT_SPELLCAST_START') then
		if unit == 'player' and (spellName == primarySpecSpellName or spellName == secondarySpecSpellName) then
			ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', self.filter)
		end
	
	elseif(event == 'UNIT_SPELLCAST_STOP') or (event == 'UNIT_SPELLCAST_INTERRUPTED') then
		if unit == 'player' and (spellName == primarySpecSpellName or spellName == secondarySpecSpellName) then
			ChatFrame_RemoveMessageEventFilter('CHAT_MSG_SYSTEM', self.filter)
		end
	
	elseif(event == 'ACTIVE_TALENT_GROUP_CHANGED') then
		for i = 1, GetNumTalentGroups() do
			specCache[i] = specCache[i] or {}
			local thisCache = specCache[i]
			TalentFrame_UpdateSpecInfoCache(thisCache, false, false, i)
			if thisCache.primaryTabIndex and thisCache.primaryTabIndex ~= 0 then
				thisCache.specName = thisCache[thisCache.primaryTabIndex].name
				thisCache.mainTabIcon = thisCache[thisCache.primaryTabIndex].icon
			elseif thisCache.secondaryTabIndex and thisCache.secondaryTabIndex ~= 0 then
				thisCache.specName = thisCache[thisCache.secondaryTabIndex].name
				thisCache.mainTabIcon = thisCache[thisCache.secondaryTabIndex].icon
			else
				thisCache.specName = '|cffff0000Talents undefined!|r'
				thisCache.mainTabIcon = 'Interface\\Icons\\Ability_Seal'
			end
			thisCache.specGroupName = groupNamesCaps[i]
		end

		local activeGroupNum = GetActiveTalentGroup()
		if specCache[activeGroupNum].totalPointsSpent > 1 then
			local s = specCache[activeGroupNum];
			local text = 'Switched to |cffffffff'.. s.specName ..' ('..s[1].pointsSpent ..'/'..s[2].pointsSpent ..'/'..s[3].pointsSpent ..')|r talent spec.'
			DEFAULT_CHAT_FRAME:AddMessage(text, 255, 255, 0)
		end

	end

end)
