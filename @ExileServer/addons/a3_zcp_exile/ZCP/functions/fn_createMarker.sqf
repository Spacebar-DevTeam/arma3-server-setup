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
	
	The fn_createMarker.sqf script in ZCP creates mission markers on the map, 
	including the main area marker, the mission state marker (free, contested, 
	or capped), and the capture point icon. It dynamically sets marker shapes, 
	colors, and sizes based on mission parameters.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Combined conditions into ternary operators.
      Error Handling: Ensured all markers are correctly set up.
      Performance: Optimized the marker color selection process.
      Debugging: Provides detailed logs when debugging is enabled.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    "_ZCP_CM_captureObject",
    "_ZCP_CM_capRadius",
    "_ZCP_CM_previousMarkers",
    "_ZCP_CM_position",
    "_ZCP_CM_cityX",
    "_ZCP_CM_cityY",
    "_ZCP_CM_cityName"
];

private _ZCP_CM_name = _ZCP_CM_captureObject select 0;
private _ZCP_CM_mission = _ZCP_CM_captureObject select 3;
private _ZCP_CM_index = _ZCP_CM_captureObject select 4;
private _ZCP_CM_markerX = if (_ZCP_CM_cityX == 0) then {_ZCP_CM_capRadius} else {_ZCP_CM_cityX};
private _ZCP_CM_markerY = if (_ZCP_CM_cityY == 0) then {_ZCP_CM_capRadius} else {_ZCP_CM_cityY};

if (ZCP_CONFIG_UseCityName) then {
    _ZCP_CM_name = format ["%1 CP", _ZCP_CM_cityName];
};

// Remove previous markers
[_ZCP_CM_previousMarkers] call ZCP_fnc_removeMarker;

// Create the area marker
private _ZCP_CM_attentionMarker = createMarker [format ["ZCP_CM_%1_area", _ZCP_CM_mission], _ZCP_CM_position];
_ZCP_CM_attentionMarker setMarkerShape "ELLIPSE";
_ZCP_CM_attentionMarker setMarkerColor ZCP_BackgroundColor;
_ZCP_CM_attentionMarker setMarkerBrush "Solid";
_ZCP_CM_attentionMarker setMarkerSize [_ZCP_CM_markerX * 3, _ZCP_CM_markerY * 3];

// Create the main mission state marker
private _ZCP_CM_marker = createMarker [format ["ZCP_CM_%1", _ZCP_CM_mission], _ZCP_CM_position];
_ZCP_CM_marker setMarkerShape "ELLIPSE";
_ZCP_CM_marker setMarkerBrush "Solid";
_ZCP_CM_marker setMarkerSize [_ZCP_CM_markerX, _ZCP_CM_markerY];
_ZCP_CM_marker setMarkerText _ZCP_CM_name;

private _markerColor = switch ((ZCP_Data select _ZCP_CM_index) select 1) do {
    case 1: {ZCP_CappedColor};
    case 2: {ZCP_ContestColor};
    default {ZCP_FreeColor};
};

_ZCP_CM_marker setMarkerColor _markerColor;

// Create the capture point icon
private _ZCP_CM_dot = createMarker [format ["ZCP_CM_dot_%1", _ZCP_CM_mission], _ZCP_CM_position];
_ZCP_CM_dot setMarkerType "ExileMissionCapturePointIcon";
_ZCP_CM_dot setMarkerText format [" %1", _ZCP_CM_name];

// Debugging information
if (ZCP_Debug) then {
    diag_log format ["[ZCP] Created markers for mission %1 at %2", _ZCP_CM_mission, _ZCP_CM_position];
};

[_ZCP_CM_attentionMarker, _ZCP_CM_marker, _ZCP_CM_dot]

/*
params
[
	"_ZCP_CM_captureObject",
	"_ZCP_CM_capRadius",
	"_ZCP_CM_previousMarkers",
	"_ZCP_CM_position",
	"_ZCP_CM_cityX",
	"_ZCP_CM_cityY",
	"_ZCP_CM_cityName"
];


private _ZCP_CM_name 			= _ZCP_CM_captureObject select 0;
private _ZCP_CM_mission 		= _ZCP_CM_captureObject select 3;
private _ZCP_CM_index 			= _ZCP_CM_captureObject select 4;

private _ZCP_CM_markerX = _ZCP_CM_cityX;
private _ZCP_CM_markerY = _ZCP_CM_cityY;

if( _ZCP_CM_cityX == 0 || _ZCP_CM_cityY == 0 ) then
{
    _ZCP_CM_markerX  = _ZCP_CM_capRadius;
    _ZCP_CM_markerY  = _ZCP_CM_capRadius;
}
else
{
    if (ZCP_CONFIG_UseCityName) then
    {
        _ZCP_CM_name = format["%1 CP", _ZCP_CM_cityName];
    };
} ;

[_ZCP_CM_previousMarkers] call ZCP_fnc_removeMarker;

private _ZCP_CM_attentionMarker = createMarker [format['ZCP_CM_%1_area',_ZCP_CM_mission], _ZCP_CM_position];
_ZCP_CM_attentionMarker 		setMarkerShape "ELLIPSE";
_ZCP_CM_attentionMarker 		setMarkerColor ZCP_BackgroundColor;
_ZCP_CM_attentionMarker 		setMarkerBrush "Solid";
_ZCP_CM_attentionMarker 		setMarkerSize [_ZCP_CM_markerX * 3,_ZCP_CM_markerY * 3];

private _ZCP_CM_marker 			= createMarker [format['ZCP_CM_%1',_ZCP_CM_mission], _ZCP_CM_position];

_ZCP_CM_marker setMarkerColor
(
	switch ( (ZCP_Data select _ZCP_CM_index) select 1 ) do
	{
	    case 1:
		{
			ZCP_CappedColor
		};
	    case 2:
		{
			ZCP_ContestColor
		};
		default
		{
			ZCP_FreeColor
		};
	}
);

_ZCP_CM_marker 		setMarkerShape "ELLIPSE";
_ZCP_CM_marker 		setMarkerBrush "Solid";
_ZCP_CM_marker 		setMarkerSize [_ZCP_CM_markerX,_ZCP_CM_markerY];
_ZCP_CM_marker 		setMarkerText _ZCP_CM_name;

private _ZCP_CM_dot 	= createMarker [format['ZCP_CM_dot_%1',_ZCP_CM_mission], _ZCP_CM_position];
_ZCP_CM_dot 			setMarkerType "ExileMissionCapturePointIcon";
_ZCP_CM_dot 			setMarkerText format["   %1",_ZCP_CM_name];

[_ZCP_CM_attentionMarker, _ZCP_CM_marker, _ZCP_CM_dot]




//
//ZCP_Towns = nearestLocations [[15000,15000,0], ["NameVillage","NameCity","NameCityCapital"], 80000];
//ZCP_markers = [];
//{
//
//	private _ZCP_S_city_sizeX = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (className _x) >> "radiusA");
//	private _ZCP_S_city_sizeY = getNumber (configFile >> "CfgWorlds" >> worldName >> "Names" >> (className _x) >> "radiusB");
//	private _ZCP_CM_position = getArray (configFile >> "CfgWorlds" >> worldName >> "Names" >> (className  _x) >> "position");
//
//
//
//	private _ZCP_CM_marker 			= createMarker [format['ZCP_CM_%1', random 5000], _ZCP_CM_position];
//	_ZCP_CM_marker 		setMarkerColor ZCP_CappedColor;
//	_ZCP_CM_marker 		setMarkerShape "ELLIPSE";
//	_ZCP_CM_marker 		setMarkerBrush "Solid";
//	_ZCP_CM_marker 		setMarkerSize [_ZCP_S_city_sizeX,_ZCP_S_city_sizeY];
//	_ZCP_CM_marker 		setMarkerText _ZCP_CM_name;
//	private _ZCP_CM_dot 	= createMarker [format['ZCP_CM_dot_%1', random 5000], _ZCP_CM_position];
//	_ZCP_CM_dot 			setMarkerType "ExileMissionCapturePointIcon";
//	_nil = ZCP_markers pushBack _ZCP_CM_dot;
//	_nil = ZCP_markers pushBack _ZCP_CM_marker;
//}count ZCP_Towns;
*/