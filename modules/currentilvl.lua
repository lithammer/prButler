local _, ns = ...

--if not ns.currentilvl then return end

local itemSlots = {
	INVSLOT_HEAD,
	INVSLOT_NECK,
	INVSLOT_SHOULDER,
	INVSLOT_CHEST,
	INVSLOT_WAIST,
	INVSLOT_LEGS,
	INVSLOT_FEET,
	INVSLOT_WRIST,
	INVSLOT_HAND,
	INVSLOT_FINGER1,
	INVSLOT_FINGER2,
	INVSLOT_TRINKET1,
	INVSLOT_TRINKET2,
	INVSLOT_BACK,
	INVSLOT_MAINHAND,
	INVSLOT_OFFHAND,
	INVSLOT_RANGED,
}
	

local GetCurrentAverageItemLevel = function()
	local totalItemLevel = 0
	local totalEqItems = #itemSlots
	local hasTwoHander = false
	
	for _, id in pairs(itemSlots) do
		local itemLink = GetInventoryItemLink('player', id)
		
		if (itemLink) then
			local _, _, _, itemLevel, _, _, _, _, equipSlot = GetItemInfo(itemLink)
			
			if (id == INVSLOT_MAINHAND and equipSlot == 'INVTYPE_2HWEAPON') then
				hasTwoHander = true
			end
			
			totalItemLevel = totalItemLevel + itemLevel
		end
	end
	
	if (hasTwoHander) then
		totalEqItems = totalEqItems - 1
	end

	return (totalItemLevel / totalEqItems)
end

hooksecurefunc('PaperDollFrame_SetItemLevel', function(statFrame, unit)
	if (unit ~= 'player') then
		return
	end

	local text = _G[statFrame:GetName()..'StatText']

	local avgItemLevel = floor(GetAverageItemLevel())
	local currentAvgItemLevel = floor(GetCurrentAverageItemLevel())

	if (currentAvgItemLevel ~= avgItemLevel) then
		text:SetText(avgItemLevel..' ('..currentAvgItemLevel..')')
	end
end)
