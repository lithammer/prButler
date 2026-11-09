local slots = {
    INVTYPE_HEAD = {1},
    INVTYPE_NECK = {2},
    INVTYPE_SHOULDER = {3},
    INVTYPE_BODY = {4},
    INVTYPE_CHEST = {5},
    INVTYPE_ROBE = {5},
    INVTYPE_WAIST = {6},
    INVTYPE_LEGS = {7},
    INVTYPE_FEET = {8},
    INVTYPE_WRIST = {9},
    INVTYPE_HAND = {10},
    INVTYPE_FINGER = {11, 12},
    INVTYPE_TRINKET = {13, 14},
    INVTYPE_CLOAK = {15},
    INVTYPE_WEAPON = {16, 17},
    INVTYPE_2HWEAPON = {16},
    INVTYPE_WEAPONMAINHAND = {16},
    INVTYPE_WEAPONOFFHAND = {17},
    INVTYPE_SHIELD = {17},
    INVTYPE_HOLDABLE = {17},
    INVTYPE_RANGED = {18},
    INVTYPE_RANGEDRIGHT = {18},
    INVTYPE_THROWN = {18},
    INVTYPE_RELIC = {18},
    INVTYPE_TABARD = {19},
}

local oneHand = {
    INVTYPE_WEAPON = true,
    INVTYPE_WEAPONMAINHAND = true,
    INVTYPE_WEAPONOFFHAND = true,
}

local function CompareStats(stats, equippedStats)
    local better, worse = false, false

    for stat, value in pairs(stats) do
        local equippedValue = equippedStats[stat] or 0
        better = better or value > equippedValue
        worse = worse or value < equippedValue
    end

    for stat, value in pairs(equippedStats) do
        if stats[stat] == nil then
            better = better or value < 0
            worse = worse or value > 0
        end
    end

    if better and not worse then
        return true
    elseif worse and not better then
        return false
    end
end

local function CompareItem(link, equipLoc)
    local itemSlots = slots[equipLoc]
    if not itemSlots then
        return
    end

    ---@type table<string, number>?
    local stats = C_Item.GetItemStats(link)
    if not stats then
        return
    end

    if equipLoc == 'INVTYPE_WEAPON' then
        local offHand = GetInventoryItemLink('player', 17)
        if not offHand then
            itemSlots = {16}
        else
            ---@type string?
            local offHandLoc = select(9, C_Item.GetItemInfo(offHand))
            if not offHandLoc then
                return
            end

            if not oneHand[offHandLoc] then
                itemSlots = {16}
            end
        end
    end

    local upgrade, downgrade = false, true
    for _, slot in ipairs(itemSlots) do
        local equipped = GetInventoryItemLink('player', slot)
        local equippedStats = {}

        if equipped then
            local equippedLoc = select(9, C_Item.GetItemInfo(equipped))
            -- Comparing weapon layouts needs a score for both hands.
            if slot >= 16 and slot <= 18 and equippedLoc ~= equipLoc and not (oneHand[equipLoc] and oneHand[equippedLoc]) then
                return
            end

            equippedStats = C_Item.GetItemStats(equipped)
            if not equippedStats then
                return
            end
        elseif slot == 17 then
            local mainHand = GetInventoryItemLink('player', 16)
            if mainHand then
                local mainHandLoc = select(9, C_Item.GetItemInfo(mainHand))
                if not mainHandLoc or mainHandLoc == 'INVTYPE_2HWEAPON' then
                    return
                end
            end
        end

        local comparison = CompareStats(stats, equippedStats)
        upgrade = upgrade or comparison == true
        downgrade = downgrade and comparison == false
    end

    if upgrade then
        return true
    elseif downgrade then
        return false
    end
end

local function UpdateContainer(container)
    for _, button in container:EnumerateValidItems() do
        if button.prButlerUnusable then
            button.prButlerUnusable:Hide()
            button.prButlerArrow:Hide()
        end

        ---@type ContainerItemInfo?
        local info = C_Container.GetContainerItemInfo(button:GetBagID(), button:GetID())
        if info and C_Item.GetItemInfo(info.hyperlink) then
            if not button.prButlerUnusable then
                local overlay = button:CreateTexture(nil, 'OVERLAY')
                overlay:SetAllPoints(button.icon)
                overlay:SetColorTexture(1, 0, 0, 0.35)
                overlay:Hide()
                button.prButlerUnusable = overlay

                local arrow = button:CreateTexture(nil, 'OVERLAY', nil, 7)
                arrow:SetSize(14, 14)
                arrow:SetPoint('TOPRIGHT', button.icon, 'TOPRIGHT', -1, -1)
                arrow:SetAtlas('bags-greenarrow')
                arrow:SetDesaturated(true)
                arrow:Hide()
                button.prButlerArrow = arrow
            end

            local usable = C_PlayerInfo.CanUseItem(info.itemID)
            button.prButlerUnusable:SetShown(not usable)

            if usable then
                local equipLoc = select(9, C_Item.GetItemInfo(info.hyperlink))
                local upgrade = CompareItem(info.hyperlink, equipLoc)

                if upgrade ~= nil then
                    local arrow = button.prButlerArrow
                    arrow:SetRotation(upgrade and 0 or math.pi)
                    arrow:SetVertexColor(upgrade and 0 or 1, upgrade and 1 or 0, 0)
                    arrow:Show()
                end
            end
        end
    end
end

local hooked = {}
local pending = false
local frame = CreateFrame('Frame')

frame:SetScript('OnEvent', function()
    if pending then
        return
    end

    pending = true
    C_Timer.After(0, function()
        pending = false

        for _, container in ContainerFrameUtil_EnumerateContainerFrames() do
            if not hooked[container] then
                hooksecurefunc(container, 'UpdateItems', UpdateContainer)
                container:HookScript('OnShow', UpdateContainer)
                hooked[container] = true
            end

            if container:IsShown() then
                UpdateContainer(container)
            end
        end
    end)
end)

frame:RegisterEvent('PLAYER_LOGIN')
frame:RegisterEvent('BAG_UPDATE_DELAYED')
frame:RegisterEvent('GET_ITEM_INFO_RECEIVED')
frame:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
frame:RegisterEvent('PLAYER_LEVEL_UP')
frame:RegisterEvent('SKILL_LINES_CHANGED')
frame:RegisterEvent('SPELLS_CHANGED')
frame:RegisterEvent('USE_COMBINED_BAGS_CHANGED')
