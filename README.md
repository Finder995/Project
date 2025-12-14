# Project

## Freeroam gamemode (SA-MP 0.3.7)

A minimal freeroam-style gamemode for SA-MP 0.3.7 is available in `gamemodes/freeroam.pwn` with a compiled `freeroam.amx`.

### Commands
- `/help` – list available commands
- `/weapons` – basic freeroam weapon loadout
- `/ls`, `/sf`, `/lv` – quick teleports to Los Santos, San Fierro or Las Venturas
- `/heal` – restore health and armour
- `/day`, `/night` – set world time
- `/sunny`, `/rain` – switch weather
- `/infer`, `/nrg`, `/sultan`, `/turismo` – spawn and enter a personal vehicle
- `/clearcar` – remove your personal vehicle
- `/fixcar`, `/flipcar` – repair or upright your current vehicle
- `/skin <id>` – change skin (0-299)
- `/vw <id>` – set your virtual world
- `/mypos` – show your current coordinates
- `/announce <msg>` – broadcast a message to all players

### Build
If you want to recompile:
```bash
pawncc gamemodes/freeroam.pwn -o gamemodes/freeroam.amx
```

The shipped AMX was built against the Pawn Community Compiler 3.10.10 with SA-MP 0.3.7 compatibility pragmas enabled.

### Compiler
`tools/pawncc/pawncc` (Pawn Community Compiler 3.10.10) is bundled for convenience together with the upstream license.
