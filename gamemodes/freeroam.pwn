#pragma tabsize 4
#pragma compat 1
#pragma rational Float

// Minimal SA-MP 0.3.7 freeroam-style gamemode

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
native SetPlayerInterior(playerid, interiorid);
native SetPlayerVirtualWorld(playerid, worldid);
native SetPlayerPos(playerid, Float:x, Float:y, Float:z);
native SetPlayerFacingAngle(playerid, Float:a);
native GetPlayerFacingAngle(playerid, &Float:a);
native GivePlayerWeapon(playerid, weaponid, ammo);
native SetPlayerHealth(playerid, Float:health);
native SetPlayerArmour(playerid, Float:armour);
native IsPlayerConnected(playerid);
native GetPlayerPos(playerid, &Float:x, &Float:y, &Float:z);
native PutPlayerInVehicle(playerid, vehicleid, seatid);
native GetPlayerState(playerid);
native DestroyVehicle(vehicleid);
native strcmp(const string1[], const string2[], bool:ignorecase=false, pos=0, length=-1);
native random(max);

forward OnGameModeInit();
forward OnGameModeExit();
forward OnPlayerConnect(playerid);
forward OnPlayerDisconnect(playerid, reason);
forward OnPlayerSpawn(playerid);
forward OnPlayerCommandText(playerid, const cmdtext[]);

#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_GREEN 0x33FF33FF
#define COLOR_CYAN  0x33CCFFFF
#define MAX_PLAYERS 500
#define INVALID_VEHICLE_ID (-1)
#define DEFAULT_SKIN 0
#define WEAPON_DEAGLE 24
#define WEAPON_M4     31
#define WEAPON_SNIPER 34
#define STUNT_BONUS_DISABLED 0
#define DEFAULT_WORLD_TIME 12
#define NIGHT_WORLD_TIME 0
#define DEFAULT_WEATHER 1
#define RAIN_WEATHER 16
#define DEFAULT_HEALTH (100.0)
#define DEFAULT_ARMOUR (50.0)
#define SPAWN_TEXT_TIME 3000
#define SPAWN_TEXT_STYLE 3

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

main()
{
    return 1;
}

public OnGameModeInit()
{
    SetGameModeText("Freeroam 0.3.7");
    ShowPlayerMarkers(1);
    ShowNameTags(1);
    UsePlayerPedAnims();
    EnableStuntBonusForAll(STUNT_BONUS_DISABLED);
    SetWorldTime(DEFAULT_WORLD_TIME);
    SetWeather(DEFAULT_WEATHER);

    for (new p = 0; p < MAX_PLAYERS; p++)
    {
        gPlayerVehicles[p] = INVALID_VEHICLE_ID;
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

    return 1;
}

public OnGameModeExit()
{
    return 1;
}

public OnPlayerConnect(playerid)
{
    gPlayerVehicles[playerid] = INVALID_VEHICLE_ID;
    SendClientMessage(playerid, COLOR_WHITE, "Welcome to the simple freeroam (SA-MP 0.3.7). Use /help to see commands.");
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    ResetPlayerVehicle(playerid);
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

    if (!strcmp(cmdtext, "/help", true))
    {
        SendClientMessage(playerid, COLOR_CYAN, "Commands: /help, /weapons, /ls, /sf, /lv, /heal, /day, /night, /sunny, /rain, /infer, /nrg, /sultan, /turismo, /clearcar");
        return 1;
    }

    if (!strcmp(cmdtext, "/weapons", true))
    {
        GiveFreeroamWeapons(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Weapon pack granted. Have fun!");
        return 1;
    }

    if (!strcmp(cmdtext, "/ls", true))
    {
        TeleportPlayer(playerid, gSpawnPoints[SPAWN_LOS_SANTOS][SpawnX], gSpawnPoints[SPAWN_LOS_SANTOS][SpawnY], gSpawnPoints[SPAWN_LOS_SANTOS][SpawnZ], gSpawnPoints[SPAWN_LOS_SANTOS][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: Los Santos");
        return 1;
    }

    if (!strcmp(cmdtext, "/sf", true))
    {
        TeleportPlayer(playerid, gSpawnPoints[SPAWN_SAN_FIERRO][SpawnX], gSpawnPoints[SPAWN_SAN_FIERRO][SpawnY], gSpawnPoints[SPAWN_SAN_FIERRO][SpawnZ], gSpawnPoints[SPAWN_SAN_FIERRO][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: San Fierro");
        return 1;
    }

    if (!strcmp(cmdtext, "/lv", true))
    {
        TeleportPlayer(playerid, gSpawnPoints[SPAWN_LAS_VENTURAS][SpawnX], gSpawnPoints[SPAWN_LAS_VENTURAS][SpawnY], gSpawnPoints[SPAWN_LAS_VENTURAS][SpawnZ], gSpawnPoints[SPAWN_LAS_VENTURAS][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: Las Venturas");
        return 1;
    }

    if (!strcmp(cmdtext, "/heal", true))
    {
        SetPlayerHealth(playerid, DEFAULT_HEALTH);
        SetPlayerArmour(playerid, DEFAULT_ARMOUR);
        SendClientMessage(playerid, COLOR_GREEN, "Health and armour restored.");
        return 1;
    }

    if (!strcmp(cmdtext, "/day", true))
    {
        SetWorldTime(DEFAULT_WORLD_TIME);
        SendClientMessage(playerid, COLOR_GREEN, "World time set to day.");
        return 1;
    }

    if (!strcmp(cmdtext, "/night", true))
    {
        SetWorldTime(NIGHT_WORLD_TIME);
        SendClientMessage(playerid, COLOR_GREEN, "World time set to night.");
        return 1;
    }

    if (!strcmp(cmdtext, "/sunny", true))
    {
        SetWeather(DEFAULT_WEATHER);
        SendClientMessage(playerid, COLOR_GREEN, "Weather set to sunny.");
        return 1;
    }

    if (!strcmp(cmdtext, "/rain", true))
    {
        SetWeather(RAIN_WEATHER);
        SendClientMessage(playerid, COLOR_GREEN, "Weather set to rain.");
        return 1;
    }

    if (!strcmp(cmdtext, "/infer", true))
    {
        CreateAndWarpVehicle(playerid, 411, 0, 1);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Infernus.");
        return 1;
    }

    if (!strcmp(cmdtext, "/nrg", true))
    {
        CreateAndWarpVehicle(playerid, 522, 6, 6);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned NRG-500.");
        return 1;
    }

    if (!strcmp(cmdtext, "/sultan", true))
    {
        CreateAndWarpVehicle(playerid, 560, 1, 0);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Sultan.");
        return 1;
    }

    if (!strcmp(cmdtext, "/turismo", true))
    {
        CreateAndWarpVehicle(playerid, 451, 2, 2);
        SendClientMessage(playerid, COLOR_GREEN, "Spawned Turismo.");
        return 1;
    }

    if (!strcmp(cmdtext, "/clearcar", true))
    {
        ResetPlayerVehicle(playerid);
        SendClientMessage(playerid, COLOR_GREEN, "Your personal vehicle was removed.");
        return 1;
    }

    return 0;
}
