local frame = CreateFrame('Frame')

frame:SetScript('OnEvent', function()
    if C_MerchantFrame.IsSellAllJunkEnabled() and C_MerchantFrame.GetNumJunkItems() > 0 then
        C_MerchantFrame.SellAllJunkItems()
    end

    if CanMerchantRepair() then
        local cost, canRepair = GetRepairAllCost()
        if canRepair and cost <= GetMoney() then
            RepairAllItems()
        end
    end
end)

frame:RegisterEvent('MERCHANT_SHOW')
