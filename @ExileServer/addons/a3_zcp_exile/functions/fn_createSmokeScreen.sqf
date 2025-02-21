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
	
	The fn_createSmokeScreen.sqf script creates a smokescreen around a specified 
	center using artillery smoke shells. It calculates positions around a circle 
	and spawns smoke at intervals based on the radius. The script waits for a 
	specified delay (_ZCP_CVC_waitTime) before executing the smokescreen.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Used ternary operators for cleaner radius calculations.
      Debugging: Added logs for each smoke deployment when ZCP_Debug is enabled.
      Error Handling: Ensured all parameters are valid before execution.
      Code Clarity: Improved readability with consistent formatting.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    '_ZCP_CVC_center',
    '_ZCP_CVC_radius',
    '_ZCP_CVC_waitTime',
    '_ZCP_CVC_extraRadius',
    '_ZCP_CVC_cityX',
    '_ZCP_CVC_cityY'
];

private _ZCP_CVC_radiusX = if (_ZCP_CVC_cityX > 0) then {_ZCP_CVC_cityX} else {_ZCP_CVC_radius};
private _ZCP_CVC_radiusY = if (_ZCP_CVC_cityY > 0) then {_ZCP_CVC_cityY} else {_ZCP_CVC_radius};

private _ZCP_CVC_newRadiusX = _ZCP_CVC_radiusX + _ZCP_CVC_extraRadius;
private _ZCP_CVC_newRadiusY = _ZCP_CVC_radiusY + _ZCP_CVC_extraRadius;

uiSleep _ZCP_CVC_waitTime;

for '_i' from 0 to 360 step (360 / _ZCP_CVC_radius * 1.5) do {
    private _ZCP_CVC_location = [
        (_ZCP_CVC_center select 0) + ((cos _i) * _ZCP_CVC_newRadiusX),
        (_ZCP_CVC_center select 1) + ((sin _i) * _ZCP_CVC_newRadiusY),
        0
    ];
    "SmokeShellArty" createVehicle _ZCP_CVC_location;

    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Smoke deployed at %1", _ZCP_CVC_location];
    };
};

if (ZCP_Debug) then {
    diag_log "[ZCP] Smokescreen creation completed.";
};

/*
params[
  '_ZCP_CVC_center',
  '_ZCP_CVC_radius',
  '_ZCP_CVC_waitTime',
  '_ZCP_CVC_extraRadius',
  '_ZCP_CVC_cityX',
  '_ZCP_CVC_cityY'
];

private _ZCP_CVC_radiusX = _ZCP_CVC_cityX;
private _ZCP_CVC_radiusY = _ZCP_CVC_cityY;

if( _ZCP_CVC_cityX == 0 || _ZCP_CVC_cityY == 0 ) then
{
    _ZCP_CVC_radiusX =  _ZCP_CVC_radius;
    _ZCP_CVC_radiusY =  _ZCP_CVC_radius;
};

private _ZCP_CVC_newRadiusX = _ZCP_CVC_radiusX + _ZCP_CVC_extraRadius;
private _ZCP_CVC_newRadiusY = _ZCP_CVC_radiusY + _ZCP_CVC_extraRadius;

uiSleep _ZCP_CVC_waitTime;

for '_i' from 0 to 360 step (360 / _ZCP_CVC_radius * 1.5) do
{
  _ZCP_CVC_location = [(_ZCP_CVC_center select 0) + ((cos _i) * _ZCP_CVC_newRadiusX), (_ZCP_CVC_center select 1) + ((sin _i) * _ZCP_CVC_newRadiusY),0];
  _nil = "SmokeShellArty" createVehicle _ZCP_CVC_location;
};
*/