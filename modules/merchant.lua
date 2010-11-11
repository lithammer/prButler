local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()
	-- Sell gray trash items
	if sellGrays then
		local c = 0
		
		for b = 0, 4 do
			for s = 1, GetContainerNumSlots(b) do
				local l = GetContainerItemLink(b, s)
				
				if l then
					local p = select(11, GetItemInfo(l)) * select(2, GetContainerItemInfo(b, s))
					if select(3, GetItemInfo(l)) == 0 and p > 0 then
						UseContainerItem(b, s)
						PickupMerchantItem()
						c = c + p
					end
				end
			end
		end
		
		if c > 0 then
			local g, s, c = math.floor(c/10000) or 0, math.floor((c%10000)/100) or 0, c%100
			DEFAULT_CHAT_FRAME:AddMessage("Your vendor trash has been sold and you earned |cffffffff"..g.."|cffffd700g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r.", 255, 255, 0)
		end
	end
	
	-- Repair
	if CanMerchantRepair() and autoRepair then
		cost, possible = GetRepairAllCost()
		
		if cost > 0 then
			if possible then
				RepairAllItems()
				local c = cost%100
				local s = math.floor((cost%10000)/100)
				local g = math.floor(cost/10000)
				DEFAULT_CHAT_FRAME:AddMessage("Your items have been repaired for |cffffffff"..g.."|cffffd700g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r.", 255, 255, 0)
			else
				DEFAULT_CHAT_FRAME:AddMessage("You don't have enough money for repair!", 255, 0, 0)
			end
		end
	end
end)
f:RegisterEvent("MERCHANT_SHOW")

-- Buy max number value with alt
local savedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
function MerchantItemButton_OnModifiedClick(self, ...)
	if ( IsAltKeyDown() ) then
		local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))
		local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(self:GetID())
		
		if ( maxStack and maxStack > 1 ) then
			BuyMerchantItem(self:GetID(), floor(maxStack / quantity))
		end
	end
	savedMerchantItemButton_OnModifiedClick(self, ...)
end