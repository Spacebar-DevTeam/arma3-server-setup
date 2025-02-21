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
	
	The fn_selectMagazine.sqf script retrieves the appropriate magazine type for a given 
	weapon class in ZCP missions. It uses CfgWeapons configuration to extract available 
	magazines for the specified weapon and returns the first valid magazine found. The 
	script ensures that the weapon class has compatible magazines and handles empty 
	results gracefully.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Input Validation: Ensures weapon class is valid before accessing configFile.
      Debugging: Provides detailed logs for success and error scenarios.
      Performance: Simplified selection logic with a conditional statement.
      Code Safety: Returns an empty string if no magazines are found.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params ["_ZCP_SM_weaponClass"];

if (isNil "_ZCP_SM_weaponClass" || {_ZCP_SM_weaponClass == ""}) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid weapon class provided to fn_selectMagazine.sqf"; };
    "";
};

// Retrieve magazine array from CfgWeapons
private _ZCP_SM_magazines = getArray (configFile >> "CfgWeapons" >> _ZCP_SM_weaponClass >> "magazines");

private _ZCP_SM_selectedMagazine = if (count _ZCP_SM_magazines > 0) then {
    _ZCP_SM_magazines select 0
} else {
    ""
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Selected magazine %1 for weapon %2", _ZCP_SM_selectedMagazine, _ZCP_SM_weaponClass];
};

_ZCP_SM_selectedMagazine

/*
	DMS_fnc_selectMagazine
	Created by eraser1

	Usage:
	_weaponClassName call DMS_fnc_selectMagazine;

	Apply magazine type filters if needed



private["_result","_ammoArray"];

_result 	= "";
_ammoArray 	= getArray (configFile >> "CfgWeapons" >> _this >> "magazines");

if (count _ammoArray > 0) then
{
	_result = _ammoArray select 0;
};

_result
*/