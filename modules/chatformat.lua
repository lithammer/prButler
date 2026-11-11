local resolveChannelName = ChatFrameUtil.ResolvePrefixedChannelName

CHAT_GUILD_GET = CHAT_GUILD_GET:gsub('%b[]', '[G]', 1)

---@param channelName string
---@return string
function ChatFrameUtil.ResolvePrefixedChannelName(channelName)
    local name = resolveChannelName(channelName)
    name = name:gsub('^%d+%. ', '')
    name = name:gsub('^General %- ', 'G: ')
    name = name:gsub('^LocalDefense %- ', 'LD: ')

    if name == 'Trade (Services)' or name:match('^Trade %(Services%) %- ') then
        return 'TS'
    end

    if name == 'Trade' or name:match('^Trade %- ') then
        return 'T'
    end

    return name
end
