# prButler

Small conveniences for World of Warcraft Forever.

- **Bags:** Tints items you cannot use with a transparent red overlay in
  Blizzard's bags. Green up arrows and red down arrows show item-level
  upgrades and downgrades against compatible equipped gear.
- **Merchant:** Sells junk automatically when you open a vendor, using the
  game's sell-all-junk action.
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
