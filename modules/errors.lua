local _, config = ...

UIErrorsFrame:UnregisterEvent('UI_ERROR_MESSAGE')

local f = CreateFrame('Frame')
f:RegisterEvent('UI_ERROR_MESSAGE')
f:SetScript('OnEvent', function(self, event, messageType, message)
	if not config.errorFilter[message] then
		UIErrorsFrame:AddMessage(message, 1, 0 , 0)
	end
end)
