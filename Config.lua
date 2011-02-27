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
	[ERR_SPELL_COOLDOWN] = true,
	[SPELL_FAILED_SPELL_IN_PROGRESS] = true,
	[ERR_ABILITY_COOLDOWN] = true,
	[ERR_ITEM_COOLDOWN] = true,
	[ERR_MAIL_DATABASE_ERROR] = true,
	[SPELL_FAILED_CASTER_AURASTATE] = true,
	[ERR_OUT_OF_MANA] = true,
	[ERR_OUT_OF_RUNIC_POWER] = true,
	[ERR_OUT_OF_ENERGY] = true,
	[ERR_OUT_OF_FOCUS] = true,
	[ERR_OUT_OF_RAGE] = true,
}