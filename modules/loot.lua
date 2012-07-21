local _, config = ...

if not config.announceLootButton then return end

local EPIC = 4
local POOR = 0
local COMMON = 1
local UNCOMMON = 2
local RARE = 3
local EPIC = 4
local LEGENDARY = 5
local ARTIFACT = 6
local HEIRLOOM = 7

local f = CreateFrame('Button', nil, LootFrame, 'UIPanelButtonTemplate')
f:SetPoint('TOPRIGHT', LootFrame, -5, -25)
f:SetFrameStrata('HIGH')
f:SetWidth(100)
f:SetHeight(24)
f:SetText('Announce')

f:SetScript('OnClick', function()
	local num = GetNumLootItems()
	if num == 0 then return end

	local channel = 'RAID'
	
	if UnitName('target') then
		SendChatMessage('>> Loot from '..UnitName('target'), channel)
	end

	for slot = 1, GetNumLootItems() do
	   if LootSlotIsItem(slot) then
		  local link = GetLootSlotLink(slot)
		  local texture, item, quantity, quality, locked = GetLootSlotInfo(slot)
		  
		  if quality == EPIC then
			SendChatMessage(format('- %s', link), channel)
		end
	   end
	end
end)

f:SetScript('OnShow', function()
	if (UnitInRaid('player')) then
		f:Enable()
	else
		f:Disable()
	end
end)
