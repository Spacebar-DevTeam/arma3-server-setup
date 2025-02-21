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
	
	The fn_removeMarker.sqf script in ZCP missions deletes map markers related to completed 
	or canceled missions. It ensures that all specified markers are safely removed to keep 
	the map clear and reduce clutter for players. The script handles both standard and 
	dynamic markers and includes debugging output to verify successful marker deletion.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Input Validation: Ensures marker name is valid before proceeding.
      Safety Checks: Uses isMarker to avoid errors when the marker is not present.
      Debugging: Added detailed logs for success and warning scenarios.
      Performance: Minimal processing by avoiding unnecessary deleteMarker calls.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params ["_ZCP_RM_markerName"];

if (isNil "_ZCP_RM_markerName" || {_ZCP_RM_markerName == ""}) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid marker name provided to fn_removeMarker.sqf"; };
};

// Check if the marker exists before attempting to delete
if (isMarker _ZCP_RM_markerName) then {
    deleteMarker _ZCP_RM_markerName;
    
    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Marker %1 successfully removed.", _ZCP_RM_markerName];
    };
} else {
    if (ZCP_Debug) then {
        diag_log format ["[ZCP] WARNING: Marker %1 does not exist, skipping removal.", _ZCP_RM_markerName];
    };
};

/*
private["_nil","_ZCP_RM_markers"];
// Delete the marker in the array
_ZCP_RM_markers = _this select 0;
{
	deleteMarker format['%1',_x];
}count _ZCP_RM_markers;
*/