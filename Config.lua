-- Use guild bank funds for repair (if possible)
useGuildBank = false
-- Prints a list of sold items
detailedJunkSell = true

-- Error filter i.e. what errors NOT to show
errorFilter = {
	["Not enough mana"] = true,
	["Spell is not ready yet."] = true,
	["Another action is in progress"] = true,
	["Ability is not ready yet."] = true,
	["Item is not ready yet."] = true,
	["Internal mail database error."] = true,
	["You can't do that yet"] = true,
}

-- Highlights nameplates for these units by coloring the healthbar
-- http://www.wowwiki.com/WoW_Constants/Errors
unitFilter = {
	"Cult Fanatic",		-- Lady Deathwhisper, ICC
	"Reanimated Fanatic",	-- Lady Deathwhisper, ICC
	"Empowered Fanatic",
}
-- Sets the bar color of the highlighted nameplates
highlightColor = {r = 1, g = 0, b = 1}

-- Buff reminder for important buffs like Fel Armor, Horn of Winter etc.
buffReminder = true