if (!isServer) exitWith {};

private["_crate", "_crateCargo", "_crateClass", "_crateCountPoptabsSeed", "_cratePosition", "_isDebugFillLogEnabled", "_marker", "_minDistance", "_maxDistance", "_positioning", "_spawnCenter", "_wreckage", "_wreckageClass", "_wreckCount", "_wreckId", "_wreckagePosition"];

"Starting shipwreck spawns..." call ExileServer_BigfootsShipwrecks_util_logCommand;

_wreckCount = _this select 0;;

_positioning = _this select 1;
_spawnCenter = _positioning select 0;
_minDistance = _positioning select 1;
_maxDistance = _positioning select 2;


_wreckageClass = _this select 2;
_crateClass = _this select 3;
_crateCargo = _this select 4;
_crateCountPoptabsSeed = _this select 5;
_isDebugFillLogEnabled = _this select 6;

for "_i" from 1 to _wreckCount do
{   
   
	bigfoot_locationFound = false;

	while {!bigfoot_locationFound} do
	{

	   // Find location
		_wreckagePosition = [_spawnCenter, _minDistance, _maxDistance, 1, 2, 800, 0] call BIS_fnc_findSafePos; //  _maxdistance,   1,          2,          800,           0] original 
																						// suspected operation                objdistanc   water mode   max grade     shore mode
				
		private _BigFootPos = createVehicle ["Land_HelipadEmpty_F", _wreckagePosition, [], 0, "CAN_COLLIDE"];
		
		private _BigFootPosDepth =  getposASL _BigFootPos select 2;

		BS_locations_WaterDepth_max = BS_locations_WaterDepth_max * -1;    // converts the positive number in the config to a neg number for water depth calculation
		BS_locations_WaterDepth_MIN = BS_locations_WaterDepth_MIN * -1;	 // converts the positive number in the config to a neg number for water depth calculation
			
		if (_BigFootPosDepth >= BS_locations_WaterDepth_max && _BigFootPosDepth <= BS_locations_WaterDepth_MIN) then
		{
			bigfoot_locationFound = true;			
					
		};
			deleteVehicle _BigFootPos;
	};


    format["Found position at [%1] for wreck.", _wreckagePosition] call ExileServer_BigfootsShipwrecks_util_logCommand;

    // Create ID for this wreck
    _wreckId = _i call ExileServer_BigfootsShipwrecks_getWreckIdForSpawnCountIndexQuery;

    // Create a marker
    [_wreckId, _wreckagePosition, "Shipwrecked loot crate"] call ExileServer_BigfootsShipwrecks_createShipwreckMarkerCommand;
    
    format["Spawning wreck and crate near [%1] with id [%2].", _wreckagePosition, _wreckId] call ExileServer_BigfootsShipwrecks_util_logCommand;
    
    // Create wreck
    _wreckage = _wreckageClass createVehicle _wreckagePosition;
 
    // Create crate nearby
    _cratePosition = _wreckage getRelPos [10, 0];
    _crate = _crateClass createVehicle _cratePosition;    
    _crate call ExileServer_BigfootsShipwrecks_setupCrateCommand;

    // Put cargo in crate
    [_wreckId, _crate, _crateCargo, _isDebugFillLogEnabled] call ExileServer_BigfootsShipwrecks_addItemsToCrateCommand;

    // Put money in crate
    [_wreckId, _crate, _crateCountPoptabsSeed, _isDebugFillLogEnabled] call ExileServer_BigfootsShipwrecks_addMoneyToCrateCommand;
};

"Finished shipwreck spawns." call ExileServer_BigfootsShipwrecks_util_logCommand;   