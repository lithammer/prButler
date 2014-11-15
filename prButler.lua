local _, config = ...

-- Adds /frame for getting frame name where the mouse pointer is
SlashCmdList['FRAMENAME'] = function()
    DEFAULT_CHAT_FRAME:AddMessage('|cff00FF00   '..GetMouseFocus():GetName())
end
SLASH_FRAMENAME1 = '/frame'

-- Adds /rl for reloading UI
SlashCmdList['RELOADUI'] = function()
    ReloadUI()
end
SLASH_RELOADUI1 = '/rl'

-- Makes the interface window movable
InterfaceOptionsFrame:SetMovable(1)
InterfaceOptionsFrame:RegisterForDrag('LeftButton')

InterfaceOptionsFrame:SetScript('OnDragStart', function(self)
	self:StartMoving()
end)

InterfaceOptionsFrame:SetScript('OnDragStop', function(self)
	self:StopMovingOrSizing()
end)
