#pragma tabsize 4
#pragma compat 1
#pragma rational Float

// SA-MP 0.3.7 freeroam gamemode - Extended Edition
// Features: Stats, Admin system, Duels, PM, Money, Jetpack, God mode

native SendClientMessage(playerid, color, const message[]);
native GameTextForPlayer(playerid, const string[], time, style);
native SetGameModeText(const text[]);
native ShowPlayerMarkers(mode);
native ShowNameTags(mode);
native UsePlayerPedAnims();
native EnableStuntBonusForAll(toggle);
native SetWorldTime(hour);
native SetWeather(weatherid);
native AddPlayerClass(modelid, Float:x, Float:y, Float:z, Float:a, weapon1, ammo1, weapon2, ammo2, weapon3, ammo3);
native AddStaticVehicle(modelid, Float:x, Float:y, Float:z, Float:a, color1, color2);
native CreateVehicle(modelid, Float:x, Float:y, Float:z, Float:a, color1, color2, respawnDelay);
native GetVehiclePos(vehicleid, &Float:x, &Float:y, &Float:z);
native SetVehiclePos(vehicleid, Float:x, Float:y, Float:z);
native RepairVehicle(vehicleid);
native SetVehicleHealth(vehicleid, Float:health);
native SetVehicleZAngle(vehicleid, Float:z_angle);
native SetPlayerInterior(playerid, interiorid);
native SetPlayerVirtualWorld(playerid, worldid);
native SetPlayerPos(playerid, Float:x, Float:y, Float:z);
native SetPlayerFacingAngle(playerid, Float:a);
native GetPlayerFacingAngle(playerid, &Float:a);
native GivePlayerWeapon(playerid, weaponid, ammo);
native SetPlayerHealth(playerid, Float:health);
native SetPlayerArmour(playerid, Float:armour);
native GetPlayerHealth(playerid, &Float:health);
native SetPlayerSkin(playerid, skinid);
native IsPlayerConnected(playerid);
native GetPlayerPos(playerid, &Float:x, &Float:y, &Float:z);
native GetPlayerVehicleID(playerid);
native SendClientMessageToAll(color, const message[]);
native PutPlayerInVehicle(playerid, vehicleid, seatid);
native GetPlayerState(playerid);
native DestroyVehicle(vehicleid);
native strcmp(const string1[], const string2[], bool:ignorecase=false, pos=0, length=-1);
native random(max);
native strval(const string[]);
native format(dest[], size=sizeof dest, const format[], {Float,_}:...);
native strlen(const string[]);
native GetPlayerName(playerid, name[], len);
native Kick(playerid);
native Ban(playerid);
native SetSpawnInfo(playerid, team, skin, Float:x, Float:y, Float:z, Float:rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
native SpawnPlayer(playerid);
native SetPlayerSpecialAction(playerid, actionid);
native GivePlayerMoney(playerid, money);
native GetPlayerMoney(playerid);
native ResetPlayerMoney(playerid);
native SetPlayerScore(playerid, score);
native GetPlayerScore(playerid);
native SetPlayerColor(playerid, color);
native GetTickCount();
native SetTimer(const funcname[], interval, repeating);
native KillTimer(timerid);
native TextDrawCreate(Float:x, Float:y, const text[]);
native TextDrawDestroy(text);
native TextDrawShowForPlayer(playerid, text);
native TextDrawHideForPlayer(playerid, text);
native TextDrawSetString(text, const string[]);
native TextDrawFont(text, font);
native TextDrawColor(text, color);
native TextDrawSetOutline(text, size);
native TextDrawSetShadow(text, size);
native TextDrawLetterSize(text, Float:x, Float:y);
native TextDrawBackgroundColor(text, color);
native TextDrawBoxColor(text, color);
native TextDrawUseBox(text, use);
native TextDrawSetProportional(text, set);

forward OnGameModeInit();
forward OnGameModeExit();
forward OnPlayerConnect(playerid);
forward OnPlayerDisconnect(playerid, reason);
forward OnPlayerSpawn(playerid);
forward OnPlayerDeath(playerid, killerid, reason);
forward OnPlayerCommandText(playerid, const cmdtext[]);
forward OnPlayerText(playerid, const text[]);
forward DuelCountdown();
forward AntiCheatCheck();

#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_GREEN 0x33FF33FF
#define COLOR_CYAN  0x33CCFFFF
#define COLOR_RED   0xFF3333FF
#define COLOR_YELLOW 0xFFFF00FF
#define COLOR_ORANGE 0xFF9900FF
#define COLOR_BLUE  0x3399FFFF
#define COLOR_PURPLE 0x9933FFFF
#define COLOR_PINK  0xFF66CCFF
#define COLOR_GREY  0xAAAAAFFF
#define MAX_PLAYERS 500
#define INVALID_VEHICLE_ID (-1)
#define INVALID_PLAYER_ID 0xFFFF
#define DEFAULT_SKIN 0
#define WEAPON_DEAGLE 24
#define WEAPON_M4     31
#define WEAPON_SNIPER 34
#define WEAPON_SHOTGUN 25
#define WEAPON_AK47   30
#define WEAPON_MINIGUN 38
#define STUNT_BONUS_DISABLED 0
#define DEFAULT_WORLD_TIME 12
#define NIGHT_WORLD_TIME 0
#define DEFAULT_WEATHER 1
#define RAIN_WEATHER 16
#define STORM_WEATHER 8
#define FOGGY_WEATHER 9
#define DEFAULT_HEALTH (100.0)
#define DEFAULT_ARMOUR (50.0)
#define SPAWN_TEXT_TIME 3000
#define SPAWN_TEXT_STYLE 3
#define MAX_SKIN_ID 299
#define PLAYER_STATE_DRIVER 2
#define FLIP_HEIGHT_OFFSET (0.7)
#define SPECIAL_ACTION_NONE 0
#define SPECIAL_ACTION_USEJETPACK 2

// Admin levels
#define ADMIN_LEVEL_NONE 0
#define ADMIN_LEVEL_MOD 1
#define ADMIN_LEVEL_ADMIN 2
#define ADMIN_LEVEL_OWNER 3

// Duel states
#define DUEL_STATE_NONE 0
#define DUEL_STATE_PENDING 1
#define DUEL_STATE_COUNTDOWN 2
#define DUEL_STATE_ACTIVE 3

// Starting money
#define START_MONEY 5000
#define KILL_REWARD 500
#define DEATH_PENALTY 100

enum SpawnPoint
{
    Float:SpawnX,
    Float:SpawnY,
    Float:SpawnZ,
    Float:SpawnAngle
};

new Float:gSpawnPoints[][SpawnPoint] =
{
    {1958.3783, 1343.1572, 15.3746, 270.1425},
    {-2026.9636, 137.9882, 28.8359, 359.6148},
    {1154.5635, 2073.9988, 11.0625, 88.5000},
    {1480.5654, -1738.5825, 13.3828, 272.4587},
    {-1429.8967, 2597.4829, 55.8359, 315.8423}
};

#define SPAWN_LOS_SANTOS   0
#define SPAWN_SAN_FIERRO   1
#define SPAWN_LAS_VENTURAS 2
#define SPAWN_LOS_SANTOS_SOUTH 3
#define SPAWN_BAYSIDE          4

// Additional teleport locations
new Float:gTeleportLocations[][SpawnPoint] =
{
    {1529.6, -1691.2, 13.5, 0.0},      // Grove Street
    {2495.3, -1690.7, 14.0, 0.0},      // Ballas territory
    {-1268.0, -44.4, 14.1, 0.0},       // SF Airport
    {331.0, -1794.0, 4.5, 0.0},        // Santa Maria Beach
    {-2242.5, 2284.0, 4.5, 0.0},       // Bayside Marina
    {1544.0, -1353.0, 329.5, 0.0},     // LS Tower (skyscraper)
    {-1705.0, 936.0, 24.9, 0.0},       // SF Chinatown
    {2202.2, 1204.5, 10.8, 0.0},       // LV Caligulas
    {2033.0, 1545.0, 10.8, 0.0},       // LV Strip
    {-310.0, 1537.0, 75.6, 0.0}        // Mt Chiliad
};

enum VehicleSpawn
{
    VModel,
    Float:VehX,
    Float:VehY,
    Float:VehZ,
    Float:VehAngle,
    VehColor1,
    VehColor2
};

new gVehicles[][VehicleSpawn] =
{
    {411, 1952.4023, 1341.0563, 15.3746, 270.0000, 0, 1},    // Infernus
    {522, 1946.7347, 1343.3307, 15.1719, 270.0000, 6, 6},    // NRG-500
    {541, 1940.9707, 1345.2957, 15.3746, 270.0000, 3, 3},    // Bullet
    {560, 1935.6541, 1342.6992, 15.3746, 270.0000, 1, 0},    // Sultan
    {451, 1929.2711, 1340.2142, 15.3746, 270.0000, 2, 2}     // Turismo
};

new gPlayerVehicles[MAX_PLAYERS];

// Player statistics
enum PlayerStats
{
    pKills,
    pDeaths,
    pAdminLevel,
    bool:pGodMode,
    bool:pMuted,
    pDuelOpponent,
    pDuelState,
    pLastPM
};
new gPlayerData[MAX_PLAYERS][PlayerStats];

// Duel system
new gDuelCountdown = 0;
new gDuelTimer = -1;
new gDuelPlayer1 = INVALID_PLAYER_ID;
new gDuelPlayer2 = INVALID_PLAYER_ID;

// Duel arena position
new Float:gDuelPos1[4] = {1296.6, -1414.6, 13.5, 90.0};
new Float:gDuelPos2[4] = {1326.6, -1414.6, 13.5, 270.0};

stock TeleportPlayer(playerid, Float:x, Float:y, Float:z, Float:a)
{
    if (!IsPlayerConnected(playerid))
    {
        return 0;
    }

    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid, x, y, z);
    SetPlayerFacingAngle(playerid, a);
    return 1;
}

stock ResetPlayerVehicle(playerid)
{
    if (gPlayerVehicles[playerid] != INVALID_VEHICLE_ID)
    {
        DestroyVehicle(gPlayerVehicles[playerid]);
        gPlayerVehicles[playerid] = INVALID_VEHICLE_ID;
    }
    return 1;
}

stock bool:TryParseIntParam(const cmdtext[], &value)
{
    new idx = 0;
    while (cmdtext[idx] && cmdtext[idx] != ' ') idx++;
    while (cmdtext[idx] == ' ') idx++;
    if (!cmdtext[idx]) return false;
    value = strval(cmdtext[idx]);
    return true;
}

stock ParseStringParam(const cmdtext[], dest[], size)
{
    dest[0] = '\0';
    new idx = 0, di = 0;
    while (cmdtext[idx] && cmdtext[idx] != ' ') idx++;
    while (cmdtext[idx] == ' ') idx++;
    if (!cmdtext[idx]) return 0;

    while (cmdtext[idx] && di < size - 1)
    {
        dest[di++] = cmdtext[idx++];
    }
    dest[di] = '\0';
    return 1;
}

stock bool:IsDriver(playerid)
{
    return GetPlayerState(playerid) == PLAYER_STATE_DRIVER;
}

stock FixPlayerVehicle(playerid)
{
    if (!IsDriver(playerid))
    {
        return 0;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    if (vehicleid == 0) return 0;

    RepairVehicle(vehicleid);
    SetVehicleHealth(vehicleid, 1000.0);
    return 1;
}

stock FlipPlayerVehicle(playerid)
{
    if (!IsDriver(playerid))
    {
        return 0;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    if (vehicleid == 0) return 0;

    new Float:x, Float:y, Float:z;
    GetVehiclePos(vehicleid, x, y, z);
    SetVehiclePos(vehicleid, x, y, z + FLIP_HEIGHT_OFFSET);
    SetVehicleZAngle(vehicleid, 0.0);
    return 1;
}

stock CreateAndWarpVehicle(playerid, modelid, color1, color2)
{
    if (!IsPlayerConnected(playerid))
    {
        return 0;
    }

    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    ResetPlayerVehicle(playerid);
    gPlayerVehicles[playerid] = CreateVehicle(modelid, x + 2.0, y, z, a, color1, color2, -1);

    if (gPlayerVehicles[playerid] != INVALID_VEHICLE_ID)
    {
        PutPlayerInVehicle(playerid, gPlayerVehicles[playerid], 0);
    }
    return 1;
}

stock GiveFreeroamWeapons(playerid)
{
    GivePlayerWeapon(playerid, WEAPON_DEAGLE, 300);   // Deagle
    GivePlayerWeapon(playerid, WEAPON_M4, 500);   // M4
    GivePlayerWeapon(playerid, WEAPON_SNIPER, 50);    // Sniper
    return 1;
}

stock GetName(playerid, name[], len)
{
    if (!IsPlayerConnected(playerid))
    {
        name[0] = '\0';
        return 0;
    }
    GetPlayerName(playerid, name, len);
    return 1;
}

stock ResetPlayerStats(playerid)
{
    gPlayerData[playerid][pKills] = 0;
    gPlayerData[playerid][pDeaths] = 0;
    gPlayerData[playerid][pAdminLevel] = ADMIN_LEVEL_NONE;
    gPlayerData[playerid][pGodMode] = false;
    gPlayerData[playerid][pMuted] = false;
    gPlayerData[playerid][pDuelOpponent] = INVALID_PLAYER_ID;
    gPlayerData[playerid][pDuelState] = DUEL_STATE_NONE;
    gPlayerData[playerid][pLastPM] = INVALID_PLAYER_ID;
    return 1;
}

stock IsAdmin(playerid, level)
{
    return gPlayerData[playerid][pAdminLevel] >= level;
}

stock SendAdminMessage(color, const message[])
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && IsAdmin(i, ADMIN_LEVEL_MOD))
        {
            SendClientMessage(i, color, message);
        }
    }
    return 1;
}

stock CancelDuel()
{
    if (gDuelTimer != -1)
    {
        KillTimer(gDuelTimer);
        gDuelTimer = -1;
    }
    
    if (gDuelPlayer1 != INVALID_PLAYER_ID && IsPlayerConnected(gDuelPlayer1))
    {
        gPlayerData[gDuelPlayer1][pDuelState] = DUEL_STATE_NONE;
        gPlayerData[gDuelPlayer1][pDuelOpponent] = INVALID_PLAYER_ID;
    }
    
    if (gDuelPlayer2 != INVALID_PLAYER_ID && IsPlayerConnected(gDuelPlayer2))
    {
        gPlayerData[gDuelPlayer2][pDuelState] = DUEL_STATE_NONE;
        gPlayerData[gDuelPlayer2][pDuelOpponent] = INVALID_PLAYER_ID;
    }
    
    gDuelPlayer1 = INVALID_PLAYER_ID;
    gDuelPlayer2 = INVALID_PLAYER_ID;
    gDuelCountdown = 0;
    return 1;
}

stock StartDuel(player1, player2)
{
    if (!IsPlayerConnected(player1) || !IsPlayerConnected(player2))
    {
        return 0;
    }
    
    gDuelPlayer1 = player1;
    gDuelPlayer2 = player2;
    gDuelCountdown = 5;
    
    gPlayerData[player1][pDuelState] = DUEL_STATE_COUNTDOWN;
    gPlayerData[player1][pDuelOpponent] = player2;
    gPlayerData[player2][pDuelState] = DUEL_STATE_COUNTDOWN;
    gPlayerData[player2][pDuelOpponent] = player1;
    
    // Teleport players to duel arena
    SetPlayerPos(player1, gDuelPos1[0], gDuelPos1[1], gDuelPos1[2]);
    SetPlayerFacingAngle(player1, gDuelPos1[3]);
    SetPlayerPos(player2, gDuelPos2[0], gDuelPos2[1], gDuelPos2[2]);
    SetPlayerFacingAngle(player2, gDuelPos2[3]);
    
    // Give weapons
    GivePlayerWeapon(player1, WEAPON_DEAGLE, 100);
    GivePlayerWeapon(player2, WEAPON_DEAGLE, 100);
    
    SetPlayerHealth(player1, 100.0);
    SetPlayerHealth(player2, 100.0);
    SetPlayerArmour(player1, 0.0);
    SetPlayerArmour(player2, 0.0);
    
    gDuelTimer = SetTimer("DuelCountdown", 1000, 1);
    
    SendClientMessage(player1, COLOR_YELLOW, "Duel starting in 5 seconds! Get ready!");
    SendClientMessage(player2, COLOR_YELLOW, "Duel starting in 5 seconds! Get ready!");
    
    return 1;
}

public DuelCountdown()
{
    if (gDuelCountdown > 0)
    {
        new msg[64];
        format(msg, sizeof(msg), "~r~%d", gDuelCountdown);
        
        if (IsPlayerConnected(gDuelPlayer1))
            GameTextForPlayer(gDuelPlayer1, msg, 1000, 3);
        if (IsPlayerConnected(gDuelPlayer2))
            GameTextForPlayer(gDuelPlayer2, msg, 1000, 3);
        
        gDuelCountdown--;
    }
    else
    {
        if (IsPlayerConnected(gDuelPlayer1))
        {
            GameTextForPlayer(gDuelPlayer1, "~g~FIGHT!", 1000, 3);
            gPlayerData[gDuelPlayer1][pDuelState] = DUEL_STATE_ACTIVE;
        }
        if (IsPlayerConnected(gDuelPlayer2))
        {
            GameTextForPlayer(gDuelPlayer2, "~g~FIGHT!", 1000, 3);
            gPlayerData[gDuelPlayer2][pDuelState] = DUEL_STATE_ACTIVE;
        }
        
        KillTimer(gDuelTimer);
        gDuelTimer = -1;
    }
    return 1;
}

public AntiCheatCheck()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && !gPlayerData[i][pGodMode])
        {
            new Float:health;
            GetPlayerHealth(i, health);
            if (health > 100.0)
            {
                SetPlayerHealth(i, 100.0);
            }
        }
    }
    return 1;
}

main()
{
    return 1;
}

public OnGameModeInit()
{
    SetGameModeText("Freeroam Extended");
    ShowPlayerMarkers(1);
    ShowNameTags(1);
    UsePlayerPedAnims();
    EnableStuntBonusForAll(STUNT_BONUS_DISABLED);
    SetWorldTime(DEFAULT_WORLD_TIME);
    SetWeather(DEFAULT_WEATHER);

    for (new p = 0; p < MAX_PLAYERS; p++)
    {
        gPlayerVehicles[p] = INVALID_VEHICLE_ID;
        ResetPlayerStats(p);
    }

    for (new i = 0; i < sizeof(gSpawnPoints); i++)
    {
        AddPlayerClass(DEFAULT_SKIN, gSpawnPoints[i][SpawnX], gSpawnPoints[i][SpawnY], gSpawnPoints[i][SpawnZ], gSpawnPoints[i][SpawnAngle], 0, 0, 0, 0, 0, 0);
    }

    // Spawn some fast vehicles
    for (new i = 0; i < sizeof(gVehicles); i++)
    {
        AddStaticVehicle(gVehicles[i][VModel], gVehicles[i][VehX], gVehicles[i][VehY], gVehicles[i][VehZ], gVehicles[i][VehAngle], gVehicles[i][VehColor1], gVehicles[i][VehColor2]);
    }
    
    // Anti-cheat timer
    SetTimer("AntiCheatCheck", 5000, 1);

    return 1;
}

public OnGameModeExit()
{
    return 1;
}

public OnPlayerConnect(playerid)
{
    gPlayerVehicles[playerid] = INVALID_VEHICLE_ID;
    ResetPlayerStats(playerid);
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, START_MONEY);
    SetPlayerScore(playerid, 0);
    
    new name[32], msg[128];
    GetName(playerid, name, sizeof(name));
    format(msg, sizeof(msg), "{33FF33}[+] {FFFFFF}%s has joined the server.", name);
    SendClientMessageToAll(COLOR_WHITE, msg);
    
    SendClientMessage(playerid, COLOR_WHITE, "=========================================");
    SendClientMessage(playerid, COLOR_CYAN, "  Welcome to Freeroam Extended (SA-MP 0.3.7)");
    SendClientMessage(playerid, COLOR_WHITE, "=========================================");
    SendClientMessage(playerid, COLOR_GREEN, "Use /help to see available commands.");
    SendClientMessage(playerid, COLOR_GREEN, "Use /cmds for a full command list.");
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    ResetPlayerVehicle(playerid);
    
    // Cancel duel if player was in one
    if (gPlayerData[playerid][pDuelState] != DUEL_STATE_NONE)
    {
        new opponent = gPlayerData[playerid][pDuelOpponent];
        CancelDuel();
        if (IsPlayerConnected(opponent))
        {
            SendClientMessage(opponent, COLOR_RED, "Duel cancelled - your opponent disconnected.");
        }
    }
    
    new name[32], msg[128], reasonText[32];
    GetName(playerid, name, sizeof(name));
    
    switch(reason)
    {
        case 0: reasonText = "Timeout";
        case 1: reasonText = "Quit";
        case 2: reasonText = "Kick/Ban";
        default: reasonText = "Unknown";
    }
    
    format(msg, sizeof(msg), "{FF3333}[-] {FFFFFF}%s has left the server. (%s)", name, reasonText);
    SendClientMessageToAll(COLOR_WHITE, msg);
    
    ResetPlayerStats(playerid);
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    gPlayerData[playerid][pDeaths]++;
    GivePlayerMoney(playerid, -DEATH_PENALTY);
    
    if (killerid != INVALID_PLAYER_ID && IsPlayerConnected(killerid))
    {
        gPlayerData[killerid][pKills]++;
        GivePlayerMoney(killerid, KILL_REWARD);
        SetPlayerScore(killerid, gPlayerData[killerid][pKills]);
        
        new killerName[32], victimName[32], msg[128];
        GetName(killerid, killerName, sizeof(killerName));
        GetName(playerid, victimName, sizeof(victimName));
        
        format(msg, sizeof(msg), "{FF3333}%s {FFFFFF}killed {33FF33}%s", killerName, victimName);
        SendClientMessageToAll(COLOR_WHITE, msg);
        
        // Check if this was a duel kill
        if (gPlayerData[playerid][pDuelState] == DUEL_STATE_ACTIVE && 
            gPlayerData[playerid][pDuelOpponent] == killerid)
        {
            format(msg, sizeof(msg), "{FFFF00}%s {FFFFFF}has won the duel against {FFFF00}%s!", killerName, victimName);
            SendClientMessageToAll(COLOR_WHITE, msg);
            GivePlayerMoney(killerid, 1000); // Duel bonus
            CancelDuel();
        }
    }
    
    SetPlayerScore(playerid, gPlayerData[playerid][pKills]);
    return 1;
}

public OnPlayerText(playerid, const text[])
{
    if (gPlayerData[playerid][pMuted])
    {
        SendClientMessage(playerid, COLOR_RED, "You are muted and cannot chat.");
        return 0;
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
    new spawnIndex = random(sizeof(gSpawnPoints));
    TeleportPlayer(playerid, gSpawnPoints[spawnIndex][SpawnX], gSpawnPoints[spawnIndex][SpawnY], gSpawnPoints[spawnIndex][SpawnZ], gSpawnPoints[spawnIndex][SpawnAngle]);
    SetPlayerHealth(playerid, DEFAULT_HEALTH);
    SetPlayerArmour(playerid, DEFAULT_ARMOUR);

    GiveFreeroamWeapons(playerid);

    GameTextForPlayer(playerid, "~g~Freeroam ~w~Spawn", SPAWN_TEXT_TIME, SPAWN_TEXT_STYLE);
    return 1;
}

public OnPlayerCommandText(playerid, const cmdtext[])
{
    if (!IsPlayerConnected(playerid))
    {
        return 0;
    }
    
    new cmd[32], params[128], idx;
    
    // Parse command
    while (cmdtext[idx] && cmdtext[idx] != ' ' && idx < 31)
    {
        cmd[idx] = cmdtext[idx];
        idx++;
    }
    cmd[idx] = '\0';
    
    // Parse parameters
    while (cmdtext[idx] == ' ') idx++;
    new pi = 0;
    while (cmdtext[idx] && pi < 127)
    {
        params[pi++] = cmdtext[idx++];
    }
    params[pi] = '\0';

    // ============ HELP COMMANDS ============
    if (!strcmp(cmd, "/help", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== FREEROAM EXTENDED HELP ==========");
        SendClientMessage(playerid, COLOR_CYAN, "Basic: /weapons, /heal, /kill, /stats, /cmds");
        SendClientMessage(playerid, COLOR_CYAN, "Teleports: /ls, /sf, /lv, /grove, /airport, /beach, /chiliad");
        SendClientMessage(playerid, COLOR_CYAN, "Vehicles: /v [id], /infer, /nrg, /bullet, /hydra, /rhino");
        SendClientMessage(playerid, COLOR_CYAN, "Social: /pm [id] [msg], /r [msg], /duel [id]");
        SendClientMessage(playerid, COLOR_CYAN, "Fun: /god, /jetpack, /skin [id], /weather [id]");
        return 1;
    }
    
    if (!strcmp(cmd, "/cmds", true))
    {
        SendClientMessage(playerid, COLOR_YELLOW, "========== COMMAND LIST ==========");
        SendClientMessage(playerid, COLOR_WHITE, "General: /help, /cmds, /stats, /kills, /deaths, /money");
        SendClientMessage(playerid, COLOR_WHITE, "Teleports: /ls, /sf, /lv, /grove, /ballas, /airport, /beach, /marina, /chiliad, /tower, /china, /caligulas, /strip");
        SendClientMessage(playerid, COLOR_WHITE, "Vehicles: /v, /infer, /nrg, /sultan, /turismo, /bullet, /hydra, /rhino, /hunter, /clearcar, /fixcar, /flipcar");
        SendClientMessage(playerid, COLOR_WHITE, "Combat: /weapons, /heal, /armour, /kill, /duel, /god");
        SendClientMessage(playerid, COLOR_WHITE, "Social: /pm, /r, /announce");
        SendClientMessage(playerid, COLOR_WHITE, "Misc: /skin, /jetpack, /day, /night, /weather, /vw, /mypos");
        if (IsAdmin(playerid, ADMIN_LEVEL_MOD))
        {
            SendClientMessage(playerid, COLOR_ORANGE, "Admin: /kick, /mute, /unmute, /slap, /goto, /gethere");
        }
        if (IsAdmin(playerid, ADMIN_LEVEL_ADMIN))
        {
            SendClientMessage(playerid, COLOR_RED, "Admin+: /ban, /setadmin, /announce");
        }
        return 1;
    }

    // ============ STATS COMMANDS ============
    if (!strcmp(cmd, "/stats", true))
    {
        new msg[128], name[32];
        GetName(playerid, name, sizeof(name));
        SendClientMessage(playerid, COLOR_YELLOW, "========== YOUR STATS ==========");
        format(msg, sizeof(msg), "Name: %s | Kills: %d | Deaths: %d | Money: $%d", 
            name, gPlayerData[playerid][pKills], gPlayerData[playerid][pDeaths], GetPlayerMoney(playerid));
        SendClientMessage(playerid, COLOR_WHITE, msg);
        
        new Float:kd = 0.0;
        if (gPlayerData[playerid][pDeaths] > 0)
            kd = Float:gPlayerData[playerid][pKills] / Float:gPlayerData[playerid][pDeaths];
        format(msg, sizeof(msg), "K/D Ratio: %.2f | Admin Level: %d", kd, gPlayerData[playerid][pAdminLevel]);
        SendClientMessage(playerid, COLOR_WHITE, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/kills", true))
    {
        new msg[64];
        format(msg, sizeof(msg), "Your kills: %d", gPlayerData[playerid][pKills]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/deaths", true))
    {
        new msg[64];
        format(msg, sizeof(msg), "Your deaths: %d", gPlayerData[playerid][pDeaths]);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/money", true))
    {
        new msg[64];
        format(msg, sizeof(msg), "Your money: $%d", GetPlayerMoney(playerid));
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }

    // ============ COMBAT COMMANDS ============
    if (!strcmp(cmd, "/weapons", true))
    {
        GiveFreeroamWeapons(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Weapon pack granted. Have fun!");
        return 1;
    }
    
    if (!strcmp(cmd, "/heal", true))
    {
        if (gPlayerData[playerid][pDuelState] != DUEL_STATE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "You cannot heal during a duel!");
            return 1;
        }
        SetPlayerHealth(playerid, DEFAULT_HEALTH);
        SetPlayerArmour(playerid, DEFAULT_ARMOUR);
        SendClientMessage(playerid, COLOR_GREEN, "Health and armour restored.");
        return 1;
    }
    
    if (!strcmp(cmd, "/armour", true))
    {
        if (gPlayerData[playerid][pDuelState] != DUEL_STATE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "You cannot get armour during a duel!");
            return 1;
        }
        SetPlayerArmour(playerid, 100.0);
        SendClientMessage(playerid, COLOR_GREEN, "Full armour granted.");
        return 1;
    }
    
    if (!strcmp(cmd, "/kill", true))
    {
        SetPlayerHealth(playerid, 0.0);
        SendClientMessage(playerid, COLOR_RED, "You killed yourself.");
        return 1;
    }
    
    if (!strcmp(cmd, "/god", true))
    {
        gPlayerData[playerid][pGodMode] = !gPlayerData[playerid][pGodMode];
        if (gPlayerData[playerid][pGodMode])
        {
            SetPlayerHealth(playerid, 99999.0);
            SendClientMessage(playerid, COLOR_GREEN, "God mode enabled. You are invincible!");
        }
        else
        {
            SetPlayerHealth(playerid, 100.0);
            SendClientMessage(playerid, COLOR_RED, "God mode disabled.");
        }
        return 1;
    }
    
    if (!strcmp(cmd, "/jetpack", true))
    {
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
        SendClientMessage(playerid, COLOR_GREEN, "Jetpack equipped!");
        return 1;
    }

    // ============ TELEPORT COMMANDS ============
    if (!strcmp(cmd, "/ls", true))
    {
        TeleportPlayer(playerid, gSpawnPoints[SPAWN_LOS_SANTOS][SpawnX], gSpawnPoints[SPAWN_LOS_SANTOS][SpawnY], gSpawnPoints[SPAWN_LOS_SANTOS][SpawnZ], gSpawnPoints[SPAWN_LOS_SANTOS][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: Los Santos");
        return 1;
    }

    if (!strcmp(cmd, "/sf", true))
    {
        TeleportPlayer(playerid, gSpawnPoints[SPAWN_SAN_FIERRO][SpawnX], gSpawnPoints[SPAWN_SAN_FIERRO][SpawnY], gSpawnPoints[SPAWN_SAN_FIERRO][SpawnZ], gSpawnPoints[SPAWN_SAN_FIERRO][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: San Fierro");
        return 1;
    }

    if (!strcmp(cmd, "/lv", true))
    {
        TeleportPlayer(playerid, gSpawnPoints[SPAWN_LAS_VENTURAS][SpawnX], gSpawnPoints[SPAWN_LAS_VENTURAS][SpawnY], gSpawnPoints[SPAWN_LAS_VENTURAS][SpawnZ], gSpawnPoints[SPAWN_LAS_VENTURAS][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: Las Venturas");
        return 1;
    }
    
    if (!strcmp(cmd, "/grove", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[0][SpawnX], gTeleportLocations[0][SpawnY], gTeleportLocations[0][SpawnZ], gTeleportLocations[0][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: Grove Street");
        return 1;
    }
    
    if (!strcmp(cmd, "/ballas", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[1][SpawnX], gTeleportLocations[1][SpawnY], gTeleportLocations[1][SpawnZ], gTeleportLocations[1][SpawnAngle]);
        SendClientMessage(playerid, COLOR_PURPLE, "Teleport: Ballas Territory");
        return 1;
    }
    
    if (!strcmp(cmd, "/airport", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[2][SpawnX], gTeleportLocations[2][SpawnY], gTeleportLocations[2][SpawnZ], gTeleportLocations[2][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: SF Airport");
        return 1;
    }
    
    if (!strcmp(cmd, "/beach", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[3][SpawnX], gTeleportLocations[3][SpawnY], gTeleportLocations[3][SpawnZ], gTeleportLocations[3][SpawnAngle]);
        SendClientMessage(playerid, COLOR_CYAN, "Teleport: Santa Maria Beach");
        return 1;
    }
    
    if (!strcmp(cmd, "/marina", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[4][SpawnX], gTeleportLocations[4][SpawnY], gTeleportLocations[4][SpawnZ], gTeleportLocations[4][SpawnAngle]);
        SendClientMessage(playerid, COLOR_CYAN, "Teleport: Bayside Marina");
        return 1;
    }
    
    if (!strcmp(cmd, "/tower", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[5][SpawnX], gTeleportLocations[5][SpawnY], gTeleportLocations[5][SpawnZ], gTeleportLocations[5][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: LS Tower");
        return 1;
    }
    
    if (!strcmp(cmd, "/china", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[6][SpawnX], gTeleportLocations[6][SpawnY], gTeleportLocations[6][SpawnZ], gTeleportLocations[6][SpawnAngle]);
        SendClientMessage(playerid, COLOR_RED, "Teleport: SF Chinatown");
        return 1;
    }
    
    if (!strcmp(cmd, "/caligulas", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[7][SpawnX], gTeleportLocations[7][SpawnY], gTeleportLocations[7][SpawnZ], gTeleportLocations[7][SpawnAngle]);
        SendClientMessage(playerid, COLOR_YELLOW, "Teleport: Caligula's Casino");
        return 1;
    }
    
    if (!strcmp(cmd, "/strip", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[8][SpawnX], gTeleportLocations[8][SpawnY], gTeleportLocations[8][SpawnZ], gTeleportLocations[8][SpawnAngle]);
        SendClientMessage(playerid, COLOR_YELLOW, "Teleport: LV Strip");
        return 1;
    }
    
    if (!strcmp(cmd, "/chiliad", true))
    {
        TeleportPlayer(playerid, gTeleportLocations[9][SpawnX], gTeleportLocations[9][SpawnY], gTeleportLocations[9][SpawnZ], gTeleportLocations[9][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: Mount Chiliad");
        return 1;
    }

    // ============ WEATHER/TIME COMMANDS ============
    if (!strcmp(cmd, "/day", true))
    {
        SetWorldTime(DEFAULT_WORLD_TIME);
        SendClientMessage(playerid, COLOR_GREEN, "World time set to day.");
        return 1;
    }

    if (!strcmp(cmd, "/night", true))
    {
        SetWorldTime(NIGHT_WORLD_TIME);
        SendClientMessage(playerid, COLOR_GREEN, "World time set to night.");
        return 1;
    }

    if (!strcmp(cmd, "/sunny", true))
    {
        SetWeather(DEFAULT_WEATHER);
        SendClientMessage(playerid, COLOR_GREEN, "Weather set to sunny.");
        return 1;
    }

    if (!strcmp(cmd, "/rain", true))
    {
        SetWeather(RAIN_WEATHER);
        SendClientMessage(playerid, COLOR_GREEN, "Weather set to rain.");
        return 1;
    }
    
    if (!strcmp(cmd, "/storm", true))
    {
        SetWeather(STORM_WEATHER);
        SendClientMessage(playerid, COLOR_GREEN, "Weather set to storm.");
        return 1;
    }
    
    if (!strcmp(cmd, "/foggy", true))
    {
        SetWeather(FOGGY_WEATHER);
        SendClientMessage(playerid, COLOR_GREEN, "Weather set to foggy.");
        return 1;
    }
    
    if (!strcmp(cmd, "/weather", true))
    {
        new weatherid = strval(params);
        if (strlen(params) == 0 || weatherid < 0 || weatherid > 45)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /weather [0-45]");
            return 1;
        }
        SetWeather(weatherid);
        new msg[64];
        format(msg, sizeof(msg), "Weather set to ID: %d", weatherid);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/time", true))
    {
        new hour = strval(params);
        if (strlen(params) == 0 || hour < 0 || hour > 23)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /time [0-23]");
            return 1;
        }
        SetWorldTime(hour);
        new msg[64];
        format(msg, sizeof(msg), "Time set to %d:00", hour);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }

    // ============ VEHICLE COMMANDS ============
    if (!strcmp(cmd, "/v", true))
    {
        new modelid = strval(params);
        if (strlen(params) == 0 || modelid < 400 || modelid > 611)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /v [400-611] - Spawn a vehicle by model ID");
            return 1;
        }
        CreateAndWarpVehicle(playerid, modelid, random(128), random(128));
        new msg[64];
        format(msg, sizeof(msg), "Spawned vehicle ID: %d", modelid);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/infer", true))
    {
        CreateAndWarpVehicle(playerid, 411, 0, 1);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Infernus.");
        return 1;
    }

    if (!strcmp(cmd, "/nrg", true))
    {
        CreateAndWarpVehicle(playerid, 522, 6, 6);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned NRG-500.");
        return 1;
    }

    if (!strcmp(cmd, "/sultan", true))
    {
        CreateAndWarpVehicle(playerid, 560, 1, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Sultan.");
        return 1;
    }

    if (!strcmp(cmd, "/turismo", true))
    {
        CreateAndWarpVehicle(playerid, 451, 2, 2);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Turismo.");
        return 1;
    }
    
    if (!strcmp(cmd, "/bullet", true))
    {
        CreateAndWarpVehicle(playerid, 541, 3, 3);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Bullet.");
        return 1;
    }
    
    if (!strcmp(cmd, "/hydra", true))
    {
        CreateAndWarpVehicle(playerid, 520, 0, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Hydra jet.");
        return 1;
    }
    
    if (!strcmp(cmd, "/rhino", true))
    {
        CreateAndWarpVehicle(playerid, 432, 0, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Rhino tank.");
        return 1;
    }
    
    if (!strcmp(cmd, "/hunter", true))
    {
        CreateAndWarpVehicle(playerid, 425, 0, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Hunter helicopter.");
        return 1;
    }
    
    if (!strcmp(cmd, "/pcj", true))
    {
        CreateAndWarpVehicle(playerid, 461, 0, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned PCJ-600.");
        return 1;
    }
    
    if (!strcmp(cmd, "/sanchez", true))
    {
        CreateAndWarpVehicle(playerid, 468, 0, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Sanchez.");
        return 1;
    }
    
    if (!strcmp(cmd, "/cheetah", true))
    {
        CreateAndWarpVehicle(playerid, 415, 0, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Cheetah.");
        return 1;
    }
    
    if (!strcmp(cmd, "/banshee", true))
    {
        CreateAndWarpVehicle(playerid, 429, 0, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Banshee.");
        return 1;
    }

    if (!strcmp(cmd, "/clearcar", true))
    {
        ResetPlayerVehicle(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Your personal vehicle was removed.");
        return 1;
    }

    if (!strcmp(cmd, "/fixcar", true))
    {
        if (FixPlayerVehicle(playerid))
        {
            SendClientMessage(playerid, COLOR_GREEN, "Vehicle repaired.");
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "You must be driving a vehicle to repair it.");
        }
        return 1;
    }

    if (!strcmp(cmd, "/flipcar", true))
    {
        if (FlipPlayerVehicle(playerid))
        {
            SendClientMessage(playerid, COLOR_GREEN, "Vehicle flipped.");
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "You must be driving a vehicle to flip it.");
        }
        return 1;
    }

    // ============ UTILITY COMMANDS ============
    if (!strcmp(cmd, "/mypos", true))
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        new msg[96];
        format(msg, sizeof(msg), "Your position: %.2f, %.2f, %.2f", x, y, z);
        SendClientMessage(playerid, COLOR_CYAN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/skin", true))
    {
        new skinid = strval(params);
        if (strlen(params) == 0 || skinid < 0 || skinid > MAX_SKIN_ID)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /skin [0-299]");
            return 1;
        }
        SetPlayerSkin(playerid, skinid);
        new msg[64];
        format(msg, sizeof(msg), "Skin changed to: %d", skinid);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/vw", true))
    {
        new vw = strval(params);
        if (strlen(params) == 0 || vw < 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /vw [0+]");
            return 1;
        }
        SetPlayerVirtualWorld(playerid, vw);
        new msg[64];
        format(msg, sizeof(msg), "Virtual world set to: %d", vw);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }

    // ============ SOCIAL COMMANDS ============
    if (!strcmp(cmd, "/pm", true))
    {
        new targetid, space = -1;
        for (new i = 0; params[i]; i++)
        {
            if (params[i] == ' ')
            {
                space = i;
                break;
            }
        }
        
        if (space == -1)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /pm [playerid] [message]");
            return 1;
        }
        
        new idstr[8], message[100];
        for (new i = 0; i < space && i < 7; i++)
            idstr[i] = params[i];
        idstr[space] = '\0';
        
        targetid = strval(idstr);
        
        new mi = 0;
        for (new i = space + 1; params[i] && mi < 99; i++)
            message[mi++] = params[i];
        message[mi] = '\0';
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        if (targetid == playerid)
        {
            SendClientMessage(playerid, COLOR_RED, "You cannot PM yourself.");
            return 1;
        }
        
        new senderName[32], targetName[32], msg[144];
        GetName(playerid, senderName, sizeof(senderName));
        GetName(targetid, targetName, sizeof(targetName));
        
        format(msg, sizeof(msg), "[PM to %s]: %s", targetName, message);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
        
        format(msg, sizeof(msg), "[PM from %s]: %s", senderName, message);
        SendClientMessage(targetid, COLOR_YELLOW, msg);
        
        gPlayerData[targetid][pLastPM] = playerid;
        return 1;
    }
    
    if (!strcmp(cmd, "/r", true))
    {
        if (gPlayerData[playerid][pLastPM] == INVALID_PLAYER_ID)
        {
            SendClientMessage(playerid, COLOR_RED, "No one to reply to.");
            return 1;
        }
        
        new targetid = gPlayerData[playerid][pLastPM];
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player no longer connected.");
            gPlayerData[playerid][pLastPM] = INVALID_PLAYER_ID;
            return 1;
        }
        
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /r [message]");
            return 1;
        }
        
        new senderName[32], targetName[32], msg[144];
        GetName(playerid, senderName, sizeof(senderName));
        GetName(targetid, targetName, sizeof(targetName));
        
        format(msg, sizeof(msg), "[PM to %s]: %s", targetName, params);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
        
        format(msg, sizeof(msg), "[PM from %s]: %s", senderName, params);
        SendClientMessage(targetid, COLOR_YELLOW, msg);
        
        gPlayerData[targetid][pLastPM] = playerid;
        return 1;
    }
    
    if (!strcmp(cmd, "/announce", true))
    {
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /announce [message]");
            return 1;
        }
        
        new name[32], msg[160];
        GetName(playerid, name, sizeof(name));
        format(msg, sizeof(msg), "[Announcement by %s]: %s", name, params);
        SendClientMessageToAll(COLOR_ORANGE, msg);
        return 1;
    }
    
    // ============ DUEL COMMANDS ============
    if (!strcmp(cmd, "/duel", true))
    {
        if (gPlayerData[playerid][pDuelState] != DUEL_STATE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "You are already in a duel!");
            return 1;
        }
        
        new targetid = strval(params);
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /duel [playerid]");
            return 1;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        if (targetid == playerid)
        {
            SendClientMessage(playerid, COLOR_RED, "You cannot duel yourself.");
            return 1;
        }
        
        if (gPlayerData[targetid][pDuelState] != DUEL_STATE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "That player is already in a duel.");
            return 1;
        }
        
        // Check if target has a pending request from this player
        if (gPlayerData[targetid][pDuelOpponent] == playerid && gPlayerData[targetid][pDuelState] == DUEL_STATE_PENDING)
        {
            // Accept the duel
            StartDuel(targetid, playerid);
            return 1;
        }
        
        // Send duel request
        gPlayerData[playerid][pDuelState] = DUEL_STATE_PENDING;
        gPlayerData[playerid][pDuelOpponent] = targetid;
        
        new senderName[32], targetName[32], msg[128];
        GetName(playerid, senderName, sizeof(senderName));
        GetName(targetid, targetName, sizeof(targetName));
        
        format(msg, sizeof(msg), "You sent a duel request to %s. Waiting for response...", targetName);
        SendClientMessage(playerid, COLOR_YELLOW, msg);
        
        format(msg, sizeof(msg), "%s wants to duel you! Type /duel %d to accept.", senderName, playerid);
        SendClientMessage(targetid, COLOR_YELLOW, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/cancelduel", true))
    {
        if (gPlayerData[playerid][pDuelState] == DUEL_STATE_NONE)
        {
            SendClientMessage(playerid, COLOR_RED, "You are not in a duel.");
            return 1;
        }
        
        new opponent = gPlayerData[playerid][pDuelOpponent];
        CancelDuel();
        
        SendClientMessage(playerid, COLOR_RED, "Duel cancelled.");
        if (IsPlayerConnected(opponent))
        {
            SendClientMessage(opponent, COLOR_RED, "Duel cancelled by opponent.");
        }
        return 1;
    }

    // ============ ADMIN COMMANDS ============
    if (!strcmp(cmd, "/setadmin", true))
    {
        if (!IsAdmin(playerid, ADMIN_LEVEL_OWNER))
        {
            // First player to use this becomes owner (for setup)
            new count = 0;
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (IsPlayerConnected(i) && gPlayerData[i][pAdminLevel] >= ADMIN_LEVEL_OWNER)
                    count++;
            }
            
            if (count == 0)
            {
                gPlayerData[playerid][pAdminLevel] = ADMIN_LEVEL_OWNER;
                SendClientMessage(playerid, COLOR_GREEN, "You are now the server owner (admin level 3).");
                return 1;
            }
            
            SendClientMessage(playerid, COLOR_RED, "You don't have permission to use this command.");
            return 1;
        }
        
        new targetid, level, space = -1;
        for (new i = 0; params[i]; i++)
        {
            if (params[i] == ' ')
            {
                space = i;
                break;
            }
        }
        
        if (space == -1)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /setadmin [playerid] [level 0-3]");
            return 1;
        }
        
        new idstr[8], lvlstr[8];
        for (new i = 0; i < space && i < 7; i++)
            idstr[i] = params[i];
        idstr[space] = '\0';
        
        new li = 0;
        for (new i = space + 1; params[i] && li < 7; i++)
            lvlstr[li++] = params[i];
        lvlstr[li] = '\0';
        
        targetid = strval(idstr);
        level = strval(lvlstr);
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        if (level < 0 || level > 3)
        {
            SendClientMessage(playerid, COLOR_RED, "Invalid level. Use 0-3.");
            return 1;
        }
        
        gPlayerData[targetid][pAdminLevel] = level;
        
        new targetName[32], msg[128];
        GetName(targetid, targetName, sizeof(targetName));
        format(msg, sizeof(msg), "Set %s's admin level to %d.", targetName, level);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        
        format(msg, sizeof(msg), "Your admin level has been set to %d.", level);
        SendClientMessage(targetid, COLOR_GREEN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/kick", true))
    {
        if (!IsAdmin(playerid, ADMIN_LEVEL_MOD))
        {
            SendClientMessage(playerid, COLOR_RED, "You don't have permission to use this command.");
            return 1;
        }
        
        new targetid = strval(params);
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /kick [playerid]");
            return 1;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        if (gPlayerData[targetid][pAdminLevel] >= gPlayerData[playerid][pAdminLevel])
        {
            SendClientMessage(playerid, COLOR_RED, "You cannot kick an admin of equal or higher level.");
            return 1;
        }
        
        new targetName[32], adminName[32], msg[128];
        GetName(targetid, targetName, sizeof(targetName));
        GetName(playerid, adminName, sizeof(adminName));
        
        format(msg, sizeof(msg), "%s has been kicked by admin %s.", targetName, adminName);
        SendClientMessageToAll(COLOR_RED, msg);
        
        Kick(targetid);
        return 1;
    }
    
    if (!strcmp(cmd, "/ban", true))
    {
        if (!IsAdmin(playerid, ADMIN_LEVEL_ADMIN))
        {
            SendClientMessage(playerid, COLOR_RED, "You don't have permission to use this command.");
            return 1;
        }
        
        new targetid = strval(params);
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /ban [playerid]");
            return 1;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        if (gPlayerData[targetid][pAdminLevel] >= gPlayerData[playerid][pAdminLevel])
        {
            SendClientMessage(playerid, COLOR_RED, "You cannot ban an admin of equal or higher level.");
            return 1;
        }
        
        new targetName[32], adminName[32], msg[128];
        GetName(targetid, targetName, sizeof(targetName));
        GetName(playerid, adminName, sizeof(adminName));
        
        format(msg, sizeof(msg), "%s has been banned by admin %s.", targetName, adminName);
        SendClientMessageToAll(COLOR_RED, msg);
        
        Ban(targetid);
        return 1;
    }
    
    if (!strcmp(cmd, "/mute", true))
    {
        if (!IsAdmin(playerid, ADMIN_LEVEL_MOD))
        {
            SendClientMessage(playerid, COLOR_RED, "You don't have permission to use this command.");
            return 1;
        }
        
        new targetid = strval(params);
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /mute [playerid]");
            return 1;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        gPlayerData[targetid][pMuted] = true;
        
        new targetName[32], msg[128];
        GetName(targetid, targetName, sizeof(targetName));
        format(msg, sizeof(msg), "%s has been muted.", targetName);
        SendClientMessageToAll(COLOR_ORANGE, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/unmute", true))
    {
        if (!IsAdmin(playerid, ADMIN_LEVEL_MOD))
        {
            SendClientMessage(playerid, COLOR_RED, "You don't have permission to use this command.");
            return 1;
        }
        
        new targetid = strval(params);
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /unmute [playerid]");
            return 1;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        gPlayerData[targetid][pMuted] = false;
        
        new targetName[32], msg[128];
        GetName(targetid, targetName, sizeof(targetName));
        format(msg, sizeof(msg), "%s has been unmuted.", targetName);
        SendClientMessageToAll(COLOR_GREEN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/slap", true))
    {
        if (!IsAdmin(playerid, ADMIN_LEVEL_MOD))
        {
            SendClientMessage(playerid, COLOR_RED, "You don't have permission to use this command.");
            return 1;
        }
        
        new targetid = strval(params);
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /slap [playerid]");
            return 1;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        new Float:x, Float:y, Float:z;
        GetPlayerPos(targetid, x, y, z);
        SetPlayerPos(targetid, x, y, z + 10.0);
        
        new targetName[32], adminName[32], msg[128];
        GetName(targetid, targetName, sizeof(targetName));
        GetName(playerid, adminName, sizeof(adminName));
        format(msg, sizeof(msg), "%s was slapped by admin %s.", targetName, adminName);
        SendClientMessageToAll(COLOR_ORANGE, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/goto", true))
    {
        if (!IsAdmin(playerid, ADMIN_LEVEL_MOD))
        {
            SendClientMessage(playerid, COLOR_RED, "You don't have permission to use this command.");
            return 1;
        }
        
        new targetid = strval(params);
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /goto [playerid]");
            return 1;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        new Float:x, Float:y, Float:z;
        GetPlayerPos(targetid, x, y, z);
        SetPlayerPos(playerid, x + 1.0, y, z);
        
        new targetName[32], msg[64];
        GetName(targetid, targetName, sizeof(targetName));
        format(msg, sizeof(msg), "Teleported to %s.", targetName);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        return 1;
    }
    
    if (!strcmp(cmd, "/gethere", true))
    {
        if (!IsAdmin(playerid, ADMIN_LEVEL_MOD))
        {
            SendClientMessage(playerid, COLOR_RED, "You don't have permission to use this command.");
            return 1;
        }
        
        new targetid = strval(params);
        if (strlen(params) == 0)
        {
            SendClientMessage(playerid, COLOR_WHITE, "Usage: /gethere [playerid]");
            return 1;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_RED, "Player not connected.");
            return 1;
        }
        
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(targetid, x + 1.0, y, z);
        
        new targetName[32], msg[64];
        GetName(targetid, targetName, sizeof(targetName));
        format(msg, sizeof(msg), "Teleported %s to your location.", targetName);
        SendClientMessage(playerid, COLOR_GREEN, msg);
        
        SendClientMessage(targetid, COLOR_ORANGE, "You have been teleported by an admin.");
        return 1;
    }

    return 0;
}
