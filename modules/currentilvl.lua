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
	local mainHand = false
	local offHand = false
	
	for _, id in pairs(itemSlots) do
		local itemLink = GetInventoryItemLink('player', id)
		
		if (itemLink) then
			local itemLevel = select(4, GetItemInfo(itemLink))
			
			if (id == INVSLOT_MAINHAND) then
				mainHand = true
			elseif (id == INVSLOT_OFFHAND) then
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