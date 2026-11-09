local history = {}
local frame = CreateFrame('Frame')

---@param _ Frame
frame:SetScript('OnEvent', function(_, event, ...)
    local afk = UnitIsAFK('player')
    if not canaccessvalue(afk) then
        return
    end

    if event == 'PLAYER_FLAGS_CHANGED' then
        if afk or #history == 0 then
            return
        end

        DEFAULT_CHAT_FRAME:AddMessage('Whispers received while AFK:', 0, 1, 0)

        for _, entry in ipairs(history) do
            local color = assert(ChatTypeInfo[entry.chatType], 'Missing whisper chat color')
            DEFAULT_CHAT_FRAME:AddMessage(entry.text, color.r, color.g, color.b)
        end

        wipe(history)
        return
    end

    if not afk then
        return
    end

    local message, sender = ...
    local lineID = select(11, ...)
    local link
    local chatType

    if event == 'CHAT_MSG_BN_WHISPER' then
        local accountID = select(13, ...)
        link = GetBNPlayerLink(sender, '[' .. sender .. ']', accountID, lineID, 'BN_WHISPER', 0)
        chatType = 'BN_WHISPER'
    else
        link = GetPlayerLink(sender, '[' .. sender .. ']', lineID, 'WHISPER', sender)
        chatType = 'WHISPER'
    end

    table.insert(history, {
        text = link .. ' whispered: ' .. message,
        chatType = chatType,
    })
end)

frame:RegisterUnitEvent('PLAYER_FLAGS_CHANGED', 'player')
frame:RegisterEvent('CHAT_MSG_WHISPER')
frame:RegisterEvent('CHAT_MSG_BN_WHISPER')
