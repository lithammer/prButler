# prButler

Small conveniences for World of Warcraft Forever.

- **Unusable items:** Tints items you cannot use with a transparent red overlay
  in Blizzard's bags.
- **Stat hints:** A green up arrow means no numeric stat is worse and at least
  one is better than compatible equipped gear; red down means the reverse.
  Tradeoffs show no arrow, and effects and set bonuses are not scored.
- **Merchant:** Sells junk automatically when you open a vendor, using the
  game's sell-all-junk action.
- **Copy chat:** Adds a button on the left of the chat window to copy chat history.
- **Whisper history:** Shows character and Battle.net whispers received while
  AFK when you return, with clickable sender names. The backlog clears after
  it is shown or the UI reloads.

## Checks

Run [wowlua-ls](https://github.com/TradeSkillMaster/wowlua-ls) with the
repo's Forever configuration:

```sh
wowlua_ls check --severity hint .
```

Enable the pre-commit hook in each checkout:

```sh
git config core.hooksPath .githooks
```

The hook checks the working tree and blocks commits on diagnostics or a
missing checker. UI and event behavior still need in-game checks.
