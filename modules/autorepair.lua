local function OnEvent()
	local cost, total = GetRepairAllCost(), 0
	local text = "Repaired for"
	
	if cost > 0 then
		-- Use guild bank funds for repair?
		if (useGuildBank and IsInGuild() and CanGuildBankRepair()) then

			local withdrawLimit = GetGuildBankWithdrawMoney()
			local guildBankMoney = GetGuildBankMoney()

			-- Guild leader (unlimited withdrawal privileges)
			if (withdrawLimit == -1) then
				withdrawLimit = guildBankMoney
			else
				withdrawLimit = min(withdrawLimit, guildBankMoney)
			end

			if (cost < withdrawLimit) then
				RepairAllItems(1)
				total = cost
				text = "Repaired with guild funds for"
			end
		end
		
		-- Use player funds for repair
		if GetRepairAllCost() > 0 then
			if GetRepairAllCost() <= GetMoney() then
				total = GetRepairAllCost()
				RepairAllItems()
			else
				for id = 1, 18 do
					local cost = select(3, GameTooltip:SetInventoryItem("player", id))
					
					if cost ~= 0 and cost <= GetMoney() then
						if not InRepairMode() then ShowRepairCursor() end
						PickupInventoryItem(id)
						total = total + cost
					end
				end
				HideRepairCursor()
			end
		end
		
		if total > 0 then print(format("|cff66C6FF%s |cffFFFFFF%s", text, formatgold(1, total))) end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", OnEvent)

if MerchantFrame:IsVisible() and CanMerchantRepair() then OnEvent() end