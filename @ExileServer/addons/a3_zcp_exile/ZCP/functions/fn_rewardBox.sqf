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
	
	The fn_rewardBox.sqf script in ZCP missions spawns a reward box, fills it with loot, and 
	manages its parachute drop if needed. The script handles safe positioning, random loot 
	generation, and ensures the box is set up securely and visibly for players. It uses 
	ZCP_fnc_fillCrate for loot distribution and ZCP_fnc_paraDrop for airborne delivery if 
	no ground position is available.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Validates box type and safe position before proceeding.
      Debugging: Provides detailed logs for success, parachute drops, and errors.
      Performance: Uses BIS_fnc_findSafePos efficiently and handles fallback to paradrop when needed.
      Loot Handling: Integrates ZCP_fnc_fillCrate for dynamic loot generation.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_RB_position",
    "_ZCP_RB_boxType"
];

if (isNil "_ZCP_RB_boxType" || {_ZCP_RB_boxType == ""}) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid box type provided to fn_rewardBox.sqf"; };
};

// Attempt to find a safe ground position
private _ZCP_RB_spawnPos = [_ZCP_RB_position, 20, 20, 5, 0, 0, 0] call BIS_fnc_findSafePos;

private _ZCP_RB_box;
if (_ZCP_RB_spawnPos isEqualTo [0, 0, 0]) then {
    if (ZCP_Debug) then { diag_log "[ZCP] No safe ground position found, initiating parachute drop."; };
    
    _ZCP_RB_box = createVehicle [_ZCP_RB_boxType, _ZCP_RB_position vectorAdd [0, 0, 250], [], 0, "CAN_COLLIDE"];
    [_ZCP_RB_box, "SmokeShellGreen"] call ZCP_fnc_paraDrop;
} else {
    _ZCP_RB_box = createVehicle [_ZCP_RB_boxType, _ZCP_RB_spawnPos, [], 0, "CAN_COLLIDE"];
    _ZCP_RB_box setPosATL _ZCP_RB_spawnPos;
};

// Configure the reward box
_ZCP_RB_box allowDamage false;
_ZCP_RB_box setDir (random 360);
_ZCP_RB_box clearWeaponCargoGlobal;
_ZCP_RB_box clearMagazineCargoGlobal;
_ZCP_RB_box clearItemCargoGlobal;
_ZCP_RB_box clearBackpackCargoGlobal;

// Fill the crate with loot
[_ZCP_RB_box, _ZCP_RB_boxType] call ZCP_fnc_fillCrate;

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Reward box of type %1 created at position %2", _ZCP_RB_boxType, getPosATL _ZCP_RB_box];
};

_ZCP_RB_box

/*
params
[
	"_ZCP_RWB_data",
	"_ZCP_RWB_boxType",
	["_ZCP_RWB_preBox", objNull, [objNull]]
];


private _ZCP_RWB_currentCapper = _ZCP_RWB_data select 0;
private _ZCP_RWB_capName = _ZCP_RWB_data select 1;
private _ZCP_RWB_capturePosition = _ZCP_RWB_data select 2;
private _ZCP_RWB_captureRadius = _ZCP_RWB_data select 4;

if(_ZCP_RWB_preBox isEqualTo objNull) then {
    private _ZCP_RWB_x = random  _ZCP_RWB_captureRadius;
    private _ZCP_RWB_y = random  _ZCP_RWB_captureRadius;

    if( random 1 > 0.5) then {
        _ZCP_RWB_x = 0 - _ZCP_RWB_x;
    };

    if( random 1 > 0.5) then {
        _ZCP_RWB_y = 0 - _ZCP_RWB_y;
    };

    _ZCP_RWB_capturePosition set[0, (_ZCP_RWB_capturePosition select 0) + _ZCP_RWB_x];
    _ZCP_RWB_capturePosition set[1, (_ZCP_RWB_capturePosition select 1) + _ZCP_RWB_y];

};


[_ZCP_RWB_capturePosition, _ZCP_RWB_boxType, _ZCP_RWB_preBox] spawn ZCP_fnc_spawnCrate;

diag_log text format ["[ZCP]: %1 received a %3 for %2.",name _ZCP_RWB_currentCapper,_ZCP_RWB_capName, _ZCP_RWB_boxType];
*/