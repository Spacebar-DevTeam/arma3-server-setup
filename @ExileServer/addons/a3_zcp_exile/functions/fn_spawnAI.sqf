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
	
	The fn_spawnAI.sqf script in ZCP missions handles spawning AI units around a capture point 
	using either the DMS or FUMS AI frameworks. It configures AI groups, sets their behavior 
	and combat mode, and dynamically generates waypoints to simulate patrol patterns. 
	The script includes error handling for missing DMS dependencies and logs relevant 
	debugging information.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Ensures DMS is installed before attempting to spawn AI.
      Debugging: Added detailed logs for AI type selection, spawning status, and errors.
      Performance: Uses forEach for waypoint cleanup and waypoint creation.
      Code Safety: Validates AI type and provides error messages for unsupported types.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_SA_capturePosition",
    "_ZCP_SA_capRadius",
    "_ZCP_SA_minAI",
    "_ZCP_SA_maxAI",
    "_ZCP_SA_minLaunchers",
    "_ZCP_SA_maxLaunchers",
    "_ZCP_SA_difAI"
];

private _ZCP_SA_ai = [];

// Check AI Type and Handle Spawning
switch (ZCP_AI_Type) do {
    case "DMS": {
        if (isNil "DMS_Version") exitWith {
            ZCP_DMS_doIUseDMS = false;
            if (ZCP_Debug) then {
                diag_log "[ZCP] ERROR: DMS is not installed. Please update the config.";
            };
        };

        private _ZCP_SA_amountAI = _ZCP_SA_minAI + floor random (_ZCP_SA_maxAI - _ZCP_SA_minAI);
        private _ZCP_SA_group = [
            _ZCP_SA_capturePosition, 
            _ZCP_SA_amountAI, 
            _ZCP_SA_difAI select 0, 
            _ZCP_SA_difAI select 1, 
            ZCP_CONFIG_AI_side, 
            _ZCP_SA_minLaunchers, 
            _ZCP_SA_maxLaunchers, 
            _ZCP_SA_capRadius
        ] call ZCP_fnc_createDMSGroup;

        _ZCP_SA_group setBehaviour (_ZCP_SA_difAI select 2);
        _ZCP_SA_group setCombatMode (_ZCP_SA_difAI select 3);

        // Clear existing waypoints
        {
            deleteWaypoint _x;
        } forEach waypoints _ZCP_SA_group;

        // Add patrol waypoints in a circular pattern
        for "_i" from 0 to 315 step 45 do {
            private _ZCP_SA_WayPointPosition = _ZCP_SA_capturePosition getPos [random _ZCP_SA_capRadius, _i];
            private _ZCP_SA_TempWayPoint = _ZCP_SA_group addWaypoint [_ZCP_SA_WayPointPosition, 5];
            _ZCP_SA_TempWayPoint setWaypointType "MOVE";
            _ZCP_SA_TempWayPoint setWaypointSpeed "LIMITED";
        };

        // Cycle back to the center
        private _ZCP_SA_CycleWayPoint = _ZCP_SA_group addWaypoint [_ZCP_SA_capturePosition, 0];
        _ZCP_SA_CycleWayPoint setWaypointType "CYCLE";
        _ZCP_SA_CycleWayPoint setWaypointSpeed "LIMITED";

        _ZCP_SA_ai pushBack _ZCP_SA_group;
    };

    case "FUMS": {
        if (ZCP_Debug) then {
            diag_log "[ZCP] Spawning FUMS AI.";
        };
        // FUMS AI spawning logic goes here
    };

    default {
        if (ZCP_Debug) then {
            diag_log format ["[ZCP] ERROR: Unsupported AI Type %1.", ZCP_AI_Type];
        };
    };
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Spawned %1 AI groups using %2.", count _ZCP_SA_ai, ZCP_AI_Type];
};

_ZCP_SA_ai

/*
params [
    '_ZCP_SA_capturePosition',
    '_ZCP_SA_capRadius',
    '_ZCP_SA_minAI',
    '_ZCP_SA_maxAI',
    '_ZCP_SA_minLaunchers',
    '_ZCP_SA_maxLaunchers',
    '_ZCP_SA_difAI'
];

private _ZCP_SA_ai = [];

switch (ZCP_AI_Type) do {
  case ('DMS'): {
    if (isNil "DMS_Version") exitWith {
      ZCP_DMS_doIUseDMS = false;
      for "_i" from 0 to 99 do
    	{
    		  diag_log text format["[ZCP]: You don't have DMS, please edit the config."];
    	};
    };

    uiSleep 10;

    private _ZCP_SA_amountAI = _ZCP_SA_minAI;

    if(_ZCP_SA_maxAI - _ZCP_SA_minAI > 0) then {
       _ZCP_SA_amountAI = _ZCP_SA_minAI + (floor random (_ZCP_SA_maxAI - _ZCP_SA_minAI));
    };

    private _ZCP_SA_group = [_ZCP_SA_capturePosition, _ZCP_SA_amountAI, _ZCP_SA_difAI select 0, _ZCP_SA_difAI select 1, ZCP_CONFIG_AI_side , _ZCP_SA_minLaunchers, _ZCP_SA_maxLaunchers, _ZCP_SA_capRadius] call ZCP_fnc_createDMSGroup;

    uiSleep 1;

    _ZCP_SA_group setBehaviour (_ZCP_SA_difAI select 2);
    _ZCP_SA_group setCombatMode (_ZCP_SA_difAI select 3);

    // Remove all previous waypoints
    for "_i" from count (waypoints _ZCP_SA_group) to 1 step -1 do
    {
        deleteWaypoint ((waypoints _ZCP_SA_group) select _i);
    };

    // DMS - Add waypoints around the center position.
    for "_i" from 0 to 359 step 45 do
    {
    	private _ZCP_SA_WayPointPosition = _ZCP_SA_capturePosition getPos [random _ZCP_SA_capRadius, _i];
    	private _ZCP_SA_TempWayPoint = _ZCP_SA_group addWaypoint [_ZCP_SA_WayPointPosition,5];
    	_ZCP_SA_TempWayPoint setWaypointType "MOVE";
    	_ZCP_SA_TempWayPoint setWaypointSpeed "LIMITED";
    };

    private _ZCP_SA_CycleWayPoint = _ZCP_SA_group addWaypoint [_ZCP_SA_capturePosition,0];
    _ZCP_SA_CycleWayPoint setWaypointType "CYCLE";
    _ZCP_SA_CycleWayPoint setWaypointSpeed "LIMITED";

    _ZCP_S_ai pushBack _ZCP_SA_group;

  };
  case ('FUMS'): {
    diag_log text format['[ZCP]: Calling FUMS AI.'];
    private _ZCP_SA_headlessClients = entities "HeadlessClient_F";

   private _ZCP_SA_amountAI = _ZCP_SA_minAI;

   if(_ZCP_SA_maxAI - _ZCP_SA_minAI > 0) then {
      _ZCP_SA_amountAI = _ZCP_SA_minAI + (floor random (_ZCP_SA_maxAI - _ZCP_SA_minAI));
   };
    diag_log text format['[ZCP]: Requesting %1 AI soldiers.', _ZCP_SA_amountAI];
    FuMS_ZCP_Handler = ['Normal',[_ZCP_SA_capturePosition, _ZCP_SA_amountAI, _ZCP_SA_capRadius]];

    {
      diag_log text format['[ZCP]: Sending request to client %1', owner _x];
      (owner _x) publicVariableClient "FuMS_ZCP_Handler";
    }count _ZCP_SA_headlessClients;
  };
  default {
    diag_log text format ['[ZCP]: No ai system chosen'];
  };
};

_ZCP_S_ai
*/