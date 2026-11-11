local resolveChannelName = ChatFrameUtil.ResolvePrefixedChannelName

---@param channelName string
---@return string
function ChatFrameUtil.ResolvePrefixedChannelName(channelName)
    local name = resolveChannelName(channelName)
    name = name:gsub('^%d+%. ', '')
    name = name:gsub(' %- .*', '')

    return name
end
