local window = CreateFrame('Frame', 'prButlerChatCopy', UIParent, 'BasicFrameTemplateWithInset')
window:SetSize(640, 420)
window:SetPoint('CENTER')
window:SetFrameStrata('DIALOG')
window.TitleText:SetText('Copy chat')
window:Hide()
table.insert(UISpecialFrames, 'prButlerChatCopy')

local help = window:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
help:SetPoint('TOPLEFT', 16, -36)
help:SetText('Select text and press Ctrl+C to copy. Press Escape to close.')

local scroll = CreateFrame('ScrollFrame', nil, window, 'UIPanelInputScrollFrameTemplate')
scroll:SetPoint('TOPLEFT', 20, -60)
scroll:SetPoint('BOTTOMRIGHT', -38, 20)
scroll.CharCount:Hide()

local editBox = scroll.EditBox
editBox:SetWidth(scroll:GetWidth() - 18)
editBox:SetScript('OnEscapePressed', function()
    window:Hide()
end)
window:SetScript('OnHide', function()
    editBox:ClearFocus()
    editBox:SetText('')
end)

local function ShowChat(chatFrame)
    local lines = {}

    for index = 1, chatFrame:GetNumMessages() do
        local text = chatFrame:GetMessageInfo(index)
        if canaccessvalue(text) and text then
            table.insert(lines, C_StringUtil.StripHyperlinks(text, false, true))
        end
    end

    window:Show()
    editBox:SetText(table.concat(lines, '\n'))
    editBox:SetFocus()
    editBox:HighlightText()
    scroll:SetVerticalScroll(0)
end

local function AddButtons()
    for _, name in ipairs(CHAT_FRAMES) do
        local chatFrame = _G[name]
        if not chatFrame.prButlerCopy then
            local button = CreateFrame('Button', nil, chatFrame, 'UIPanelSquareButton')
            button:SetSize(26, 26)
            button:SetPoint('BOTTOM', chatFrame.buttonFrame, 'BOTTOM', 0, 36)
            button.icon:SetTexture('Interface/FriendsFrame/UI-FriendsFrame-Note')
            button.icon:SetTexCoord(0, 1, 0, 1)
            button.icon:SetSize(14, 12)
            button.icon:SetPoint('CENTER', 2, 0)
            button.icon:SetVertexColor(1, 0.82, 0)
            button:SetScript('OnMouseDown', function()
                button.icon:SetPoint('CENTER', 1, -1)
            end)
            button:SetScript('OnMouseUp', function()
                button.icon:SetPoint('CENTER', 2, 0)
            end)
            button:SetScript('OnEnter', function(self)
                GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
                GameTooltip:SetText('Copy chat')
                GameTooltip:Show()
            end)
            button:SetScript('OnLeave', function()
                GameTooltip:Hide()
            end)
            button:SetScript('OnClick', function()
                GameTooltip:Hide()
                ShowChat(chatFrame)
            end)
            chatFrame.prButlerCopy = button
        end
    end
end

local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_LOGIN')
frame:SetScript('OnEvent', AddButtons)
hooksecurefunc('FCF_OpenNewWindow', AddButtons)
hooksecurefunc('FCF_OpenTemporaryWindow', AddButtons)
