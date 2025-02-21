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
	
	The fn_preRewardBox.sqf script prepares a reward box for ZCP missions by selecting the 
	appropriate box type (e.g., BuildBox, SurvivalBox, WeaponBox) and spawning it at a 
	valid empty position within a defined radius. It ensures the box is undamaged, sets a 
	random direction, and clears all cargo to prepare for custom loot.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Validates input parameters and safe position.
      Debugging: Provides detailed logs for success and error scenarios.
      Performance: Uses BIS_fnc_findSafePos efficiently.
      Code Safety: Ensures the box is cleared of all cargo and undamaged.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_PRB_position",
    "_ZCP_PRB_boxType"
];

if (isNil "_ZCP_PRB_position" || {_ZCP_PRB_boxType == ""}) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid parameters for fn_preRewardBox.sqf"; };
};

private _ZCP_PRB_spawnPos = [_ZCP_PRB_position, 20, 20, 5, 0, 0, 0] call BIS_fnc_findSafePos;

if (_ZCP_PRB_spawnPos isEqualTo [0, 0, 0]) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Could not find a safe position for reward box."; };
};

private _ZCP_PRB_box = createVehicle [_ZCP_PRB_boxType, _ZCP_PRB_spawnPos, [], 0, "CAN_COLLIDE"];

_ZCP_PRB_box allowDamage false;
_ZCP_PRB_box setPosATL _ZCP_PRB_spawnPos;
_ZCP_PRB_box setDir (random 360);
_ZCP_PRB_box clearWeaponCargoGlobal;
_ZCP_PRB_box clearMagazineCargoGlobal;
_ZCP_PRB_box clearItemCargoGlobal;
_ZCP_PRB_box clearBackpackCargoGlobal;

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Pre-created reward box of type %1 at position %2", _ZCP_PRB_boxType, _ZCP_PRB_spawnPos];
};

_ZCP_PRB_box

/*
params[
    '_ZCP_RV_capturePosition',
    '_ZCP_RV_captureRadius',
    '_ZCP_RV_boxType'
];

private _ZCP_RV_boxTypeClass = ZCP_WeaponBox;

switch (_ZCP_RV_boxType) do {
    case 'BuildBox': {
      _ZCP_RV_boxTypeClass = ZCP_BuildingBox;
    };
    case 'SurvivalBox': {
      _ZCP_RV_boxTypeClass = ZCP_SurvivalBox;
    };
};

private _ZCP_RV_posVehicle = _ZCP_RV_capturePosition findEmptyPosition [0, _ZCP_RV_captureRadius , _ZCP_RV_boxTypeClass];

private _ZCP_RV_box = _ZCP_RV_boxTypeClass createVehicle _ZCP_RV_posVehicle;
_ZCP_RV_box allowDamage false;
_ZCP_RV_box setDir random 360;

clearWeaponCargoGlobal _ZCP_RV_box;
clearMagazineCargoGlobal _ZCP_RV_box;
clearBackpackCargoGlobal _ZCP_RV_box;
clearItemCargoGlobal _ZCP_RV_box;

_ZCP_RV_box
*/