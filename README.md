# Project

## Freeroam Extended Gamemode v2.0 (SA-MP 0.3.7)

An extended freeroam gamemode for SA-MP 0.3.7 featuring player statistics, admin system, duels, private messaging, and much more!

### Features
- **Player Statistics**: Kill/Death tracking, K/D ratio, money system, kill streaks
- **Admin System**: 4-level admin hierarchy (None/Mod/Admin/Owner)
- **Duel System**: Challenge other players to 1v1 duels with rewards
- **Private Messaging**: PM and quick-reply functionality
- **God Mode & Jetpack**: Fun features for freeroam
- **Anti-Cheat**: Basic health monitoring
- **Extended Teleports**: 15+ locations across San Andreas
- **Extended Vehicles**: Spawn any vehicle by ID, plus quick commands
- **Spawn Protection**: 5-second invulnerability after spawn
- **Gang System**: Join 4 different gangs with unique colors and kill bonuses
- **VIP System**: 3 VIP levels with money multipliers and bonus weapons
- **Lottery System**: Buy tickets and win the jackpot every 5 minutes
- **Racing System**: Create and join races with prize pools
- **Achievement System**: 8 achievements to unlock with money rewards
- **Kill Streak System**: Announcements for killing sprees

### Commands

#### General
- `/help` – show help menu
- `/cmds` – full command list
- `/stats` – view your statistics (kills, deaths, K/D, gang, VIP, streaks)
- `/kills`, `/deaths`, `/money` – quick stat checks
- `/achievements` – view your achievements

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

#### Gang System (NEW)
- `/gang [0-4]` – join a gang (0=None, 1=Grove, 2=Ballas, 3=Aztecas, 4=Vagos)
- `/ganglist` – view available gangs
- `/gangstats` – view gang member counts
- Kill enemy gang members for +$250 bonus!

#### VIP System (NEW)
- `/vip` – view your VIP status and benefits
- `/vipinfo` – view VIP level benefits
- VIP Bronze: 25% money bonus
- VIP Silver: 50% money bonus + Minigun on spawn
- VIP Gold: 100% money bonus + Minigun on spawn

#### Lottery System (NEW)
- `/lottery [1-100]` – buy a ticket for $100
- `/lotteryinfo` – view current pool and your ticket
- Drawings every 5 minutes!

#### Racing System (NEW)
- `/race` – create a new race ($500 entry)
- `/joinrace` – join an active race
- `/startrace` – start the race (creator only)
- `/leaverace` – leave current race
- `/raceinfo` – view race status

#### Admin Commands
**Moderator (Level 1+):**
- `/kick [id]` – kick player
- `/mute [id]`, `/unmute [id]` – mute management
- `/slap [id]` – slap player into air
- `/goto [id]` – teleport to player
- `/gethere [id]` – bring player to you
- `/freeze [id]`, `/unfreeze [id]` – freeze/unfreeze player
- `/spectate [id]` – spectate player from above

**Admin (Level 2+):**
- `/ban [id]` – ban player
- `/setvip [id] [0-3]` – set VIP level
- `/givemoney [id] [amount]` – give money to player
- `/giveweapon [id] [weaponid] [ammo]` – give weapon to player
- `/explode [id]` – explode a player

**Owner (Level 3):**
- `/setadmin [id] [0-3]` – set admin level

### Achievements
1. **First Blood** – Get your first kill
2. **Killer** – Get 10 kills
3. **Assassin** – Get 50 kills
4. **Terminator** – Get 100 kills
5. **Duel Champion** – Win a duel
6. **Race Winner** – Win a race
7. **Lucky Winner** – Win the lottery
8. **Millionaire** – Have $1,000,000

### Build
```bash
./tools/pawncc/pawncc gamemodes/freeroam.pwn -o gamemodes/freeroam.amx
```

The shipped AMX was built against the Pawn Community Compiler 3.10.10 with SA-MP 0.3.7 compatibility pragmas enabled.

### Compiler
`tools/pawncc/pawncc` (Pawn Community Compiler 3.10.10) is bundled for convenience together with the upstream license.
