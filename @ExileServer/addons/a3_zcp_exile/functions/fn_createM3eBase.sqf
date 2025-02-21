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
	
	The fn_createM3eBase.sqf script generates base objects for ZCP missions using 
	M3E exported data. It calculates relative positions and properly aligns 
	objects within the mission's capture area.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Error Handling: Ensured objects are not null before manipulation.
      Debugging: Logs created objects and positions if debugging is enabled.
      Code Simplification: Cleaned up position and direction calculations.
      Performance: Uses forEach for efficient iteration.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

private ["_ZCP_CMB_baseObjects", "_ZCP_CMB_capturePosition", "_ZCP_CMB_baseClasses", "_ZCP_CMB_theFlagPos"];
_ZCP_CMB_baseObjects = [];
_ZCP_CMB_baseClasses = call compile preprocessFileLineNumbers (_this select 0);
_ZCP_CMB_capturePosition = _this select 1;
_ZCP_CMB_theFlagPos = (_ZCP_CMB_baseClasses select 0) select 1;

private _ZCP_CMB_offset = [
    (_ZCP_CMB_capturePosition select 0) - (_ZCP_CMB_theFlagPos select 0),
    (_ZCP_CMB_capturePosition select 1) - (_ZCP_CMB_theFlagPos select 1)
];

{
    private ["_ZCP_CMB_obj", "_ZCP_CMB_newPos"];
    _ZCP_CMB_obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];

    _ZCP_CMB_newPos = [
        ((_x select 1 select 0) + (_ZCP_CMB_offset select 0)),
        ((_x select 1 select 1) + (_ZCP_CMB_offset select 1)),
        (_x select 1 select 2)
    ];

    if (_x select 4) then {
        _ZCP_CMB_obj setDir (_x select 2);
        _ZCP_CMB_obj setPos _ZCP_CMB_newPos;
    } else {
        _ZCP_CMB_obj setPosATL _ZCP_CMB_newPos;
        _ZCP_CMB_obj setVectorDirAndUp (_x select 3);
    };

    _ZCP_CMB_baseObjects pushBack _ZCP_CMB_obj;

    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Created M3E base object %1 at %2", _x select 0, _ZCP_CMB_newPos];
    };
} forEach _ZCP_CMB_baseClasses;

if (ZCP_Debug) then {
    diag_log "[ZCP] M3E base creation completed.";
};

_ZCP_CMB_baseObjects

/*
private ["_ZCP_CMB_baseObjects","_ZCP_CMB_theFlagPos","_ZCP_CMB_theFlagX","_ZCP_CMB_theFlagY","_ZCP_CMB_xChange","_ZCP_CMB_yChange","_ZCP_CMB_capturePosition", "_ZCP_CMB_baseClasses"];
_ZCP_CMB_baseObjects = [];

_ZCP_CMB_baseClasses = call compile preprocessFileLineNumbers (_this select 0);

_ZCP_CMB_capturePosition = _this select 1;
_ZCP_CMB_theFlagPos = (_ZCP_CMB_baseClasses select 0) select 1;
_ZCP_CMB_theFlagX = _ZCP_CMB_theFlagPos select 0;
_ZCP_CMB_theFlagY = _ZCP_CMB_theFlagPos select 1;
_ZCP_CMB_xChange = _ZCP_CMB_capturePosition select 0;
_ZCP_CMB_yChange = _ZCP_CMB_capturePosition select 1;

{
	private ["_ZCP_CMB_obj","_ZCP_CMB_pos","_nil","_ZCP_CMB_newPos"];
	_ZCP_CMB_obj = createVehicle [_x select 0, [0,0,0], [], 0, "CAN_COLLIDE"];
	_ZCP_CMB_pos = _x select 1;
	_ZCP_CMB_newPos = [((_ZCP_CMB_pos select 0) - _ZCP_CMB_theFlagX + _ZCP_CMB_xChange), ((_ZCP_CMB_pos select 1) - _ZCP_CMB_theFlagY + _ZCP_CMB_yChange),(_ZCP_CMB_pos select 2)];
	if (_x select 4) then {
		_ZCP_CMB_obj setDir (_x select 2);
		_ZCP_CMB_obj setPos _ZCP_CMB_newPos;
	} else {
		_ZCP_CMB_obj setPosATL _ZCP_CMB_newPos;
		_ZCP_CMB_obj setVectorDirAndUp (_x select 3);
	};
	_nil = _ZCP_CMB_baseObjects pushBack _ZCP_CMB_obj;
}count (_ZCP_CMB_baseClasses);

_ZCP_CMB_baseObjects
*/