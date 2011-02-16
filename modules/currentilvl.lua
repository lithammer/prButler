local _, ns = ...

--if not ns.currentilvl then return end

--[[
INVSLOT_AMMO       = 0
INVSLOT_HEAD       = 1 INVSLOT_FIRST_EQUIPPED = INVSLOT_HEAD
INVSLOT_NECK       = 2
INVSLOT_SHOULDER   = 3
INVSLOT_BODY       = 4
INVSLOT_CHEST      = 5
INVSLOT_WAIST      = 6
INVSLOT_LEGS       = 7
INVSLOT_FEET       = 8
INVSLOT_WRIST      = 9
INVSLOT_HAND       = 10
INVSLOT_FINGER1    = 11
INVSLOT_FINGER2    = 12
INVSLOT_TRINKET1   = 13
INVSLOT_TRINKET2   = 14
INVSLOT_BACK       = 15
INVSLOT_MAINHAND   = 16
INVSLOT_OFFHAND    = 17
INVSLOT_RANGED     = 18
INVSLOT_TABARD     = 19
INVSLOT_LAST_EQUIPPED = INVSLOT_TABARD
]]--

local itemSlots = {
	['HeadSlot'] = 1,
	['NeckSlot'] = 2,
	['ShoulderSlot'] = 3,
	--['ShirtSlot'] = 4, -- Only here as a note that #4 is skipped on purpose
	['ChestSlot'] = 5,
	['WaistSlot'] = 6,
	['LegsSlot'] = 7,
	['FeetSlot'] = 8,
	['WristSlot'] = 9,
	['HandsSlot'] = 10,
	['Finger0Slot'] = 11,
	['Finger1Slot'] = 12,
	['Trinket0Slot'] = 13,
	['Trinket1Slot'] = 14,
	['BackSlot'] = 15,
	['MainHandSlot'] = 16,
	['SecondaryHandSlot'] = 17,
	['RangedSlot'] = 18,
}
	

local GetCurrentAverageItemLevel = function()
	local totalItemLevel = 0
	local mainHand = false
	local offHand = false
	
	for slot, id in pairs(itemSlots) do
		local itemLink = GetInventoryItemLink('player', id)
		
		if (itemLink) then
			local itemLevel = select(4, GetItemInfo(itemLink))
			
			if (slot == 'MainHandSlot') then
				mainHand = true
			elseif (slot == 'SecondaryHandSlot') then
				offHand = true
			end
			
			totalItemLevel = totalItemLevel + itemLevel
		end
	end
	
	-- Assume that all slots have to be filled
	local totalEqItems
	if (mainHand and offHand or not mainHand and offHand) then
		totalEqItems = 17
	else
		totalEqItems = 16
	end

	return (totalItemLevel / totalEqItems)
end

hooksecurefunc('PaperDollFrame_SetItemLevel', function(statFrame, unit)
	if (unit ~= 'player') then
		return
	end
	
	local avgItemLevel = floor(GetAverageItemLevel())
	local currentAvgItemLevel = floor(GetCurrentAverageItemLevel())
	
	local text = _G[statFrame:GetName()..'StatText']
	text:SetText(currentAvgItemLevel..' ('..avgItemLevel..')')
end)