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
	
	The fn_endMission.sqf script resets the mission state in ZCP by updating the 
	ZCP_Data array for a specified capture point index. It sets the mission as inactive, 
	resets the capture status, clears position data, and reduces the ZCP_MissionCounter. 
	The script also clears associated MissionTriggerData to ensure proper mission cleanup.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Accesses ZCP_Data directly for clarity.
      Debugging: Provides a log when a mission is ended.
      Safety: Ensures ZCP_MissionCounter is updated correctly.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    '_ZCP_EM_capPointIndex'
];

// Reset mission data for the capture point
private _missionData = ZCP_Data select _ZCP_EM_capPointIndex;
_missionData set [0, false]; 			// Set mission as inactive
_missionData set [1, 0]; 				// Reset capture status
_missionData set [2, [-99999, 0, 0]]; 	// Clear position data
_missionData set [3, false]; 			// Clear active state

ZCP_MissionCounter = ZCP_MissionCounter - 1;
ZCP_MissionTriggerData set [_ZCP_EM_capPointIndex, []];

// Debugging output
if (ZCP_Debug) then {
    diag_log format ["[ZCP] Mission at index %1 ended successfully.", _ZCP_EM_capPointIndex];
};

/*
params[
  '_ZCP_EM_capPointIndex'
];

(ZCP_Data select _ZCP_EM_capPointIndex) set[0,false];
(ZCP_Data select _ZCP_EM_capPointIndex) set[1,0];
(ZCP_Data select _ZCP_EM_capPointIndex) set[2,[-99999,0,0]];
(ZCP_Data select _ZCP_EM_capPointIndex) set[3,false];
ZCP_MissionCounter = ZCP_MissionCounter - 1;
ZCP_MissionTriggerData set [_ZCP_EM_capPointIndex, []];
*/