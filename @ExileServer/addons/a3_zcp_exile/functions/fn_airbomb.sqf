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
	  Validation Checks: Early exit on invalid inputs.
	  Height Handling: Defaults to 200m if not specified.
	  Random Bomb Types: Simplified with selectRandom.
	  Debugging Logs: Controlled by a ZCP_Debug variable to avoid cluttering logs during normal operation.
	  Readability: Clearer variable names and formatted log outputs.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

private _pos = _this select 0; // Target position
private _radius = _this select 1; // Bombing radius
private _bombCount = _this select 2; // Number of bombs to drop
private _height = if (count _this > 3) then {_this select 3} else {200}; // Optional height, default 200m

if (isNil "_pos" || {_radius <= 0} || {_bombCount <= 0}) exitWith {
    diag_log "[ZCP] ERROR: Invalid parameters for fn_airbomb.sqf!";
};

private _bombTypes = [
    "Bo_Mk82", "Bo_GBU12_LGB", "Bo_Mk82", "Bo_Mk82", 
    "Bo_GBU12_LGB", "Bo_GBU12_LGB", "Bo_Mk82"
];

for "_i" from 1 to _bombCount do {
    private _dropPos = _pos getPos [random _radius, random 360];
    private _bombType = selectRandom _bombTypes;

    _bombType createVehicle [_dropPos select 0, _dropPos select 1, _height];
    
    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Bomb dropped at %1 of type %2", _dropPos, _bombType];
    };
    
    sleep 0.1;
};

if (ZCP_Debug) then {
    hint "Airbomb strike complete!";
    diag_log "[ZCP] Airbomb strike completed successfully.";
};

/*
private _pos = _this select 0; // Target position
private _radius = _this select 1; // Bombing radius
private _bombCount = _this select 2; // Number of bombs to drop
private _height = if (count _this > 3) then {_this select 3} else {200}; // Optional height, default 200m

if (isNil "_pos" || {_radius <= 0} || {_bombCount <= 0}) exitWith {
    diag_log "[ZCP] ERROR: Invalid parameters for fn_airbomb.sqf!";
};

private _bombTypes = [
    "Bo_Mk82", "Bo_GBU12_LGB", "Bo_Mk82", "Bo_Mk82", 
    "Bo_GBU12_LGB", "Bo_GBU12_LGB", "Bo_Mk82"
];

for "_i" from 1 to _bombCount do {
    private _dropPos = _pos getPos [random _radius, random 360];
    private _bombType = selectRandom _bombTypes;

    _bombType createVehicle [_dropPos select 0, _dropPos select 1, _height];
    
    if (ZCP_Debug) then {
        diag_log format ["[ZCP] Bomb dropped at %1 of type %2", _dropPos, _bombType];
    };
    
    sleep 0.1;
};

if (ZCP_Debug) then {
    hint "Airbomb strike complete!";
    diag_log "[ZCP] Airbomb strike completed successfully.";
};
*/