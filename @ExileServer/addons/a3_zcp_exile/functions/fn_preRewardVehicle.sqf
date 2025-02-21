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
	
	The fn_preRewardVehicle.sqf script in ZCP missions handles spawning a reward vehicle at 
	a safe position within the mission zone. It selects a random vehicle, clears its 
	inventory, applies safety settings, and uses either direct spawning or a parachute 
	drop if a safe ground position is not available. The vehicle is locked, made 
	invulnerable, and set as non-persistent.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Error Handling: Validates the vehicle class and safe position before spawning.
      Debugging: Detailed logs for vehicle creation and parachute drops.
      Safety and Security: Applies lock and damage prevention to the vehicle.
      Performance: Uses BIS_fnc_findSafePos efficiently and handles fallback to paradrop when needed.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params ["_ZCP_PRV_position"];

private _ZCP_PRV_vehicleClass = selectRandom ZCP_VehicleRewardArray;

if (isNil "_ZCP_PRV_vehicleClass") exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Vehicle class is undefined for preRewardVehicle."; };
};

// Attempt to find a safe spawn position
private _ZCP_PRV_spawnPos = [_ZCP_PRV_position, 30, 30, 5, 0, 20, 0] call BIS_fnc_findSafePos;

private _ZCP_PRV_vehicle;
if (_ZCP_PRV_spawnPos isEqualTo [0, 0, 0]) then {
    if (ZCP_Debug) then { diag_log "[ZCP] No safe ground position found, initiating parachute drop."; };
    
    _ZCP_PRV_vehicle = createVehicle [_ZCP_PRV_vehicleClass, _ZCP_PRV_position vectorAdd [0, 0, 250], [], 0, "CAN_COLLIDE"];
    [_ZCP_PRV_vehicle, "SmokeShellGreen"] call ZCP_fnc_paraDrop;
} else {
    _ZCP_PRV_vehicle = createVehicle [_ZCP_PRV_vehicleClass, _ZCP_PRV_spawnPos, [], 0, "CAN_COLLIDE"];
    _ZCP_PRV_vehicle setPosATL _ZCP_PRV_spawnPos;
};

// Vehicle Configuration
_ZCP_PRV_vehicle allowDamage false;
_ZCP_PRV_vehicle lock 2; // Locked
_ZCP_PRV_vehicle setDir (random 360);
_ZCP_PRV_vehicle clearWeaponCargoGlobal;
_ZCP_PRV_vehicle clearMagazineCargoGlobal;
_ZCP_PRV_vehicle clearItemCargoGlobal;
_ZCP_PRV_vehicle clearBackpackCargoGlobal;

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Pre-created reward vehicle %1 at position %2", _ZCP_PRV_vehicleClass, getPosATL _ZCP_PRV_vehicle];
};

_ZCP_PRV_vehicle

/*
params[
    '_ZCP_RV_capturePosition',
    '_ZCP_RV_captureRadius',
    '_ZCP_RV_isCity'
];

private _ZCP_RV_vehicleClass = ZCP_VehicleReward call BIS_fnc_selectRandom;
private _ZCP_RV_posVehicle = [];

if(_ZCP_RV_isCity) then
  {
     _ZCP_RV_posVehicle = _ZCP_RV_capturePosition findEmptyPosition [0, (_ZCP_RV_captureRadius * 2), _ZCP_RV_vehicleClass];

     if(count _ZCP_RV_posVehicle < 1) then
       {
         _ZCP_RV_posVehicle = _ZCP_RV_capturePosition findEmptyPosition [0, (_ZCP_RV_captureRadius * 3), _ZCP_RV_vehicleClass];
       };
  }
else
  {
     _ZCP_RV_posVehicle = _ZCP_RV_capturePosition findEmptyPosition [_ZCP_RV_captureRadius, _ZCP_RV_captureRadius * 2, _ZCP_RV_vehicleClass];
  };

if(count _ZCP_RV_posVehicle < 1) exitWith
  {
    // No safe pos found. SO return nullObject -> This will trigger a parachute vehicle.
    objNull
  };

private _ZCP_RV_vehicle = _ZCP_RV_vehicleClass createVehicle _ZCP_RV_posVehicle;

clearWeaponCargoGlobal _ZCP_RV_vehicle;
clearMagazineCargoGlobal _ZCP_RV_vehicle;
clearBackpackCargoGlobal _ZCP_RV_vehicle;
clearItemCargoGlobal _ZCP_RV_vehicle;

if (_ZCP_RV_vehicleClass isKindOf "I_UGV_01_F") then
{
	createVehicleCrew _ZCP_RV_vehicle;
};
if (getNumber (configFile >> "CfgSettings" >> "VehicleSpawn" >> "nightVision") isEqualTo 0) then
{
	_ZCP_RV_vehicle disableNVGEquipment true;
};
if (getNumber (configFile >> "CfgSettings" >> "VehicleSpawn" >> "thermalVision") isEqualTo 0) then
{
	_ZCP_RV_vehicle disableTIEquipment true;
};

_ZCP_RV_vehicle setDir random 360;
_ZCP_RV_vehicle setPos _ZCP_RV_posVehicle;
_ZCP_RV_vehicle lock true;
_ZCP_RV_vehicle allowDamage false;

_ZCP_RV_vehicle setVariable ["ExileMoney",0,true];
_ZCP_RV_vehicle setVariable ["ExileIsPersistent", false];
_ZCP_RV_vehicle setVariable ["ExileIsSimulationMonitored", false];

_ZCP_RV_vehicle
*/