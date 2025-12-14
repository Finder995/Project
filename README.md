# Project

## Freeroam gamemode (SA-MP 0.3.7)

A minimal freeroam-style gamemode for SA-MP 0.3.7 is available in `gamemodes/freeroam.pwn` with a compiled `freeroam.amx`.

### Commands
- `/help` – list available commands
- `/weapons` – gives a basic freeroam weapon loadout
- `/ls`, `/sf`, `/lv` – quick teleports to Los Santos, San Fierro or Las Venturas

### Build
If you want to recompile:
```bash
pawncc gamemodes/freeroam.pwn -o gamemodes/freeroam.amx
```

The shipped AMX was built against the Pawn Community Compiler 3.10.10 with SA-MP 0.3.7 compatibility pragmas enabled.
