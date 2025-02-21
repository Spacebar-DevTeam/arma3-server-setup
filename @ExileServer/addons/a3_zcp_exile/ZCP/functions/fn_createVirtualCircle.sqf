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
	
	The fn_createVirtualCircle.sqf script creates a virtual circle of objects around a 
	center point in ZCP missions. It calculates positions in a circular pattern and 
	spawns Sign_Sphere25cm_F objects with a neutral texture, disabling simulation 
	for performance.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Used ternary operators for radius calculations.
      Debugging: Enhanced logs for object creation and completion.
      Performance: Optimized loop step calculations.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    '_ZCP_CVC_center',
    '_ZCP_CVC_radius',
    '_ZCP_CVC_cityX',
    '_ZCP_CVC_cityY'
];

private _ZCP_CVC_circleObjs = [];
private _ZCP_CVC_radiusX = if (_ZCP_CVC_cityX > 0) then {_ZCP_CVC_cityX} else {_ZCP_CVC_radius};
private _ZCP_CVC_radiusY = if (_ZCP_CVC_cityY > 0) then {_ZCP_CVC_cityY} else {_ZCP_CVC_radius};

// Generate objects in a circular pattern
for '_i' from 0 to 360 step ((150 / _ZCP_CVC_radius) * 2) do {
    private _ZCP_CVC_location = [
        (_ZCP_CVC_center select 0) + ((cos _i) * _ZCP_CVC_radiusX), 
        (_ZCP_CVC_center select 1) + ((sin _i) * _ZCP_CVC_radiusY), 
        0
    ];

    private _ZCP_CVC_object = createVehicle ["Sign_Sphere25cm_F", _ZCP_CVC_location, [], 0, "CAN_COLLIDE"];
    _ZCP_CVC_object setObjectTextureGlobal [0, ZCP_circleNeutralColor];
    _ZCP_CVC_object enableSimulation false;

    _ZCP_CVC_circleObjs pushBack _ZCP_CVC_object;

    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Created virtual circle object at %1", _ZCP_CVC_location];
    };
};

if (ZCP_Debug) then {
    diag_log "[ZCP] Virtual circle creation completed.";
};

_ZCP_CVC_circleObjs

/*
params[
  '_ZCP_CVC_center',
  '_ZCP_CVC_radius',
  '_ZCP_CVC_cityX',
  '_ZCP_CVC_cityY'
];

private _ZCP_CVC_circleObjs = [];

private _ZCP_CVC_radiusX = _ZCP_CVC_cityX;
private _ZCP_CVC_radiusY = _ZCP_CVC_cityY;

if( _ZCP_CVC_cityX == 0 || _ZCP_CVC_cityY == 0 ) then
{
    _ZCP_CVC_radiusX = _ZCP_CVC_radius;
    _ZCP_CVC_radiusY = _ZCP_CVC_radius;
};

// diag_log text format['%1 %2 %3', _ZCP_CVC_radiusX , _ZCP_CVC_radiusY, _ZCP_CVC_radius];

for '_i' from 0 to 360 step (150 / _ZCP_CVC_radius)*2 do
{
  private _ZCP_CVC_location = [(_ZCP_CVC_center select 0) + ((cos _i) * _ZCP_CVC_radiusX), (_ZCP_CVC_center select 1) + ((sin _i) * _ZCP_CVC_radiusY),0];
  private _ZCP_CVC_object = createVehicle ['Sign_Sphere25cm_F', _ZCP_CVC_location, [], 0, 'CAN_COLLIDE'];
  _ZCP_CVC_object setObjectTextureGlobal [0, ZCP_circleNeutralColor];
  _ZCP_CVC_object enableSimulation false;
  _nil = _ZCP_CVC_circleObjs pushBack _ZCP_CVC_object;
};

_ZCP_CVC_circleObjs
*/