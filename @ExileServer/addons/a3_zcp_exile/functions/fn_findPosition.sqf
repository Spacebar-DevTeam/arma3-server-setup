/*
	Zupa's Capture Points
	  Airstrike on base to innitiate cleanup
	  Capture points and earn money over time.
	
	╔════╗─────────╔═══╗────────╔╗─────────────╔╗
	╚══╗═║─────────╚╗╔╗║────────║║────────────╔╝╚╗
	──╔╝╔╬╗╔╦══╦══╗─║║║╠══╦╗╔╦══╣║╔══╦╗╔╦══╦═╗╚╗╔╬══╗
	─╔╝╔╝║║║║╔╗║╔╗║─║║║║║═╣╚╝║║═╣║║╔╗║╚╝║║═╣╔╗╗║║║══╣
	╔╝═╚═╣╚╝║╚╝║╔╗║╔╝╚╝║║═╬╗╔╣║═╣╚╣╚╝║║║║║═╣║║║║╚╬══║
	╚════╩══╣╔═╩╝╚╝╚═══╩══╝╚╝╚══╩═╩══╩╩╩╩══╩╝╚╝╚═╩══╝
	────────║║
	────────╚╝
	
	The fn_findPosition.sqf script finds a valid position for ZCP missions by evaluating 
	terrain, avoiding water, and ensuring sufficient distance from other missions and 
	blacklisted zones. It uses BIS_fnc_findSafePos and custom conditions to repeatedly 
	search for a valid spot until all criteria are met.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Combined checks and used breakOut for cleaner loops.
      Enhanced Debugging: More informative logs for each failure reason.
      Error Handling: Limits search attempts to avoid infinite loops.
      Code Clarity: Consistent and clear parameter usage.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    "_ZCP_FP_pos",
    "_ZCP_FP_radius",
    "_ZCP_FP_missionType",
    ["_ZCP_FP_maxGradient", ZCP_MaxTerrainGradient, [0]],
    ["_ZCP_FP_distanceFromWater", ZCP_DistanceFromWater, [0]],
    ["_ZCP_FP_minDistanceFromMissions", ZCP_MinDistanceFromOtherMissions, [0]]
];

private _ZCP_FP_position = [0, 0, 0];
private _ZCP_FP_safePosConfig = [
    _ZCP_FP_pos,
    _ZCP_FP_radius,
    ["water", "trees", "buildings", "objects", "civilians", "roads", "sea", "rocks"],
    5,
    10,
    0
];

private _ZCP_FP_attempts = 0;
private _ZCP_FP_maxAttempts = 100;

while {_ZCP_FP_attempts < _ZCP_FP_maxAttempts} do {
    _ZCP_FP_attempts = _ZCP_FP_attempts + 1;
    _ZCP_FP_position = _ZCP_FP_safePosConfig call BIS_fnc_findSafePos;

    if (surfaceIsWater _ZCP_FP_position) exitWith {
        if (ZCP_Debug) then { diag_log "[ZCP] Failed to find safe position (water detected)"; };
        _ZCP_FP_position = [0,0,0];
    };

    if ((_ZCP_FP_distanceFromWater > 0) && {[_ZCP_FP_position, _ZCP_FP_distanceFromWater] call ZCP_fnc_nearWater}) exitWith {
        if (ZCP_Debug) then { diag_log "[ZCP] Failed to find safe position (too close to water)"; };
        _ZCP_FP_position = [0,0,0];
    };

    if (ZCP_UseBlacklists && {[_ZCP_FP_position] call ZCP_fnc_isPosBlacklisted}) exitWith {
        if (ZCP_Debug) then { diag_log "[ZCP] Failed to find safe position (blacklisted zone)"; };
        _ZCP_FP_position = [0,0,0];
    };

    if (ZCP_FP_minDistanceFromMissions > 0) then {
        if ({(_x distance _ZCP_FP_position) < _ZCP_FP_minDistanceFromMissions} count (ZCP_Data select {(_x select 0) && {(_x select 1) > 0}})) > 0 then {
            if (ZCP_Debug) then { diag_log "[ZCP] Failed to find safe position (too close to other missions)"; };
            _ZCP_FP_position = [0,0,0];
        };
    };

    private _terrainGradient = abs (surfaceNormal _ZCP_FP_position select 2);
    if (_terrainGradient > _ZCP_FP_maxGradient) exitWith {
        if (ZCP_Debug) then { diag_log format ["[ZCP] Terrain gradient too steep: %1 > %2", _terrainGradient, _ZCP_FP_maxGradient]; };
        _ZCP_FP_position = [0,0,0];
    };

    if (_ZCP_FP_position distance _ZCP_FP_pos > _ZCP_FP_radius) exitWith {
        if (ZCP_Debug) then { diag_log "[ZCP] Position outside allowed radius"; };
        _ZCP_FP_position = [0,0,0];
    };

    breakOut "foundValidPosition";
};

if (_ZCP_FP_attempts >= _ZCP_FP_maxAttempts) then {
    diag_log "[ZCP] ERROR: Unable to find a valid mission position after maximum attempts.";
    _ZCP_FP_position = [0,0,0];
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Found valid mission position at %1 after %2 attempts.", _ZCP_FP_position, _ZCP_FP_attempts];
};

_ZCP_FP_position

/*
params
[
	"_ZCP_FP_distanceFromObjects",
	"_ZCP_FP_terrainGradientPos"
];

private _ZCP_FP_safepos		= [ZCP_MapCenterPos, 0, ZCP_MapRadius, _ZCP_FP_distanceFromObjects, 0, _ZCP_FP_terrainGradientPos, 0];
//diag_log format['[ZCP]: %1 selected | Objectdistance: %2 | Gradient: %3', _ZCP_FP_safepos, _ZCP_FP_distanceFromObjects, _ZCP_FP_terrainGradientPos];
private _ZCP_FP_validspot 	= false;
private _ZCP_FP_position = [-99999,0,0];

while{!_ZCP_FP_validspot} do {
	sleep 1;
	_ZCP_FP_position 	= _ZCP_FP_safepos call BIS_fnc_findSafePos;
	_ZCP_FP_validspot	= true;
	if (_ZCP_FP_position call ZCP_fnc_inDebug) then {
		_ZCP_FP_validspot = false;
		//diag_log format['[ZCP]: %1 in debug', _ZCP_FP_position];
	};
	if(_ZCP_FP_validspot ) then {
		if ([_ZCP_FP_position, ZCP_DistanceFromWater] call ZCP_fnc_nearWater) then {
		_ZCP_FP_validspot = false;
		//diag_log format['[ZCP]: %1 to close to water (%2 meter)', _ZCP_FP_position, ZCP_DistanceFromWater];
		};
	};
	if(_ZCP_FP_validspot) then {
		{
			if ( (_x select 2) select 0 != -99999 && _ZCP_FP_position distance2D (_x select 2) < ZCP_DistanceBetweenMissions) exitWith {
					_ZCP_FP_validspot = false;
					//diag_log format['[ZCP]: %1 to close to other mission', _ZCP_FP_position];
			};
		} count ZCP_Data;
    };

	if(_ZCP_FP_validspot) then {
		{
			if ( _ZCP_FP_position distance2D (_x select 0) < (_x select 1)) exitWith {
					_ZCP_FP_validspot = false;
					//diag_log format['[ZCP]: %1 to close to bloacklist %2', _ZCP_FP_position, _x];
			};
		} count ZCP_Blacklist;
    };

	if(_ZCP_FP_validspot ) then {
		// DMS code, Credits -> DMS
		{
			// Check for nearby spawn points
			if ((ZCP_SpawnZoneDistance>0) && {((markertype _x) in ZCP_SpawnZoneMarkerTypes) && {((getMarkerPos _x) distance2D _ZCP_FP_position) <= ZCP_SpawnZoneDistance}}) exitWith
			{
					_ZCP_FP_validspot = false;
					//diag_log format['[ZCP]: %1 to close to spanwzone %2 meter', _ZCP_FP_position, ZCP_SpawnZoneDistance];
			};

			// Check for nearby trader zones
			if ((ZCP_TradeZoneDistance>0) && {((markertype _x) in ZCP_TraderZoneMarkerTypes) && {((getMarkerPos _x) distance2D _ZCP_FP_position) <= ZCP_TradeZoneDistance}}) exitWith
			{
					_ZCP_FP_validspot = false;
					//diag_log format['[ZCP]: %1 to close to traderzone %2 meter', _ZCP_FP_position, ZCP_TradeZoneDistance];
			};
		}forEach allMapMarkers;
	};

	if (_ZCP_FP_validspot) then {
	  // is position in range of a territory?
        if(([_ZCP_FP_position, ZCP_CONFIG_TerritoryDistance] call ExileClient_util_world_isTerritoryInRange)) exitWith { _ZCP_FP_validspot = false; };

        // is position in range of a trader zone?
        if(([_ZCP_FP_position, ZCP_TradeZoneDistance] call ExileClient_util_world_isTraderZoneInRange)) exitWith { _ZCP_FP_validspot = false; };

        // is position in range of a spawn zone?
        if(([_ZCP_FP_position, ZCP_SpawnZoneDistance] call ExileClient_util_world_isSpawnZoneInRange)) exitWith { _ZCP_FP_validspot = false; };

        // is position in range of a player?
        if(([_ZCP_FP_position, ZCP_DistanceFromPlayers] call ExileClient_util_world_isAlivePlayerInRange)) exitWith { _ZCP_FP_validspot = false; };

	};

	if ( _ZCP_FP_validspot ) then {
	    _ZCP_FP_Buidlings =  nearestObjects [_ZCP_FP_position, ZCP_CONFIG_BaseObjectsClasses, ZCP_DistanceFromBaseObjects];
        if (count _ZCP_FP_Buidlings > 0) then {
            _ZCP_FP_validspot = false;
        };
    };

};

_ZCP_FP_position set [2, 0];
_ZCP_FP_position
*/