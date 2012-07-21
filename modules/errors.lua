local _, config = ...

local f = CreateFrame('Frame')
local output = 'No error yet.'

f:SetScript('OnEvent', function(self, event, error)
	if not config.errorFilter[error] then
		UIErrorsFrame:AddMessage(error, 1, 0 , 0)
	else
		output = error
	end
end)

UIErrorsFrame:UnregisterEvent('UI_ERROR_MESSAGE')
f:RegisterEvent('UI_ERROR_MESSAGE')

SLASH_PRERROR1 = '/error'
function SlashCmdList.PRERROR()
	print(output)
end
