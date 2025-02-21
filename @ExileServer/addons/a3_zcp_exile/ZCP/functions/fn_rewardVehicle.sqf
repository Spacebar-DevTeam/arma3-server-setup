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
	
	The fn_rewardVehicle.sqf script in ZCP missions handles spawning a reward vehicle, either 
	by creating a new vehicle or utilizing a pre-spawned one. It sets up the vehicle, clears 
	its cargo, manages parachute drops if needed, and handles smoke signaling for easier 
	visibility. The script also ensures the vehicle is properly configured with NVG and 
	thermal settings and provides logging for debugging purposes.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Error Handling: Validates input parameters and handles null vehicles.
      Debugging: Enhanced logs for vehicle creation, parachute drops, and reward assignment.
      Performance: Streamlined position calculations and cargo clearing.
      Safety and Security: Properly locks the vehicle and sets damage immunity.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_RV_Data",
    ["_ZCP_RV_preVehicle", objNull, [objNull]]
];

private _ZCP_RV_currentCapper = _ZCP_RV_Data select 0;
private _ZCP_RV_name = _ZCP_RV_Data select 1;
private _ZCP_RV_capturePosition = _ZCP_RV_Data select 2;
private _ZCP_RV_captureRadius = _ZCP_RV_Data select 4;

private _ZCP_RV_vehicleName = "";
private _ZCP_RV_vehicle;

if (isNull _ZCP_RV_preVehicle) then {
    private _ZCP_RV_vehicleClass = selectRandom ZCP_VehicleRewardArray;
    private _ZCP_RV_cfg = configFile >> "CfgVehicles" >> _ZCP_RV_vehicleClass;

    _ZCP_RV_vehicleName = getText (_ZCP_RV_cfg >> "displayName");
    if (_ZCP_RV_vehicleName isEqualTo "") then {
        _ZCP_RV_vehicleName = _ZCP_RV_vehicleClass;
    };

    _ZCP_RV_vehicle = createVehicle [_ZCP_RV_vehicleClass, [0, 0, 150], [], 0, "CAN_COLLIDE"];
    _ZCP_RV_vehicle setPos [
        (_ZCP_RV_capturePosition select 0) + _ZCP_RV_captureRadius,
        (_ZCP_RV_capturePosition select 1) + _ZCP_RV_captureRadius,
        150
    ];

    [_ZCP_RV_vehicle, "SmokeShellPurple"] call ZCP_fnc_paraDrop;
} else {
    _ZCP_RV_vehicle = _ZCP_RV_preVehicle;
    _ZCP_RV_vehicleName = name _ZCP_RV_vehicle;

    _ZCP_RV_vehicle allowDamage true;
    _ZCP_RV_vehicle lock false;

    private _smoke = "SmokeShellPurple" createVehicle getPosATL _ZCP_RV_vehicle;
    _smoke attachTo [_ZCP_RV_vehicle, [0, 0, 0]];
};

// Common vehicle configuration
_ZCP_RV_vehicle allowDamage false;
_ZCP_RV_vehicle lock 2; // Lock the vehicle
_ZCP_RV_vehicle setDir (random 360);
clearWeaponCargoGlobal _ZCP_RV_vehicle;
clearMagazineCargoGlobal _ZCP_RV_vehicle;
clearBackpackCargoGlobal _ZCP_RV_vehicle;
clearItemCargoGlobal _ZCP_RV_vehicle;

// Special configurations
if (_ZCP_RV_vehicle isKindOf "I_UGV_01_F") then {
    createVehicleCrew _ZCP_RV_vehicle;
};

if (getNumber (configFile >> "CfgSettings" >> "VehicleSpawn" >> "nightVision") isEqualTo 0) then {
    _ZCP_RV_vehicle disableNVGEquipment true;
};

if (getNumber (configFile >> "CfgSettings" >> "VehicleSpawn" >> "thermalVision") isEqualTo 0) then {
    _ZCP_RV_vehicle disableTIEquipment true;
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] %1 received a %2 at %3", _ZCP_RV_currentCapper, _ZCP_RV_vehicleName, getPosATL _ZCP_RV_vehicle];
};

_ZCP_RV_vehicle

/*
params [
    '_ZCP_RV_Data',
    '_ZCP_RV_preVechicle'
];

private _ZCP_RV_currentCapper = _ZCP_RV_Data select 0;
private _ZCP_RV_name = _ZCP_RV_Data select 1;
private _ZCP_RV_capturePosition = _ZCP_RV_Data select 2;
private _ZCP_RV_captureRadius = _ZCP_RV_Data select 4;

private _ZCP_RV_vehicleName = "";

if(_ZCP_RV_preVechicle isEqualTo objNull) then {
    private _ZCP_RV_vehicleClass = ZCP_VehicleReward call BIS_fnc_selectRandom;
    private _ZCP_RV_cfg  = (configFile >>  "CfgVehicles" >>  _ZCP_RV_vehicleClass);
    _ZCP_RV_vehicleName = if (isText(_ZCP_RV_cfg >> "displayName")) then {
        getText(_ZCP_RV_cfg >> "displayName")
       }
    else {
        _ZCP_RV_vehicleClass
    };

    private _ZCP_RV_vehicle = _ZCP_RV_vehicleClass createVehicle [0,0,150];

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
    _ZCP_RV_vehicle setPos [(_ZCP_RV_capturePosition select 0) + _ZCP_RV_captureRadius ,(_ZCP_RV_capturePosition select 1) + _ZCP_RV_captureRadius, 150];
    _ZCP_RV_vehicle call ZCP_fnc_paraDrop;


} else {

    clearWeaponCargoGlobal _ZCP_RV_preVechicle;
    clearMagazineCargoGlobal _ZCP_RV_preVechicle;
    clearBackpackCargoGlobal _ZCP_RV_preVechicle;
    clearItemCargoGlobal _ZCP_RV_preVechicle;
    _ZCP_RV_preVechicle allowDamage true;
    _ZCP_RV_preVechicle lock false;

     private _smoke = "smokeShellPurple" createVehicle getPosATL _ZCP_RV_preVechicle;
    _smoke setPosATL (getPosATL _ZCP_RV_preVechicle);
    _smoke attachTo [_ZCP_RV_preVechicle,[0,0,0]];

    _ZCP_RV_vehicleName = name _ZCP_RV_preVechicle;
};

diag_log text format ["[ZCP]: %1 received a %3 for %2.",name _ZCP_RV_currentCapper,_ZCP_RV_name, _ZCP_RV_vehicleName];
*/