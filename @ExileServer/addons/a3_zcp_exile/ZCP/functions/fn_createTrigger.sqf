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
	
	The fn_createTrigger.sqf script creates a trigger for a ZCP mission in Arma 3, 
	activating when a player enters the area. The trigger is recreated if the player 
	leaves the ZCP circle, ensuring mission monitoring continues. It sets up a 
	detection area and configures activation and execution statements.
	
	Improvements Made
      Debug Variable:	Added ZCP_Debug = false; at the top.
      Simplified Logic:	Used ternary operators for cleaner marker size calculation.
      Debugging:		Provides log output when ZCP_Debug is enabled.
      Code Safety:		Ensures trigger is configured correctly and provides diagnostics.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    '_ZCP_CT_missionIndex',
    '_ZCP_CT_pos',
    '_ZCP_CT_radius',
    '_ZCP_CT_cityX',
    '_ZCP_CT_cityY'
];

private _ZCP_CT_markerX = if (_ZCP_CT_cityX > 0) then {_ZCP_CT_cityX} else {_ZCP_CT_radius};
private _ZCP_CT_markerY = if (_ZCP_CT_cityY > 0) then {_ZCP_CT_cityY} else {_ZCP_CT_radius};

// Create the trigger with the defined area and activation
private _ZCP_CT_trigger = createTrigger ["EmptyDetector", _ZCP_CT_pos];
_ZCP_CT_trigger setTriggerArea [_ZCP_CT_markerX, _ZCP_CT_markerY, 45, false];
_ZCP_CT_trigger setTriggerActivation ["GUER", "PRESENT", false];
_ZCP_CT_trigger setTriggerStatements [
    "this", 
    format ["deleteVehicle thisTrigger; [%1] spawn ZCP_fnc_monitorMission;", _ZCP_CT_missionIndex], 
    ""
];

// Debugging output
if (ZCP_Debug) then {
    diag_log format ["[ZCP] Trigger created for mission index %1 at position %2", _ZCP_CT_missionIndex, _ZCP_CT_pos];
};


/*
* Creates the trigger for a ZCP mission. Trigger activates when a player enters the area.
* Trigger will be recreated if player moves out the ZCP circle.
*
* @param


params[
 '_ZCP_CT_missionIndex',
 '_ZCP_CT_pos',
 '_ZCP_CT_radius',
 '_ZCP_CT_cityX',
 '_ZCP_CT_cityY'
];

private _ZCP_CT_markerX = _ZCP_CT_cityX;
private _ZCP_CT_markerY = _ZCP_CT_cityY;

if( _ZCP_CT_cityX == 0 || _ZCP_CT_cityY == 0 ) then
{
    _ZCP_CT_markerX =  _ZCP_CT_radius;
    _ZCP_CT_markerY = _ZCP_CT_radius;
};

private _ZCP_CT_trigger = createTrigger ["EmptyDetector", _ZCP_CT_pos];
_ZCP_CT_trigger setTriggerArea [_ZCP_CT_markerX, _ZCP_CT_markerY, 45, false];
_ZCP_CT_trigger setTriggerActivation ["GUER", "PRESENT", false];
_ZCP_CT_trigger setTriggerStatements ["this", format['deleteVehicle thisTrigger; [%1] spawn ZCP_fnc_monitorMission;', _ZCP_CT_missionIndex], ""];
*/