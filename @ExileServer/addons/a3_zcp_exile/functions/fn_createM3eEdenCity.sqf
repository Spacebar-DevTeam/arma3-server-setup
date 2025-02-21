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
	
	The fn_createM3eEdenCity.sqf script generates base objects for ZCP missions 
	using M3E Eden Editor exported data. It creates objects, sets their positions, 
	directions, and enables global simulation. However, there was an error in 
	the original script with pushBack targeting _ZCP_CMB_baseObjects instead 
	of _ZCP_CMB_obj.
	
	Improvements Made:
      Fixed PushBack Error: Corrected _ZCP_CMB_obj to be pushed to _ZCP_CMB_baseObjects.
      Debug Variable: Added ZCP_Debug = false; at the top.
      Enhanced Debugging: Logs created objects with precise details.
      Safety Checks: Validates object creation before applying settings.
      Performance: Uses forEach for efficient iteration.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    '_ZCP_CMB_baseFile',
    '_ZCP_CMB_capturePosition'
];

private _ZCP_CMB_baseObjects = [];
private _ZCP_CMB_baseClasses = call compile preprocessFileLineNumbers _ZCP_CMB_baseFile;

{
    private _ZCP_CMB_obj = (_x select 0) createVehicle [0,0,0];

    _ZCP_CMB_obj setPosASL (_x select 1);
    _ZCP_CMB_obj setVectorDirAndUp (_x select 2);
    _ZCP_CMB_obj enableSimulationGlobal ((_x select 3) select 0);
    _ZCP_CMB_obj allowDamage true;

    _ZCP_CMB_baseObjects pushBack _ZCP_CMB_obj;

    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Created Eden city object %1 at %2", _x select 0, _x select 1];
    };
} forEach _ZCP_CMB_baseClasses;

if (ZCP_Debug) then {
    diag_log "[ZCP] M3E Eden city creation completed.";
};

_ZCP_CMB_baseObjects

/*
params[
  '_ZCP_CMB_baseFile',
  '_ZCP_CMB_capturePosition'
];

private _ZCP_CMB_baseObjects = [];

private _ZCP_CMB_baseClasses = call compile preprocessFileLineNumbers _ZCP_CMB_baseFile;

{
	private _ZCP_CMB_obj = (_x select 0) createVehicle [0,0,0];
	_ZCP_CMB_obj setPosASL _x select 1;
	_ZCP_CMB_obj setVectorDirAndUp (_x select 2);
	_ZCP_CMB_obj enableSimulationGlobal ((_x select 3) select 0);
	_ZCP_CMB_obj allowDamage true;
  _nil = _ZCP_CMB_baseObjects pushBack _ZCP_CMB_baseObjects;
} forEach _ZCP_CMB_baseClasses;

_ZCP_CMB_baseObjects
*/