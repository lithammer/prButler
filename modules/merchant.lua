local frame = CreateFrame('Frame')

frame:SetScript('OnEvent', function()
    if C_MerchantFrame.IsSellAllJunkEnabled() and C_MerchantFrame.GetNumJunkItems() > 0 then
        C_MerchantFrame.SellAllJunkItems()
    end
end)

frame:RegisterEvent('MERCHANT_SHOW')
