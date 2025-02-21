/*
 * ExileServer_BigfootsHeliCrash_spawnHeliCrashCommand.sqf
 * 
 * Spawns heli crash wrecks, loot crates, and AI defenders.
 * AI are dynamically chosen for land or water missions.
 *
 * Updated by: sko & Ghost PGM DEV TEAM
 */

private ["_wreckagePosition", "_wreck", "_wreckType", "_crate", "_crateType", "_cratePosition", "_isWaterCrash", "_markerId"];

// Log function start
["Starting Heli Crash Spawn Process..."] call ExileServer_BigfootsHeliCrash_util_logCommand;

// Ensure the wreck count variable is defined correctly
private _wreckCount = BH_count_HeliCrash;

// Validate wreck count before proceeding
if (isNil "_wreckCount" || { _wreckCount <= 0 }) exitWith 
{
    ["ERROR: Invalid wreck count! Check `BH_count_HeliCrash` in config.sqf"] call ExileServer_BigfootsHeliCrash_util_logCommand;
};

// Loop to spawn wrecks
for "_i" from 1 to _wreckCount do
{
    _wreckagePosition = [BH_locations_center, BH_locations_distance_min, BH_locations_distance_max, 0, 0, 10, 0] call BIS_fnc_findSafePos;
    
    // Validate spawn position
    if (count _wreckagePosition == 0) then 
    {
        ["WARNING: Could not find a safe position for wreck spawn!"] call ExileServer_BigfootsHeliCrash_util_logCommand;
        continue;
    };

    // Determine if crash is in water
    _isWaterCrash = surfaceIsWater _wreckagePosition;

    _wreckType = selectRandom BH_class_wreckage;
    _wreck = createVehicle [_wreckType, _wreckagePosition, [], 0, "NONE"];
    _wreck setVectorUp surfaceNormal _wreckagePosition;

    format ["Spawned wreck: %1 at %2", _wreckType, _wreckagePosition] call ExileServer_BigfootsHeliCrash_util_logCommand;

    // Crate Spawning
    _crateType = selectRandom BH_class_crate;
    _cratePosition = _wreckagePosition getPos [BH_locations_crateWreckOffset, random 360];
    _crate = createVehicle [_crateType, _cratePosition, [], 0, "CAN_COLLIDE"];

    format ["Spawned crate: %1 at %2", _crateType, _cratePosition] call ExileServer_BigfootsHeliCrash_util_logCommand;

    // Create Marker (Different color for land & water crashes)
    _markerId = format ["HeliCrash_%1", _i];
    [_markerId, _wreckagePosition, _isWaterCrash] call ExileServer_BigfootsHeliCrash_createHeliCrashMarkerCommand;

    // Spawn AI Defenders
    [_wreckagePosition, _isWaterCrash, _markerId] spawn ExileServer_BigfootsHeliCrash_spawnAICommand;

    // Water Missions: Spawn shore support assets (boats, gear crate)
    if (_isWaterCrash) then {
        [_wreckagePosition] spawn ExileServer_BigfootsHeliCrash_spawnSupportAssets;
    };
};

["Finished spawning Heli Crashes."] call ExileServer_BigfootsHeliCrash_util_logCommand;
