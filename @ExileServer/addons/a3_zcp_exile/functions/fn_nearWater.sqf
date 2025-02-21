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
	
	The fn_nearWater.sqf script checks if a given position is near water within a specified 
	radius. It calculates positions around the central point in 45-degree steps and uses 
	surfaceIsWater to determine if any of these points are on water. The script returns 
	true if water is detected, otherwise false.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Combined position calculation and water check into a single loop.
      Enhanced Debugging: Provides specific feedback when water is detected.
      Performance: Uses exitWith for early loop termination when water is found.
      Code Clarity: Consistent naming and structured output for debugging.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_NW_position",
    "_ZCP_NW_radius"
];

private _ZCP_NW_nearWater = false;

// Check 8 points around the radius in 45-degree increments
for "_i" from 0 to 315 step 45 do {
    private _ZCP_NW_checkPos = [
        (_ZCP_NW_position select 0) + (cos _i * _ZCP_NW_radius),
        (_ZCP_NW_position select 1) + (sin _i * _ZCP_NW_radius),
        0
    ];
    
    if (surfaceIsWater _ZCP_NW_checkPos) exitWith {
        _ZCP_NW_nearWater = true;
        
        if (ZCP_Debug) then {
            diag_log format ["[ZCP] Water detected near position %1 at %2", _ZCP_NW_position, _ZCP_NW_checkPos];
        };
    };
};

if (ZCP_Debug && !_ZCP_NW_nearWater) then {
    diag_log format ["[ZCP] No water detected near position %1", _ZCP_NW_position];
};

_ZCP_NW_nearWater

/*
private["_result","_position","_radius"];
_result 	= false;
_position 	= _this select 0;
_radius		= _this select 1;
for "_i" from 0 to 359 step 45 do {
	_position = [(_position select 0) + (sin(_i)*_radius), (_position select 1) + (cos(_i)*_radius)];
	if (surfaceIsWater _position) exitWith {
		_result = true; 
	};
};
_result
*/