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
native SetPlayerInterior(playerid, interiorid);
native SetPlayerVirtualWorld(playerid, worldid);
native SetPlayerPos(playerid, Float:x, Float:y, Float:z);
native SetPlayerFacingAngle(playerid, Float:a);
native GivePlayerWeapon(playerid, weaponid, ammo);
native SetPlayerHealth(playerid, Float:health);
native SetPlayerArmour(playerid, Float:armour);
native IsPlayerConnected(playerid);
native GetPlayerPos(playerid, &Float:x, &Float:y, &Float:z);
native strcmp(const string1[], const string2[], bool:ignorecase=false, pos=0, length=-1);
native random(max);

forward OnGameModeInit();
forward OnGameModeExit();
forward OnPlayerConnect(playerid);
forward OnPlayerSpawn(playerid);
forward OnPlayerCommandText(playerid, const cmdtext[]);

#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_GREEN 0x33FF33FF
#define COLOR_CYAN  0x33CCFFFF

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
    {1480.5654, -1738.5825, 13.3828, 272.4587},
    {-2026.9636, 137.9882, 28.8359, 359.6148},
    {-1429.8967, 2597.4829, 55.8359, 315.8423},
    {1154.5635, 2073.9988, 11.0625, 88.5000}
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

stock TeleportPlayer(playerid, Float:x, Float:y, Float:z, Float:a)
{
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid, x, y, z);
    SetPlayerFacingAngle(playerid, a);
    return 1;
}

stock GiveFreeroamWeapons(playerid)
{
    GivePlayerWeapon(playerid, 24, 300);   // Deagle
    GivePlayerWeapon(playerid, 31, 500);   // M4
    GivePlayerWeapon(playerid, 34, 50);    // Sniper
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
    EnableStuntBonusForAll(0);
    SetWorldTime(12);
    SetWeather(1);

    // Basic classes (CJ skin)
    AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 270.1425, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(0, 1480.5654, -1738.5825, 13.3828, 272.4587, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(0, -2026.9636, 137.9882, 28.8359, 359.6148, 0, 0, 0, 0, 0, 0);

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
    SendClientMessage(playerid, COLOR_WHITE, "Welcome to the simple freeroam (SA-MP 0.3.7). Use /help to see commands.");
    return 1;
}

public OnPlayerSpawn(playerid)
{
    new spawnIndex = random(sizeof(gSpawnPoints));
    TeleportPlayer(playerid, gSpawnPoints[spawnIndex][SpawnX], gSpawnPoints[spawnIndex][SpawnY], gSpawnPoints[spawnIndex][SpawnZ], gSpawnPoints[spawnIndex][SpawnAngle]);
    SetPlayerHealth(playerid, 100.0);
    SetPlayerArmour(playerid, 50.0);

    GiveFreeroamWeapons(playerid);

    GameTextForPlayer(playerid, "~g~Freeroam ~w~Spawn", 3000, 3);
    return 1;
}

public OnPlayerCommandText(playerid, const cmdtext[])
{
    if (!strcmp(cmdtext, "/help", true))
    {
        SendClientMessage(playerid, COLOR_CYAN, "Commands: /help, /weapons, /ls, /sf, /lv");
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
        TeleportPlayer(playerid, gSpawnPoints[1][SpawnX], gSpawnPoints[1][SpawnY], gSpawnPoints[1][SpawnZ], gSpawnPoints[1][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: Los Santos");
        return 1;
    }

    if (!strcmp(cmdtext, "/sf", true))
    {
        TeleportPlayer(playerid, gSpawnPoints[2][SpawnX], gSpawnPoints[2][SpawnY], gSpawnPoints[2][SpawnZ], gSpawnPoints[2][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: San Fierro");
        return 1;
    }

    if (!strcmp(cmdtext, "/lv", true))
    {
        TeleportPlayer(playerid, gSpawnPoints[4][SpawnX], gSpawnPoints[4][SpawnY], gSpawnPoints[4][SpawnZ], gSpawnPoints[4][SpawnAngle]);
        SendClientMessage(playerid, COLOR_GREEN, "Teleport: Las Venturas");
        return 1;
    }

    return 0;
}
