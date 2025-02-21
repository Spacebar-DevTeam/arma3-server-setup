/*
 * ExileServer_BigfootsHeliCrash_spawnSupportAssets.sqf
 * 
 * Spawns support assets (Zodiacs & shore loot) for underwater heli crash missions.
 *
 * Features:
 * - Spawns Zodiacs (2-3 boats) at the closest shore position to the crash site.
 * - Adds a loot crate with diving gear near the shore.
 * - Spawns AI defenders to protect the shore loot box.
 * - Cleans up Zodiacs if no one enters the driver seat within `BH_vehicle_cleanupTimer`.
 * - Deletes shore loot box after `BH_lootbox_cleanupTimer` expires.
 *
 * Updated by: sko & Ghost PGM DEV TEAM
 */

if (!isServer) exitWith {};

// Define variables
private ["_wreckPosition", "_shorePosition", "_zodiacs", "_lootBox", "_lootBoxType", "_vehicleType", "_vehicle", "_zodiacPositions", "_vehicleCleanup", "_aiGroup"];

// Get wreck position from function call
_wreckPosition = _this select 0;

// Find nearest shore position
_shorePosition = [_wreckPosition, 100, 1000, 0, 0, 0, 0, [], [_wreckPosition]] call BIS_fnc_findSafePos;

// Ensure valid shore position
if (count _shorePosition == 0) exitWith
{
    ["WARNING: Could not find a safe shore position for support assets!"] call ExileServer_BigfootsHeliCrash_util_logCommand;
};

// **Spawn Zodiacs**  
_vehicleType = "B_Boat_Transport_01_F"; // NATO Zodiac  
_zodiacs = [];

for "_i" from 1 to (ceil(random 2) + 1) do // Spawns 2-3 zodiacs randomly  
{
    private _zodiacPosition = _shorePosition getPos [(random 15) + 5, random 360];
    _vehicle = createVehicle [_vehicleType, _zodiacPosition, [], 0, "CAN_COLLIDE"];
    _vehicle setDir (random 360);
    _vehicle setFuel 0.5; // Set fuel to half  
    _zodiacs pushBack _vehicle;
    
    format["Spawned Zodiac at [%1].", _zodiacPosition] call ExileServer_BigfootsHeliCrash_util_logCommand;
};

// **Spawn Shore Loot Box**  
_lootBoxType = "Box_NATO_Wps_F"; // Weapon crate with diving gear  
_lootBox = createVehicle [_lootBoxType, _shorePosition, [], 0, "CAN_COLLIDE"];
_lootBox setDir (random 360);
_lootBox setVariable ["ExileMoney", ceil(random 5000), true]; // Add random poptabs  

// **Fill Shore Loot Box with Diving Gear**
_lootBoxItems = [
    ["V_RebreatherB", "V_RebreatherIA", "V_RebreatherIR"],  // Rebreathers
    ["G_Diving", "G_B_Diving", "G_O_Diving", "G_I_Diving"],  // Diving Goggles
    ["U_B_Wetsuit", "U_O_Wetsuit", "U_I_Wetsuit"],  // Wetsuits
    ["ItemGPS", "Binocular", "NVGoggles"],  // Navigation gear
    ["Exile_Item_PlasticBottleFreshWater", "Exile_Item_EMRE"] // Food & water
];

// Add items to loot box
{
    _item = selectRandom _x;
    _lootBox addItemCargoGlobal [_item, ceil(random 2)];
} forEach _lootBoxItems;

format["Spawned Shore Loot Box at [%1].", _shorePosition] call ExileServer_BigfootsHeliCrash_util_logCommand;

// **Spawn AI Defenders**
_aiGroup = [_shorePosition, BH_AI_shore_guard_count, "LAND"] call ExileServer_BigfootsHeliCrash_spawnAICommand;

if (!isNull _aiGroup) then 
{
    format["Spawned AI shore guards at [%1].", _shorePosition] call ExileServer_BigfootsHeliCrash_util_logCommand;
};

// **Cleanup Logic**  
_vehicleCleanup =
{
    private ["_vehicleList"];
    _vehicleList = _this;

    sleep BH_vehicle_cleanupTimer; // Configurable cleanup timer (default: 20 minutes)

    {
        if (!isNull _x && {driver _x isEqualTo objNull}) then
        {
            deleteVehicle _x;
            format["Deleted unused Zodiac at [%1].", getPos _x] call ExileServer_BigfootsHeliCrash_util_logCommand;
        };
    } forEach _vehicleList;
};

// Cleanup zodiacs if no one uses them
[_zodiacs] spawn _vehicleCleanup;

// Cleanup shore loot box after mission is over
[_lootBox] spawn 
{
    sleep BH_lootbox_cleanupTimer; // Default: 20 minutes
    deleteVehicle _this select 0;
    ["Deleted shore loot box."] call ExileServer_BigfootsHeliCrash_util_logCommand;
};
