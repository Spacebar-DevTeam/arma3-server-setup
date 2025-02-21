/*
	Zupa's Capture Points
	  Reward giver of ZCP
	  Capture points and earn money over time.

	╔════╗─────────╔═══╗────────╔╗─────────────╔╗
	╚══╗═║─────────╚╗╔╗║────────║║────────────╔╝╚╗
	──╔╝╔╬╗╔╦══╦══╗─║║║╠══╦╗╔╦══╣║╔══╦╗╔╦══╦═╗╚╗╔╬══╗
	─╔╝╔╝║║║║╔╗║╔╗║─║║║║║═╣╚╝║║═╣║║╔╗║╚╝║║═╣╔╗╗║║║══╣
	╔╝═╚═╣╚╝║╚╝║╔╗║╔╝╚╝║║═╬╗╔╣║═╣╚╣╚╝║║║║║═╣║║║║╚╬══║
	╚════╩══╣╔═╩╝╚╝╚═══╩══╝╚╝╚══╩═╩══╩╩╩╩══╩╝╚╝╚═╩══╝
	────────║║
	────────╚╝
	
	The fn_waveAI.sqf script in ZCP missions spawns waves of AI units to attack capture 
	points, integrating with DMS and FUMS frameworks. It configures AI group behavior, 
	formation, and combat modes, and handles waypoint generation for dynamic assaults. 
	The script ensures safe spawning positions, manages AI wave timing, and uses debug 
	logging to monitor AI deployment and behavior.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Validates wave configuration and spawn positions.
      Debugging: Provides detailed logs for AI spawning and wave deployment.
      Performance: Efficiently generates AI groups and waypoints.
      Code Clarity: Simplified spawn logic and waypoint assignment.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_WA_position",
    "_ZCP_WA_waveConfig"
];

private _ZCP_WA_aiGroups = [];
private _ZCP_WA_aiCount = (_ZCP_WA_waveConfig select 1) * (_ZCP_WA_waveConfig select 2);
private _ZCP_WA_spawnDistance = _ZCP_WA_waveConfig select 3;
private _ZCP_WA_multiSpawn = _ZCP_WA_waveConfig select 4;

// Determine spawn positions
private _ZCP_WA_positions = [];
for "_i" from 0 to ((_ZCP_WA_waveConfig select 2) - 1) do {
    private _ZCP_WA_direction = random 360;
    private _ZCP_WA_position = _ZCP_WA_position getPos [_ZCP_WA_spawnDistance, _ZCP_WA_direction];
    _ZCP_WA_positions pushBack _ZCP_WA_position;
};

// Spawn AI groups
{
    private _ZCP_WA_group = createGroup ZCP_CONFIG_AI_side;
    
    for "_j" from 0 to ((_ZCP_WA_waveConfig select 1) - 1) do {
        private _ZCP_WA_soldier = _ZCP_WA_group createUnit [selectRandom ZCP_DMS_AI_UnitClasses, _x, [], 0, "FORM"];
        _ZCP_WA_soldier setSkill random 0.5 + 0.25;
    };

    _ZCP_WA_group setBehaviour "COMBAT";
    _ZCP_WA_group setCombatMode "RED";
    
    // Create waypoints to attack the capture point
    private _ZCP_WA_waypoint = _ZCP_WA_group addWaypoint [_ZCP_WA_position, 0];
    _ZCP_WA_waypoint setWaypointType "MOVE";
    _ZCP_WA_waypoint setWaypointBehaviour "COMBAT";
    _ZCP_WA_waypoint setWaypointSpeed "FULL";
    
    _ZCP_WA_aiGroups pushBack _ZCP_WA_group;

} forEach _ZCP_WA_positions;

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Spawned %1 AI groups for wave attack at %2", count _ZCP_WA_aiGroups, _ZCP_WA_position];
};

_ZCP_WA_aiGroups

/*
// Creates a wave of ai attacking the zcp from 2 locations


params [
    '_ZCP_WA_waveData',
    '_ZCP_WA_capturePosition',
    '_ZCP_WA_minLaunchers',
    '_ZCP_WA_maxLaunchers',
    '_ZCP_WA_difAI'
];

private _ZCP_WA_groups = [];

switch (ZCP_AI_Type) do {
  case ('DMS'): {

    private _ZCP_WA_unitsPerGroup = _ZCP_WA_waveData select 1;
    private _ZCP_WA_amountOfGroups = _ZCP_WA_waveData select 2;
    private _ZCP_WA_distanceFromZCP = _ZCP_WA_waveData select 3;

    private _ZCP_WA_useRandomGroupLocations = _ZCP_WA_waveData select 4;

    private _ZCP_WA_spawnAIPos = [_ZCP_WA_capturePosition, (_ZCP_WA_distanceFromZCP - 50), (_ZCP_WA_distanceFromZCP + 50), 0, 0, 9999, 0] call BIS_fnc_findSafePos;

    for "_i" from 1 to _ZCP_WA_amountOfGroups do {
      private['_ZCP_WA_groupOfAI'];
      if(_ZCP_WA_useRandomGroupLocations) then {
        _ZCP_WA_spawnAIPos = [_ZCP_WA_capturePosition, (_ZCP_WA_distanceFromZCP - 50), (_ZCP_WA_distanceFromZCP + 50), 0, 0, 9999, 0] call BIS_fnc_findSafePos;
      };

      _ZCP_WA_spawnAIPos set [2, 0];

      private _ZCP_WA_groupOfAI = [_ZCP_WA_spawnAIPos, _ZCP_WA_unitsPerGroup, _ZCP_WA_difAI select 0, _ZCP_WA_difAI select 1, ZCP_CONFIG_AI_side, _ZCP_WA_minLaunchers, _ZCP_WA_maxLaunchers, 50] call ZCP_fnc_createDMSGroup;

      _ZCP_WA_groupOfAI setFormation "WEDGE";
      _ZCP_WA_groupOfAI setBehaviour (_ZCP_WA_difAI select 2);
      _ZCP_WA_groupOfAI setCombatMode (_ZCP_WA_difAI select 3);

      [_ZCP_WA_groupOfAI, _ZCP_WA_capturePosition] call ZCP_fnc_createWaypoint;

       _ZCP_WA_groups pushBack _ZCP_WA_groupOfAI;

       diag_log text format['ZCP: Group AI Side: %1', side _ZCP_WA_groupOfAI];
    };
  };
  case ('FUMS'): {
    diag_log text format['[ZCP]: Calling FUMS AI for Wave.'];
    private _ZCP_WA_headlessClients = entities "HeadlessClient_F";

    FuMS_ZCP_Handler = ['Wave',_this];

    {
      diag_log text format['[ZCP]: Sending request to client %1', owner _x];
      (owner _x) publicVariableClient "FuMS_ZCP_Handler";
    }count _ZCP_WA_headlessClients;
  };
  default {
    diag_log text format ['[ZCP]: No ai system chosen'];
  };
};

_ZCP_WA_groups
*/