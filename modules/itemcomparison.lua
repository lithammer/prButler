local _, addon = ...

local warlockWeights = {
    ITEM_MOD_INTELLECT_SHORT = 1,
    ITEM_MOD_STAMINA_SHORT = 1,
    ITEM_MOD_SPIRIT_SHORT = 0.5,
    ITEM_MOD_STRENGTH_SHORT = 0,
    ITEM_MOD_AGILITY_SHORT = 0,
    ITEM_MOD_DAMAGE_PER_SECOND_SHORT = 0,
    RESISTANCE0_NAME = 0,
}

local function ScoreWarlock(stats)
    local score = 0

    for stat, value in pairs(stats) do
        local weight = warlockWeights[stat]
        if weight == nil then
            return nil
        end

        score = score + value * weight
    end

    return score
end

---@param stats table<string, number>
---@param equippedStats table<string, number>
---@param class string
---@param equipLoc string
---@return boolean?
function addon.CompareItemStats(stats, equippedStats, class, equipLoc)
    if class == 'WARLOCK' and equipLoc ~= 'INVTYPE_RANGED' and equipLoc ~= 'INVTYPE_RANGEDRIGHT' then
        local score = ScoreWarlock(stats)
        local equippedScore = ScoreWarlock(equippedStats)

        if score and equippedScore and (score > 0 or equippedScore > 0) then
            if score ~= equippedScore then
                return score > equippedScore
            end

            return nil
        end
    end

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
