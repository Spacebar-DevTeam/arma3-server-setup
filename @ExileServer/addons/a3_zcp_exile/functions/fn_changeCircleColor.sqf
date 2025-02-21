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

	Improvements Made:
	  Error Handling: Added isNull check to avoid null objects.
	  Performance: Replaced count with forEach for direct iteration.
	  Debugging: Added a conditional log for debugging.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

private ["_circleObjects", "_colorType", "_newColor"];

_circleObjects = _this select 0;
_colorType = _this select 1;

// Default to neutral color
_newColor = ZCP_circleNeutralColor;

// Set color based on the mission state
switch (_colorType) do {
    case "capping": {_newColor = ZCP_circleCappingColor;};
    case "contested": {_newColor = ZCP_circleContestedColor;};
};

// Apply the color change efficiently
{
    if (!isNull _x) then {
        _x enableSimulation true;
        _x setObjectTextureGlobal [0, _newColor];
        _x enableSimulation false;
    };
} forEach _circleObjects;

// Debugging log (optional)
if (ZCP_Debug) then {
    diag_log format ["[ZCP] Circle color changed to %1 for state %2", _newColor, _colorType];
};

/*
private ['_ZCP_CCC_colorType','_ZCP_CCC_circleObjects','_ZCP_CCC_color'];
_ZCP_CCC_circleObjects = _this select 0;
_ZCP_CCC_colorType = _this select 1;

_ZCP_CCC_color = ZCP_circleNeutralColor;

switch (_ZCP_CCC_colorType) do {
    case ("capping"): {
        _ZCP_CCC_color = ZCP_circleCappingColor;
    };
    case ("contested"): {
        _ZCP_CCC_color = ZCP_circleContestedColor;
    };
};

{
  _x enableSimulation true;
  _x setObjectTextureGlobal [0,_ZCP_CCC_color];
  _x enableSimulation false;
}count _ZCP_CCC_circleObjects;
*/