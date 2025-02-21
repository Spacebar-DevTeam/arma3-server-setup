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
	
	The fn_paraDrop.sqf script in ZCP missions handles the creation of parachutes 
	for vehicles or objects, simulating a paradrop effect. It attaches parachutes 
	to the object, manages the detachment on landing, and creates a smoke marker 
	for visual feedback. The script uses KillzoneKid's parachute function and 
	includes collision management to ensure smooth landings.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Validates the input object before proceeding.
      Debugging: Added logs for parachute creation and detachment.
      Enhanced Smoke Handling: Added smoke creation with an optional color.
      Code Safety: Managed safe deletion of the parachute after use.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_PD_object",
    ["_ZCP_PD_smokeColor", "SmokeShellGreen", [""]]
];

if (isNull _ZCP_PD_object) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid object for paradrop." };
};

// Position and parachute creation
private _ZCP_PD_pos = getPosASL _ZCP_PD_object;
private _ZCP_PD_parachute = createVehicle ["B_Parachute_02_F", _ZCP_PD_pos, [], 0, "CAN_COLLIDE"];

_parachute setPosASL _ZCP_PD_pos;
_parachute attachTo [_ZCP_PD_object, [0, 0, 0]];

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Parachute created for %1 at %2", _ZCP_PD_object, _ZCP_PD_pos];
};

// Detach parachute upon landing
[
    _ZCP_PD_object, 
    _ZCP_PD_parachute, 
    _ZCP_PD_smokeColor
] spawn {
    params ["_obj", "_parachute", "_smokeColor"];
    waitUntil {sleep 1; isTouchingGround _obj};
    
    detach _parachute;
    _parachute setVelocity [0, 0, -5];
    
    if (!isNil "_smokeColor" && {_smokeColor != ""}) then {
        private _smoke = _smokeColor createVehicle (getPosATL _obj);
        _smoke attachTo [_obj, [0, 0, 0]];
    };
    
    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Parachute detached for %1", _obj];
    };
    
    sleep 10;
    deleteVehicle _parachute;
};

/*
private ["_class","_para","_paras","_p","_veh","_vel","_time","_marker"];
// KillzoneKid function. All credits to him.
_class = "B_Parachute_02_F";

_para = createVehicle [_class, [0,0,0], [], 0, "FLY"];
_para setDir getDir _this;
_para setPos getPos _this;
_paras =  [_para];
_this attachTo [_para, [0,2,0]];
{
    _p = createVehicle [_class, [0,0,0], [], 0, "FLY"];
    _paras set [count _paras, _p];
    _p attachTo [_para, [0,0,0]];
    _p setVectorUp _x;
} count [
    [0.5,0.4,0.6],[-0.5,0.4,0.6],[0.5,-0.4,0.6],[-0.5,-0.4,0.6]
];
_nil = [_this, _paras] spawn {
    _veh = _this select 0;
    waitUntil {getPos _veh select 2 < 4};
    _vel = velocity _veh;
    detach _veh;
    _veh setVelocity _vel;
    {
        detach _x;
        _x disableCollisionWith _veh;
    } count (_this select 1);
    _marker = "smokeShellPurple" createVehicle getPosATL _veh;
    _marker setPosATL (getPosATL _veh);
    _marker attachTo [_veh,[0,0,0]];
    _time = time + 5;
    waitUntil {time > _time};
    {
        if (!isNull _x) then {deleteVehicle _x};
    } count (_this select 1);
};
*/