/*
 * ExileServer_BigfootsHeliCrash_spawnAIReinforcements.sqf
 * 
 * Spawns AI reinforcements if players take too long to complete the mission.
 *
 * Features:
 * - **Land Reinforcements:** Armed vehicles & infantry.
 * - **Air Reinforcements:** Attack helicopters.
 * - **Sea Reinforcements:** Boats & divers for underwater crashes.
 * - **Dynamic AI Scaling:** Number of AI depends on online player count.
 * - **Backup AI Intelligence:** AI communicates and coordinates.
 *
 * Updated by: sko & Ghost PGM DEV TEAM
 */

if (!isServer) exitWith {};

// Define variables
private ["_wreckagePosition", "_isWaterCrash", "_aiReinforcementType", "_aiGroup", "_vehicle", "_unit", "_spawnPosition", "_aiCount"];

// Extract parameters
_wreckagePosition = _this select 0;
_isWaterCrash = _this select 1;

// Delay before reinforcements arrive (default: 15 minutes)
uiSleep BH_AI_reinforce_time;

// Calculate AI reinforcement size based on online players
_aiCount = round ((count allPlayers) / 5) + selectRandom [BH_AI_reinforce_min, BH_AI_reinforce_max];
_aiCount = _aiCount min BH_AI_reinforce_max; // Ensure it doesn't exceed max AI

// Select reinforcement type
_aiReinforcementType = selectRandom ["LAND", "AIR", "SEA"];

// Find a valid spawn position near the wreck
_spawnPosition = _wreckagePosition getPos [random 600 + 300, random 360];

// LAND REINFORCEMENTS (Armed Vehicles & Infantry)
if (_aiReinforcementType == "LAND" && !_isWaterCrash) then 
{
    _vehicle = createVehicle ["O_MRAP_02_hmg_F", _spawnPosition, [], 0, "NONE"];
    _aiGroup = createGroup EAST;

    for "_i" from 1 to _aiCount do 
    {
        _unit = _aiGroup createUnit ["O_Soldier_F", _spawnPosition, [], 0, "NONE"];
        _unit moveInAny _vehicle;
    };

    _aiGroup setBehaviour "AWARE";
    _aiGroup move _wreckagePosition;
};

// AIR REINFORCEMENTS (Attack Helicopters)
if (_aiReinforcementType == "AIR") then 
{
    _vehicle = createVehicle ["O_Heli_Attack_02_black_F", _spawnPosition, [], 0, "FLY"];
    _vehicle flyInHeight 100;
    _aiGroup = createGroup EAST;
    
    _unit = _aiGroup createUnit ["O_helipilot_F", _spawnPosition, [], 0, "NONE"];
    _unit moveInDriver _vehicle;
    _aiGroup move _wreckagePosition;
};

// SEA REINFORCEMENTS (Gunboats & Divers)
if (_aiReinforcementType == "SEA" && _isWaterCrash) then 
{
    _vehicle = createVehicle ["O_Boat_Armed_01_hmg_F", _spawnPosition, [], 0, "NONE"];
    _aiGroup = createGroup EAST;

    for "_i" from 1 to _aiCount do 
    {
        _unit = _aiGroup createUnit ["O_diver_F", _spawnPosition, [], 0, "NONE"];
        _unit moveInAny _vehicle;
    };

    _aiGroup setBehaviour "COMBAT";
    _aiGroup move _wreckagePosition;
};

// Log reinforcement arrival
format ["Reinforcements (Type: %1, AI Count: %2) sent to [%3].", _aiReinforcementType, _aiCount, _wreckagePosition] call ExileServer_BigfootsHeliCrash_util_logCommand;
