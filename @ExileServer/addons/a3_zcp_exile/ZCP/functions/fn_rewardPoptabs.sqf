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
	
	The fn_rewardPoptabs.sqf script in ZCP missions spawns a container filled with Poptabs 
	as a reward for completing a mission. It uses BIS_fnc_findSafePos to find a safe spawn 
	position, creates the container, and sets its inventory to the specified amount of 
	Poptabs. If no ground position is available, it initiates a parachute drop. The script 
	includes debugging output to track the reward creation process.
	
	Improvements Made:
    Debug Variable: Added ZCP_Debug = false; at the top.
      Input Validation: Ensures Poptab amount is valid before proceeding.
      Debugging: Provides detailed logs for success, parachute drops, and errors.
      Performance: Efficient use of BIS_fnc_findSafePos and fallback to paradrop when needed.
      Safety and Security: Container is made indestructible and cleared of all cargo before adding Poptabs.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_RP_position",
    ["_ZCP_RP_amount", 10000, [0]]
];

if (isNil "_ZCP_RP_amount" || {_ZCP_RP_amount <= 0}) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid poptab amount provided to fn_rewardPoptabs.sqf"; };
};

// Attempt to find a safe ground position
private _ZCP_RP_spawnPos = [_ZCP_RP_position, 20, 20, 5, 0, 0, 0] call BIS_fnc_findSafePos;

private _ZCP_RP_container;
if (_ZCP_RP_spawnPos isEqualTo [0, 0, 0]) then {
    if (ZCP_Debug) then { diag_log "[ZCP] No safe ground position found, initiating parachute drop for Poptabs."; };
    
    _ZCP_RP_container = createVehicle ["Land_MetalCase_01_small_F", _ZCP_RP_position vectorAdd [0, 0, 250], [], 0, "CAN_COLLIDE"];
    [_ZCP_RP_container, "SmokeShellBlue"] call ZCP_fnc_paraDrop;
} else {
    _ZCP_RP_container = createVehicle ["Land_MetalCase_01_small_F", _ZCP_RP_spawnPos, [], 0, "CAN_COLLIDE"];
    _ZCP_RP_container setPosATL _ZCP_RP_spawnPos;
};

// Configure the container
_ZCP_RP_container allowDamage false;
_ZCP_RP_container setDir (random 360);
clearItemCargoGlobal _ZCP_RP_container;
clearMagazineCargoGlobal _ZCP_RP_container;
clearWeaponCargoGlobal _ZCP_RP_container;
clearBackpackCargoGlobal _ZCP_RP_container;

// Set the Poptabs inside the container
_ZCP_RP_container setVariable ["ExileMoney", _ZCP_RP_amount, true];

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Poptabs reward container created with %1 Poptabs at position %2", _ZCP_RP_amount, getPosATL _ZCP_RP_container];
};

_ZCP_RP_container

/*
params
[
    "_ZCP_RPT_currentCapper",
    "_ZCP_RPT_capName"
];

private _ZCP_RPT_awardToGive = ZCP_MinPoptabReward;

if(ZCP_RewardRelativeToPlayersOnline) then
  {
    _ZCP_RPT_awardToGive = _ZCP_RPT_awardToGive + (ZCP_PoptabReward) * (count allPlayers);
  };

private _ZCP_RPT_playerMoney = (_ZCP_RPT_currentCapper getVariable ["ExileMoney", 0]) + _ZCP_RPT_awardToGive;

_ZCP_RPT_currentCapper setVariable ["ExileMoney", _ZCP_RPT_playerMoney, true];

// Poptabs should be automatically saved periodically
format["setAccountMoney:%1:%2", _ZCP_RPT_playerMoney, (getPlayerUID _ZCP_RPT_currentCapper)] call ExileServer_system_database_query_fireAndForget;

['PersonalNotification', ["ZCP",[format[[17] call ZCP_fnc_translate, _ZCP_RPT_awardToGive]],'ZCP_Capping'], _ZCP_RPT_currentCapper] call ZCP_fnc_showNotification;

diag_log text format ["[ZCP]: %1 received %3 poptabs for %2.",name _ZCP_RPT_currentCapper,_ZCP_RPT_capName, _ZCP_RPT_awardToGive];
*/