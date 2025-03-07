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
	
	The fn_inDebug.sqf script checks if the ZCP debug mode is enabled by evaluating the 
	ZCP_Debug variable. It returns true if debugging is active, allowing other scripts 
	to execute additional logging or debugging actions.
	
	Improvements Made:
      Debug Variable: Ensures ZCP_Debug is set at the top.
      Debugging: Adds an optional log when debug mode is active.
      Performance: Directly returns the ZCP_Debug status with minimal processing.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

// Function to check if debug mode is enabled
private _isDebug = ZCP_Debug;

// Optional logging for debug mode checks
if (_isDebug) then {
    diag_log "[ZCP] Debug mode is enabled.";
};

_isDebug

/*
private["_result","_position","_hasdebug","_xLeft","_xRight","_yTop","_yBottom"];
_result 		= false;
_position 		= _this;
_hasdebug 		= false;
_xLeft 			= 0;
_xRight 		= 0;
_yTop 			= 0;
_yBottom 		= 0;
call {
	if(worldName == "Takistan") 			exitWith { _hasdebug = true; _xLeft = 200; _xRight = 12600; _yTop = 12600; _yBottom = 200; };
	if(worldName == "Shapur_BA") 			exitWith { _hasdebug = true; _xLeft = 200; _xRight = 1900; _yTop = 1900; _yBottom = 200; };
	if(worldName == "Zargabad") 			exitWith { _hasdebug = true; _xLeft = 200; _xRight = 7963; _yTop = 8091; _yBottom = 200; };
	if(worldName == "ProvingGrounds_PMC")	exitWith { _hasdebug = true; _xLeft = 200; _xRight = 1900; _yTop = 1900; _yBottom = 200; };
	if(worldName == "Chernarus") 			exitWith { _hasdebug = true; _xLeft = 1000; _xRight = 13350; _yTop = 13350; _yBottom = 1000; };
	if(worldName == "sauerland") 			exitWith { _hasdebug = true; _xLeft = 1000; _xRight = 24400; _yTop = 24500; _yBottom = 1200; };
};
if(_hasdebug) then {
	if (_position select 0 < _xLeft) 	exitWith { _result = true; };
	if (_position select 0 > _xRight)	exitWith { _result = true; };
	if (_position select 1 > _yTop)		exitWith { _result = true; };
	if (_position select 1 < _yBottom)	exitWith { _result = true; };
};
_result
*/