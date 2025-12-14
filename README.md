# Project

## Freeroam Extended Gamemode (SA-MP 0.3.7)

An extended freeroam gamemode for SA-MP 0.3.7 featuring player statistics, admin system, duels, private messaging, and much more!

### Features
- **Player Statistics**: Kill/Death tracking, K/D ratio, money system
- **Admin System**: 4-level admin hierarchy (None/Mod/Admin/Owner)
- **Duel System**: Challenge other players to 1v1 duels
- **Private Messaging**: PM and quick-reply functionality
- **God Mode & Jetpack**: Fun features for freeroam
- **Anti-Cheat**: Basic health monitoring
- **Extended Teleports**: 15+ locations across San Andreas
- **Extended Vehicles**: Spawn any vehicle by ID, plus quick commands

### Commands

#### General
- `/help` – show help menu
- `/cmds` – full command list
- `/stats` – view your statistics
- `/kills`, `/deaths`, `/money` – quick stat checks

#### Combat
- `/weapons` – get weapon pack (Deagle, M4, Sniper)
- `/heal` – restore health and armour
- `/armour` – full armour
- `/kill` – suicide
- `/god` – toggle god mode (invincibility)
- `/jetpack` – equip jetpack

#### Teleports
- `/ls`, `/sf`, `/lv` – main cities
- `/grove`, `/ballas` – gang territories
- `/airport`, `/beach`, `/marina` – locations
- `/tower`, `/china`, `/caligulas`, `/strip`, `/chiliad` – landmarks

#### Vehicles
- `/v [400-611]` – spawn vehicle by model ID
- `/infer`, `/nrg`, `/sultan`, `/turismo`, `/bullet` – sports cars
- `/hydra`, `/hunter`, `/rhino` – military vehicles
- `/pcj`, `/sanchez`, `/cheetah`, `/banshee` – more vehicles
- `/clearcar`, `/fixcar`, `/flipcar` – vehicle management

#### Social
- `/pm [id] [msg]` – private message
- `/r [msg]` – reply to last PM
- `/announce [msg]` – broadcast announcement
- `/duel [id]` – challenge to duel
- `/cancelduel` – cancel active duel

#### Weather & Time
- `/day`, `/night` – quick time change
- `/time [0-23]` – set specific hour
- `/sunny`, `/rain`, `/storm`, `/foggy` – quick weather
- `/weather [0-45]` – set specific weather

#### Utility
- `/skin [0-299]` – change skin
- `/vw [id]` – set virtual world
- `/mypos` – show coordinates

#### Admin Commands
**Moderator (Level 1+):**
- `/kick [id]` – kick player
- `/mute [id]`, `/unmute [id]` – mute management
- `/slap [id]` – slap player into air
- `/goto [id]` – teleport to player
- `/gethere [id]` – bring player to you

**Admin (Level 2+):**
- `/ban [id]` – ban player

**Owner (Level 3):**
- `/setadmin [id] [0-3]` – set admin level

### Build
```bash
pawncc gamemodes/freeroam.pwn -o gamemodes/freeroam.amx
```

The shipped AMX was built against the Pawn Community Compiler 3.10.10 with SA-MP 0.3.7 compatibility pragmas enabled.

### Compiler
`tools/pawncc/pawncc` (Pawn Community Compiler 3.10.10) is bundled for convenience together with the upstream license.
