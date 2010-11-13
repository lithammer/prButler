local _, ns = ...

-- Accepts invites from friends and guild mates, also sends a /who request of the inviter
ns.autoAcceptInvite = true

-- Add a button to the loot frame that announces loot to raid chat
ns.announceLootButton = true

-- Filters the "gained a new ability" spam when switching spec and replaces it with a short informative message
ns.specSwitchFilter = true

-- Automatically sell grey items when visiting a vendor
ns.sellGrays = true

-- Automatically repair gear
ns.autoRepair = true

-- Error filter i.e. what errors NOT to show
ns.errorFilter = {
	["Not enough mana"] = true,
	["Spell is not ready yet."] = true,
	["Another action is in progress"] = true,
	["Ability is not ready yet."] = true,
	["Item is not ready yet."] = true,
	["Internal mail database error."] = true,
	["You can't do that yet"] = true,
	["Not enough runic power"] = true,
	["Not enough energy"] = true,
}
