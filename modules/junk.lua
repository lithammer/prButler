local function OnEvent()
	local profit = 0
	local items = {}
	local i = 1
	
	for bag = 0, 4 do
		for slot = 0, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			
			if link and select(3, GetItemInfo(link)) == 0 then
				if detailedJunkSell then items[i] = link; i = i + 1 end
				
				ShowMerchantSellCursor(1)
				profit = profit + select(11, GetItemInfo(link)) * select(2, GetContainerItemInfo(bag, slot))
				UseContainerItem(bag, slot)
			end
		end
	end
	
	if profit > 0 then
		if detailedJunkSell then
			print("|cff66C6FF----------------------------")
			print("|cff66C6FFReceit:")
			for k,v in ipairs(items) do
				print("|cff66C6FF"..k..format(". %s", v))
			end
			print(format("|cff66C6FFProfit: |cffFFFFFF%s", formatgold(1, profit)))
			print("|cff66C6FF----------------------------")
		else
			print(format("|cff66C6FFJunk profit: |cffFFFFFF%s", formatgold(1, profit)))
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", OnEvent)

if MerchantFrame:IsVisible() then OnEvent() end