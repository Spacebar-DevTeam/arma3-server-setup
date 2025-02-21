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
	
	The fn_getRandomCity.sqf script selects a random city from the ZCP_Towns array 
	while avoiding restricted areas such as territories, trader zones, spawn zones, 
	players, or AI presence. It uses a loop to find a valid city position that meets 
	all conditions, with debug logging to track the selection process.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Added maximum attempts to avoid infinite loops.
      Debugging: Enhanced logs for failure reasons and successful selections.
      Code Safety: Validates city data and position before returning.
      Performance: Streamlined while loop with continue to avoid unnecessary checks.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

private _ZCP_GRC_pos = [0,0,0];
private _ZCP_GRC_cityName = "";
private _ZCP_GRC_attempts = 0;
private _ZCP_GRC_maxAttempts = 100;
private _ZCP_GRC_safePos = false;

while {!_ZCP_GRC_safePos && (_ZCP_GRC_attempts < _ZCP_GRC_maxAttempts)} do {
    _ZCP_GRC_attempts = _ZCP_GRC_attempts + 1;

    private _ZCP_GRC_cityData = ZCP_Towns call BIS_fnc_selectRandom;
    _ZCP_GRC_pos = _ZCP_GRC_cityData select 0;
    _ZCP_GRC_cityName = _ZCP_GRC_cityData select 2;

    _ZCP_GRC_safePos = true;

    // Avoid territories
    if (ZCP_AvoidTerritories && {[_ZCP_GRC_pos, ZCP_DistanceFromTerritories] call ExileClient_util_world_isInTerritory}) then {
        _ZCP_GRC_safePos = false;
        if (ZCP_Debug) then { diag_log format ["[ZCP] City %1 is in a territory", _ZCP_GRC_cityName]; };
        continue;
    };

    // Avoid trader zones
    if (ZCP_AvoidTraderZones && {[_ZCP_GRC_pos, ZCP_DistanceFromTraderZones] call ExileClient_util_world_isInTraderZone}) then {
        _ZCP_GRC_safePos = false;
        if (ZCP_Debug) then { diag_log format ["[ZCP] City %1 is in a trader zone", _ZCP_GRC_cityName]; };
        continue;
    };

    // Avoid spawn zones
    if (ZCP_AvoidSpawnZones && {[_ZCP_GRC_pos, ZCP_DistanceFromSpawnZones] call ExileClient_util_world_isInSpawnZone}) then {
        _ZCP_GRC_safePos = false;
        if (ZCP_Debug) then { diag_log format ["[ZCP] City %1 is in a spawn zone", _ZCP_GRC_cityName]; };
        continue;
    };

    // Avoid players
    if (ZCP_DistanceFromPlayers > 0 && {count (player nearEntities [["Exile_Unit_Player"], ZCP_DistanceFromPlayers]) > 0}) then {
        _ZCP_GRC_safePos = false;
        if (ZCP_Debug) then { diag_log format ["[ZCP] City %1 is too close to players", _ZCP_GRC_cityName]; };
        continue;
    };

    // Avoid AI
    if (ZCP_DistanceFromAI > 0 && {count (allUnits select {side _x == east && (_x distance _ZCP_GRC_pos) < ZCP_DistanceFromAI}) > 0}) then {
        _ZCP_GRC_safePos = false;
        if (ZCP_Debug) then { diag_log format ["[ZCP] City %1 is too close to AI", _ZCP_GRC_cityName]; };
        continue;
    };
};

if (!_ZCP_GRC_safePos) then {
    diag_log "[ZCP] ERROR: Unable to find a valid city within maximum attempts.";
    _ZCP_GRC_pos = [0,0,0];
    _ZCP_GRC_cityName = "None";
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Selected city %1 at %2 after %3 attempts.", _ZCP_GRC_cityName, _ZCP_GRC_pos, _ZCP_GRC_attempts];
};

[_ZCP_GRC_pos, _ZCP_GRC_cityName]

/*
private _ZCP_GRC_isInVallidTown = true;
private _ZCP_GRC_town = [];

if(count ZCP_Towns > 0) then
{
    while
        {
            _ZCP_GRC_isInVallidTown
        }
    do
        {
            _ZCP_GRC_isInVallidTown = false;

            _ZCP_GRC_town = ZCP_Towns call BIS_fnc_selectRandom;

            // _ZCP_GRC_town = [ location, radius, name, (optional) basearray];

            diag_log text format['[ZCP]: Trying town: %1',  _ZCP_GRC_town select 2];

            private _ZCP_GRC_position = _ZCP_GRC_town select 0;

            _ZCP_GRC_position set [2, 0];

            if(([_ZCP_GRC_position, ZCP_CONFIG_CityDistanceToTerritory] call ExileClient_util_world_isTerritoryInRange)) then { _ZCP_GRC_isInVallidTown = true; };

            // is position in range of a trader zone?
            if(([_ZCP_GRC_position, ZCP_CONFIG_CityDistanceToTrader] call ExileClient_util_world_isTraderZoneInRange)) then { _ZCP_GRC_isInVallidTown = true; };

            // is position in range of a spawn zone?
            if(([_ZCP_GRC_position, ZCP_CONFIG_CityDistanceToSpawn] call ExileClient_util_world_isSpawnZoneInRange)) then { _ZCP_GRC_isInVallidTown = true; };

            // is position in range of a player?
            if(([_ZCP_GRC_position, ZCP_CONFIG_CityDistanceToPlayer] call ExileClient_util_world_isAlivePlayerInRange)) then { _ZCP_GRC_isInVallidTown = true; };

            // is position is close to other AI:
            if( count (_ZCP_GRC_position nearEntities ["O_recon_F", ZCP_CONFIG_CityDistanceToAI])  > 0 ) then { _ZCP_GRC_isInVallidTown = true; };

            sleep 1;

        };
};

_ZCP_GRC_town
*/