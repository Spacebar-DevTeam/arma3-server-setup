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
	
	The fn_createWaypoint.sqf script creates waypoints for AI groups in ZCP missions. 
	It sets the waypoint position, behavior, and speed based on mission parameters, 
	including support for different AI modes like MOVE, SAD (Seek and Destroy), and GUARD.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Directly sets waypoint parameters without unnecessary checks.
      Debugging: Provides detailed logs for all waypoint properties.
      Code Clarity: Consistent and clear parameter usage.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    "_ZCP_CW_group",
    "_ZCP_CW_position",
    "_ZCP_CW_waypointType",
    "_ZCP_CW_speedMode",
    "_ZCP_CW_behaviour"
];

// Create the waypoint
private _ZCP_CW_wp = _ZCP_CW_group addWaypoint [_ZCP_CW_position, 0];
_ZCP_CW_wp setWaypointType _ZCP_CW_waypointType;
_ZCP_CW_wp setWaypointSpeed _ZCP_CW_speedMode;
_ZCP_CW_wp setWaypointBehaviour _ZCP_CW_behaviour;

// Add custom completion radius for the waypoint
_ZCP_CW_wp setWaypointCompletionRadius 10;

// Debugging output
if (ZCP_Debug) then {
    diag_log format [
        "[ZCP] Waypoint created for group %1 at %2 with type %3, speed %4, behaviour %5",
        _ZCP_CW_group, _ZCP_CW_position, _ZCP_CW_waypointType, _ZCP_CW_speedMode, _ZCP_CW_behaviour
    ];
};

_ZCP_CW_wp

/*
private['_ZCP_CWP_attackWP','_ZCP_CWP_group','_ZCP_CWP_capturePosition','_ZCP_CWP_holdWP'];

_ZCP_CWP_group = _this select 0;
_ZCP_CWP_capturePosition = _this select 1;
_ZCP_CWP_attackWP = _ZCP_CWP_group addWaypoint [_ZCP_CWP_capturePosition, 5];
_ZCP_CWP_attackWP setWaypointType "MOVE";
_ZCP_CWP_attackWP setWaypointSpeed "FULL";
_ZCP_CWP_attackWP setWaypointBehaviour "COMBAT";

_ZCP_CWP_holdWP = _ZCP_CWP_group addWaypoint [_ZCP_CWP_capturePosition, 5];
_ZCP_CWP_holdWP setWaypointType "HOLD";
_ZCP_CWP_holdWP setWaypointSpeed "NORMAL";
_ZCP_CWP_holdWP setWaypointBehaviour "COMBAT";

_ZCP_CWP_group setCurrentWaypoint _ZCP_CWP_attackWP;
*/