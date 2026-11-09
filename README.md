# prButler

Sells vendor junk and shows whispers received while AFK in World of Warcraft
Forever (client 1.60.1, interface 16001).

Uses the game's own sell-all-junk action, with the same item rules as the
vendor's **Sell All Junk** button. It runs only when the game enables that
action and there are junk items to sell.

Copy the `prButler` folder into `_forever_/Interface/AddOns/`, then enable
prButler in the character selection screen's AddOns list. Open a vendor with
a grey item in your bags to check that it sells; keep a white or better item
alongside it to check that it stays.

Whispers from characters and Battle.net friends received while AFK are shown
in the default chat window when you return. Sender names link to the right
whisper target. The backlog clears after it is shown and does not survive a
reload or logout. To check it, use `/afk`, receive a whisper, then use `/afk`
again to return.

There are no settings or dependencies.

API reference: [Forever merchant API](https://github.com/Gethe/wow-ui-source/blob/forever/Interface/AddOns/Blizzard_APIDocumentationGenerated/MerchantFrameDocumentation.lua)
and [Blizzard's vendor UI](https://github.com/Gethe/wow-ui-source/blob/forever/Interface/AddOns/Blizzard_UIPanels_Game/Mainline/MerchantFrame.lua).
