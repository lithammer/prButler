# prButler

Bag item hints, vendor junk selling, and AFK whisper history for World of
Warcraft Forever (client 1.60.1, interface 16001).

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

In Blizzard's bags, a transparent red overlay marks items the character cannot
use. A green up arrow means higher item level than equipped gear; a red down
arrow means lower. Equal item levels have no arrow. These are item-level hints,
not stat or class/spec recommendations.

Rings and trinkets compare against the weaker equipped item; an empty slot
counts as item level zero. Weapon comparisons require the same weapon layout.
No arrow is shown for an unusable item, missing item data, or a weapon change
that needs a different hand setup. Both separate and combined bags are covered;
replacement bag addons are not supported.

To check the bag hints, carry usable and unusable gear, compare higher/lower
item levels, then equip an item and move items between slots. The hints should
refresh without hovering.

There are no settings or dependencies.

API reference: [Forever merchant API](https://github.com/Gethe/wow-ui-source/blob/forever/Interface/AddOns/Blizzard_APIDocumentationGenerated/MerchantFrameDocumentation.lua)
and [Blizzard's vendor UI](https://github.com/Gethe/wow-ui-source/blob/forever/Interface/AddOns/Blizzard_UIPanels_Game/Mainline/MerchantFrame.lua).
