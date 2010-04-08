local f = CreateFrame("Button", nil, LootFrame, "UIPanelButtonTemplate")
f:SetPoint("TOPRIGHT", LootFrame, -80, -43)
f:SetFrameStrata("HIGH")
f:SetWidth(100)
f:SetHeight(24)
f:SetText("Announce")

f:SetScript("OnClick", function()
	local num = GetNumLootItems()
	if num == 0 then return end

	local channel = "RAID"
	
	if UnitName("target") then
		SendChatMessage(">> Loot from "..UnitName("target"), channel)
	end

	for i = 1, GetNumLootItems() do
	   if LootSlotIsItem(i) then
		  local link = GetLootSlotLink(i)
		  --local text = i..". %s"
		  local text = "- %s"
		  
		  SendChatMessage(format(text, link), channel)
	   end
	end
end)

f:SetScript("OnShow", function()
	if (UnitInRaid("player")) then
		f:Enable()
	else
		f:Disable()
	end
end)
