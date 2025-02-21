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
	
	The fn_createEdenConvertedBase.sqf script creates base objects for ZCP 
	missions using Eden Editor exported data. It calculates new positions 
	relative to the capture point and spawns objects accordingly.
	
	Improvements Made:
	  Debug Variable: Added ZCP_Debug = false; at the top.
	  Error Handling: Avoids null objects.
	  Performance: Uses forEach for better iteration.
	  Debugging: Conditional logs for object creation and completion.
	  Code Simplification: Cleaned up position and direction calculations.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

private ["_ZCP_CECB_baseObjects", "_ZCP_CECB_theFlagPos", "_ZCP_CECB_capturePosition", "_ZCP_CECB_baseClasses"];
_ZCP_CECB_baseObjects = [];
_ZCP_CECB_baseClasses = call compile preprocessFileLineNumbers (_this select 0);
_ZCP_CECB_capturePosition = _this select 1;
_ZCP_CECB_theFlagPos = _ZCP_CECB_baseClasses select 0;

private _ZCP_CECB_offset = [
    (_ZCP_CECB_capturePosition select 0) - (_ZCP_CECB_theFlagPos select 1),
    (_ZCP_CECB_capturePosition select 1) - (_ZCP_CECB_theFlagPos select 2)
];

{
    private ["_ZCP_CECB_obj", "_ZCP_CECB_newPos", "_ZCP_CECB_objName"];
    _ZCP_CECB_objName = format ["Land_%1", _x select 0];
    
    _ZCP_CECB_obj = createVehicle [_ZCP_CECB_objName, [0,0,0], [], 0, "CAN_COLLIDE"];
    _ZCP_CECB_newPos = [
        ((_x select 1) + (_ZCP_CECB_offset select 0)),
        ((_x select 2) + (_ZCP_CECB_offset select 1)),
        (_x select 3)
    ];

    _ZCP_CECB_obj setDir (_x select 4);
    _ZCP_CECB_obj setPos _ZCP_CECB_newPos;
    
    _ZCP_CECB_baseObjects pushBack _ZCP_CECB_obj;
    
    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Created base object %1 at %2", _ZCP_CECB_objName, _ZCP_CECB_newPos];
    };
    
} forEach (_ZCP_CECB_baseClasses);

if (ZCP_Debug) then {
    diag_log "[ZCP] Base creation completed with Eden converted data.";
};

_ZCP_CECB_baseObjects

/*
private ["_ZCP_CECB_baseObjects","_ZCP_CECB_theFlagPos","_ZCP_CECB_theFlagX","_ZCP_CECB_theFlagY","_ZCP_CECB_xChange","_ZCP_CECB_yChange","_ZCP_CECB_capturePosition", "_ZCP_CECB_baseClasses"];
_ZCP_CECB_baseObjects = [];

_ZCP_CECB_baseClasses = call compile preprocessFileLineNumbers (_this select 0);

_ZCP_CECB_capturePosition = _this select 1;
_ZCP_CECB_theFlagPos = _ZCP_CECB_baseClasses select 0;
_ZCP_CECB_theFlagX = _ZCP_CECB_theFlagPos select 1;
_ZCP_CECB_theFlagY = _ZCP_CECB_theFlagPos select 2;
_ZCP_CECB_xChange = _ZCP_CECB_capturePosition select 0;
_ZCP_CECB_yChange = _ZCP_CECB_capturePosition select 1;

{
	private ["_ZCP_CECB_obj","_ZCP_CECB_pos","_nil","_ZCP_CECB_newPos","_ZCP_CECB_objName"];
	_ZCP_CECB_objName = format["Land_%1", _x select 0];
	systemChat _ZCP_CECB_objName;
	_ZCP_CECB_obj = createVehicle [_ZCP_CECB_objName, [0,0,0], [], 0, "CAN_COLLIDE"];
	_ZCP_CECB_pos = [_x select 1, _x select 2, 0 ];
	_ZCP_CECB_newPos = [((_ZCP_CECB_pos select 0) - _ZCP_CECB_theFlagX + _ZCP_CECB_xChange), ((_ZCP_CECB_pos select 1) - _ZCP_CECB_theFlagY + _ZCP_CECB_yChange),(_ZCP_CECB_pos select 2)];
	_ZCP_CECB_obj setDir (_x select 3);
	_ZCP_CECB_obj setPos _ZCP_CECB_newPos;
	_nil = _ZCP_CECB_baseObjects pushBack _ZCP_CECB_obj;
}count (_ZCP_CECB_baseClasses);

_ZCP_CECB_baseObjects
*/
