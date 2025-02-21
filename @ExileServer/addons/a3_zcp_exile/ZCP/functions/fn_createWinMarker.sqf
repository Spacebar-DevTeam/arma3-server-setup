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
	
	The fn_createWinMarker.sqf script creates a "win" marker on the map when a ZCP mission 
	is completed. It removes previous markers, sets a new "hd_destroy" marker type with 
	the ZCP background color, and displays a translated message. The marker is 
	automatically deleted after a set time using the 
	ExileServer_system_thread_addTask function.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Streamlined marker creation and deletion.
      Debugging: Added detailed log output when ZCP_Debug is enabled.
      Code Clarity: Consistent and clean parameter usage.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    "_ZCP_CWM_captureObject",
    "_ZCP_CWM_previousMarkers",
    "_ZCP_CWM_position"
];

[_ZCP_CWM_previousMarkers] call ZCP_fnc_removeMarker;

if (ZCP_MissionMarkerWinDotTime > 0) then {
    private _ZCP_CWM_mission = _ZCP_CWM_captureObject select 3;

    private _ZCP_CWM_attentionMarker = createMarker [
        format ["%1capped%2", _ZCP_CWM_mission, random 10], 
        _ZCP_CWM_position
    ];

    _ZCP_CWM_attentionMarker setMarkerType "hd_destroy";
    _ZCP_CWM_attentionMarker setMarkerColor ZCP_BackgroundColor;
    _ZCP_CWM_attentionMarker setMarkerText ([8] call ZCP_fnc_translate);

    [ZCP_MissionMarkerWinDotTime, {deleteMarker _this;}, _ZCP_CWM_attentionMarker, false] 
        call ExileServer_system_thread_addTask;

    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Win marker created for mission %1 at %2", _ZCP_CWM_mission, _ZCP_CWM_position];
    };
};

/*
private["_ZCP_CWM_position","_ZCP_CWM_mission","_ZCP_CWM_attentionMarker","_ZCP_CWM_captureObject","_ZCP_CWM_previousMarkers"];

_ZCP_CWM_captureObject = _this select 0;
_ZCP_CWM_previousMarkers = _this select 1;

[_ZCP_CWM_previousMarkers] call ZCP_fnc_removeMarker;

if(ZCP_MissionMarkerWinDotTime > 0) then {
  _ZCP_CWM_position		= _this select 2;
  _ZCP_CWM_mission 		= _ZCP_CWM_captureObject select 3;

  _ZCP_CWM_attentionMarker = createMarker [format['%1capped%2',_ZCP_CWM_mission,random 10], _ZCP_CWM_position];
  _ZCP_CWM_attentionMarker 		setMarkerType "hd_destroy";
  _ZCP_CWM_attentionMarker 		setMarkerColor ZCP_BackgroundColor;
  _ZCP_CWM_attentionMarker 		setMarkerText ([8] call ZCP_fnc_translate);

  [ZCP_MissionMarkerWinDotTime, {deleteMarker _this;}, _ZCP_CWM_attentionMarker, false] call ExileServer_system_thread_addTask;
};
*/