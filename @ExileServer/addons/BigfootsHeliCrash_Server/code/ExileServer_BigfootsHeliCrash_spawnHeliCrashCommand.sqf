/*
 * ExileServer_BigfootsHeliCrash_spawnHeliCrashCommand.sqf
 * 
 * Spawns helicopter crash sites in **land and water** locations.
 *
 * Features:
 * - Supports **land and water** crash sites based on config values.
 * - AI spawns at each site with **land or underwater** behaviors.
 * - Differentiated **map markers** for land vs. water crashes.
 * - Ensures loot crates spawn **near the wreck**.
 * - Improved error handling and logging.
 * 
 * Updated by: sko & Ghost PGM DEV TEAM
 */

if (!isServer) exitWith {};

// Define variables
private ["_wreckPosition", "_wreckType", "_crate", "_crateType", "_marker", "_isWaterCrash", "_aiParams"];

// Log function start
["Starting Heli Crash Spawn Process..."] call ExileServer_BigfootsHeliCrash_util_logCommand;

// Validate wreck count before proceeding
private _wreckCount = BH_count_HeliCrash;
private _waterWreckCount = BH_count_HeliCrashWater;

if (_wreckCount + _waterWreckCount <= 0) exitWith 
{
    ["ERROR: No wrecks configured to spawn. Check `config.sqf`."] call ExileServer_BigfootsHeliCrash_util_logCommand;
};

// Function to find a valid spawn position
private _findSpawnPosition = {
    params ["_isWater"];
    if (_isWater) then {
        [_wreckPosition, BH_locations_distance_min, BH_locations_distance_max, 0, 0, 10, 0, [], [_wreckPosition]] call BIS_fnc_findSafePos
    } else {
        [_wreckPosition, BH_locations_distance_min, BH_locations_distance_max, 1, 0, 800, 0, [], [_wreckPosition]] call BIS_fnc_findSafePos
    };
};

// Loop to spawn **land heli crashes**
for "_i" from 1 to _wreckCount do {
    _wreckPosition = call _findSpawnPosition(false); // Land crash

    // Validate position
    if (count _wreckPosition == 0) then {
        ["WARNING: Could not find a valid land crash site. Skipping..."] call ExileServer_BigfootsHeliCrash_util_logCommand;
        continue;
    };

    _wreckType = selectRandom BH_class_wreckage;
    _crateType = selectRandom BH_class_crate;
    _isWaterCrash = false;

    // Spawn wreck
    private _wreck = createVehicle [_wreckType, _wreckPosition, [], 0, "NONE"];
    _wreck setVectorUp surfaceNormal _wreckPosition;
    
    // Spawn loot crate
    private _cratePosition = _wreckPosition getPos [BH_locations_crateWreckOffset, random 360];
    _crate = createVehicle [_crateType, _cratePosition, [], 0, "CAN_COLLIDE"];

    // Create map marker
    _marker = createMarker [format ["HeliCrash_%1", _i], _wreckPosition];
    _marker setMarkerType "mil_destroy";
    _marker setMarkerColor BH_marker_colorLand;

    // Spawn AI
    _aiParams = [_wreckPosition, _isWaterCrash];
    [_aiParams] call ExileServer_BigfootsHeliCrash_spawnAICommand;

    // Log spawn details
    format["Spawned land wreck: %1 at %2", _wreckType, _wreckPosition] call ExileServer_BigfootsHeliCrash_util_logCommand;
    format["Spawned crate: %1 at %2", _crateType, _cratePosition] call ExileServer_BigfootsHeliCrash_util_logCommand;
};

// Loop to spawn **water heli crashes**
for "_i" from 1 to _waterWreckCount do {
    _wreckPosition = call _findSpawnPosition(true); // Water crash

    // Validate position
    if (count _wreckPosition == 0) then {
        ["WARNING: Could not find a valid water crash site. Skipping..."] call ExileServer_BigfootsHeliCrash_util_logCommand;
        continue;
    };

    _wreckType = selectRandom BH_class_wreckage;
    _crateType = selectRandom BH_class_crate;
    _isWaterCrash = true;

    // Spawn wreck
    private _wreck = createVehicle [_wreckType, _wreckPosition, [], 0, "NONE"];
    _wreck setVectorUp surfaceNormal _wreckPosition;
    
    // Spawn loot crate
    private _cratePosition = _wreckPosition getPos [BH_locations_crateWreckOffset, random 360];
    _crate = createVehicle [_crateType, _cratePosition, [], 0, "CAN_COLLIDE"];

    // Create map marker
    _marker = createMarker [format ["WaterHeliCrash_%1", _i], _wreckPosition];
    _marker setMarkerType "mil_destroy";
    _marker setMarkerColor BH_marker_colorWater;

    // Spawn AI (underwater)
    _aiParams = [_wreckPosition, _isWaterCrash];
    [_aiParams] call ExileServer_BigfootsHeliCrash_spawnAICommand;

    // Spawn Zodiacs and shore loot if enabled
    if (BH_vehicle_enableZodiacs) then {
        [_wreckPosition] call ExileServer_BigfootsHeliCrash_spawnSupportAssets;
    };

    // Log spawn details
    format["Spawned water wreck: %1 at %2", _wreckType, _wreckPosition] call ExileServer_BigfootsHeliCrash_util_logCommand;
    format["Spawned crate: %1 at %2", _crateType, _cratePosition] call ExileServer_BigfootsHeliCrash_util_logCommand;
};

["Finished spawning Heli Crashes."] call ExileServer_BigfootsHeliCrash_util_logCommand;
