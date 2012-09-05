local _, config = ...

if not config.whisperHistory then return end

local WHISPERS_RECEIVED_BEGIN = 'Whispers receieved when AFK:'
local WHISPERS_RECEIVED_END = 'End'
local MESSAGE_FORMAT = '  |cfffa81ff[|Hplayer:%s:1:WHISPER:%s|h%s|h] whispered:|r %s'

local history = {}

local f = CreateFrame('Frame')
f:RegisterUnitEvent('PLAYER_FLAGS_CHANGED', 'player')

f:SetScript('OnEvent', function(self, event, ...)
	if event == 'PLAYER_FLAGS_CHANGED' then
		if UnitIsAFK('player') then
			f:RegisterEvent('CHAT_MSG_WHISPER')
			f:RegisterEvent('CHAT_MSG_BN_WHISPER')
		else
			f:UnregisterEvent('CHAT_MSG_WHISPER')
			f:UnregisterEvent('CHAT_MSG_BN_WHISPER')

			-- Display the history
			if #history > 0 then
				DEFAULT_CHAT_FRAME:AddMessage(WHISPERS_RECEIVED_BEGIN, 0, 1, 0)

				for _, msg in ipairs(history) do
					local message = MESSAGE_FORMAT:format(msg.sender, msg.sender:upper(), msg.sender, msg.message)
					DEFAULT_CHAT_FRAME:AddMessage(message)
				end

				DEFAULT_CHAT_FRAME:AddMessage(WHISPERS_RECEIVED_END, 1, 0, 0)
			end

			-- Clear the history stack
			table.wipe(history)
		end
	end

	if event == 'CHAT_MSG_WHISPER' or event == 'CHAT_MSG_BN_WHISPER' then
		local message, sender = ...
		local isRealID = event == 'CHAT_MSG_BN_WHISPER' and true or false

		-- Add whispers to the history stack
		table.insert(history, {message = message, sender = sender, isRealID = isRealID})
	end
end)
