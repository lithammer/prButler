local f, o, errorDB = CreateFrame("Frame"), "No error yet.", errorFilter

f:SetScript("OnEvent", function(self, event, error)
	if not errorDB[error] then
		UIErrorsFrame:AddMessage(error, 1, 0 , 0)
	else
		o = error
	end
end)

SLASH_PRERROR1 = "/error"
function SlashCmdList.PRERROR() print(o) end

UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
f:RegisterEvent("UI_ERROR_MESSAGE")