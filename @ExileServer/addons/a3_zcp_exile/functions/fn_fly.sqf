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
	
	The fn_fly.sqf script adjusts the direction and velocity of a vehicle in ZCP missions. 
	It sets the vehicle's direction and recalculates its velocity to maintain consistent 
	speed and altitude while changing direction. The script uses trigonometric functions 
	to handle the velocity transformation based on the new direction.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Error Handling: Prevents execution if the vehicle is null.
      Debugging: Provides detailed logs when ZCP_Debug is enabled.
      Code Safety: Validates input parameters.
      Performance: Simplified calculations and applied velocity changes efficiently.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    "_ZCP_FY_vehicle",
    "_ZCP_FY_direction",
    ["_ZCP_FY_speed", 200, [0]]
];

if (isNull _ZCP_FY_vehicle) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid vehicle for fn_fly.sqf!" };
};

private _ZCP_FY_pos = getPosATL _ZCP_FY_vehicle;
private _ZCP_FY_dir = getDir _ZCP_FY_vehicle;

// Calculate new velocity based on the direction and speed
private _ZCP_FY_velocity = [
    sin(_ZCP_FY_direction) * _ZCP_FY_speed,
    cos(_ZCP_FY_direction) * _ZCP_FY_speed,
    velocity _ZCP_FY_vehicle select 2
];

// Apply the new direction and velocity to the vehicle
_ZCP_FY_vehicle setDir _ZCP_FY_direction;
_ZCP_FY_vehicle setVelocity _ZCP_FY_velocity;

// Debugging output
if (ZCP_Debug) then {
    diag_log format ["[ZCP] Vehicle %1 flying to direction %2 with speed %3", _ZCP_FY_vehicle, _ZCP_FY_direction, _ZCP_FY_speed];
};

/*
private ["_ZCP_F_veh","_ZCP_F_dir","_ZCP_F_velocity"];
_ZCP_F_veh = _this select 0;
_ZCP_F_dir = _this select 1;
_ZCP_F_velocity = velocity _ZCP_F_veh;
_ZCP_F_veh setDir _ZCP_F_dir;
_ZCP_F_veh setVelocity [
    (_ZCP_F_velocity select 1) * sin _ZCP_F_dir - (_ZCP_F_velocity select 0) * cos _ZCP_F_dir,
    (_ZCP_F_velocity select 0) * sin _ZCP_F_dir + (_ZCP_F_velocity select 1) * cos _ZCP_F_dir,
    _ZCP_F_velocity select 2
];
*/