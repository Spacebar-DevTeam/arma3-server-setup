/*
    underwater_stash.sqf
    Underwater Stash Mission for Arma 3
    Features: AI divers, diver gear crate, SDVs, mission status tracking, debugging
	
	What This Script Does:
      Spawns AI Divers: With custom loadouts and randomized skill levels.
      Deploys a Gear Crate: Full of diver-related equipment.
      Places Submersible Vehicles: Ready for player use.
      Handles Mission Completion: Cleans up all spawned assets when the mission is completed.
      Debugging Support: Easily enable or disable detailed log outputs.
      Safety Checks: Validates mission markers and exits cleanly if not found.
	
	sko & Ghost PGM DEV TEAM
*/

// Mission Configuration
private _missionName = "Underwater Stash";
private _missionMarker = "underwater_stash_marker";
private _missionRadius = 500; 	// Radius in meters
private _aiGroupSize = 6; 		// Number of AI units to spawn
private _debug = true; 			// Set to 'true' to enable debugging

// Debugging Function
private _log = {
    params ["_message"];
    if (_debug) then {
        diag_log format ["[%1] %2", _missionName, _message];
    };
};

// Validate Mission Marker
if (isNil {getMarkerPos _missionMarker}) then {
    [_missionName, "Mission marker not found. Aborting mission."] call _log;
    missionNamespace setVariable [format ["%1_Status", _missionName], "Error"];
    exitWith {};
} else {
    [_missionName, "Mission marker located. Proceeding with mission setup."] call _log;
};

// Mission Location
private _missionPos = getMarkerPos _missionMarker;

// AI Diver Loadout
private _diverLoadout = [
    "arifle_SDAR_F", 							// Weapon
    [], 										// No attachments
    [["20Rnd_556x45_UW_mag", 6]], 				// Magazines
    "", 										// No launcher
    [], 										// No launcher magazines
    ["Rangefinder", "ItemGPS", "NVGoggles"], 	// Items
    [], 										// No assigned items
    "U_O_Wetsuit", 								// Uniform
    "V_RebreatherIA", 							// Vest
    "B_Bergen_mcamo" 							// Backpack
];

// Spawn AI Diver Patrols
private _spawnAIDivers = {
    params ["_position", "_groupSize"];
    private _group = createGroup east;
    for "_i" from 1 to _groupSize do {
        private _unit = _group createUnit ["O_diver_F", _position, [], 0, "FORM"];
        [_unit, _diverLoadout] call BIS_fnc_loadInventory;
        _unit setSkill random 0.6 + 0.3; 		// Randomized skill level
        _unit allowDamage true;
    };
    [_missionName, format ["Spawned %1 AI divers at %2.", _groupSize, _position]] call _log;
    _group
};

// Spawn Diver Gear Crate
private _spawnDiverGearCrate = {
    params ["_position"];
    private _crate = createVehicle ["I_CargoNet_01_ammo_F", _position, [], 0, "NONE"];
    private _diverGearContents = [
        ["arifle_SDAR_F", 5], 					// 5 SDAR rifles
        ["20Rnd_556x45_UW_mag", 10], 			// 10 underwater magazines
        ["U_O_Wetsuit", 5], 					// 5 wetsuits
        ["V_RebreatherIA", 5], 					// 5 rebreathers
        ["B_Carryall_oli", 2], 					// 2 carryall backpacks
        ["B_ViperHarness_oli_F", 1] 			// 1 Viper Harness
    ];
    {
        _crate addItemCargoGlobal [_x select 0, _x select 1];
    } forEach _diverGearContents;
    [_missionName, "Diver gear crate deployed."] call _log;
    _crate
};

// Spawn Submersible Vehicles (SDVs)
private _spawnSDVs = {
    params ["_positions"];
    {
        private _sdv = createVehicle ["Exile_Boat_SDV_CSAT", _x, [], 0, "NONE"];
        _sdv setVariable ["DMS_AllowSmoke", false];
        [_missionName, format ["SDV deployed at %1.", _x]] call _log;
    } forEach _positions;
};

// Initialize Mission Elements
private _aiGroup = [_missionPos, _aiGroupSize] call _spawnAIDivers;
private _crate = [_missionPos] call _spawnDiverGearCrate;
private _sdvPositions = [
    _missionPos vectorAdd [10, 0, -10],
    _missionPos vectorAdd [-10, 5, -10]
];
[_sdvPositions] call _spawnSDVs;

// Broadcast Mission Start
["#FFFF00", "CSAT forces have established an underwater stash. Infiltrate the area, neutralize hostiles, and secure the supplies."] call DMS_fnc_Broadcast;

// Mission Completion Handler
private _onMissionComplete = {
    [_missionName, "Mission completed successfully! Securing and cleaning up assets."] call _log;
    deleteVehicle _crate; // Clean up the crate
    {deleteVehicle _x} forEach vehicles; // Clean up SDVs
    {deleteVehicle _x} forEach units _aiGroup; // Clean up remaining AI
    ["#0080ff", "Mission accomplished! The underwater stash has been secured."] call DMS_fnc_Broadcast;
};

// Monitor Mission Completion
[] spawn {
    waitUntil {({alive _x} count units _aiGroup) == 0};
    [_onMissionComplete] call _onMissionComplete;
};


/*
	"Underwater Stash" mission for Tanoa
	Created by eraser1
/////////////////////// this was commented out /////////////////////////

// For logging purposes
_num = DMS_MissionCount;


// Set mission side (only "bandit" is supported for now)
_side = "bandit";

_pos = [5884,2997,10];

// This mission should spawn on server start. Otherwise, if somebody is dumb enough to wait for it to spawn, then they're gonna get killed lol.
//if ([_pos,DMS_StaticMinPlayerDistance] call DMS_fnc_IsPlayerNearby) exitWith {"delay"};


DMS_CrateCase_DiverGear =
[
    [
        "arifle_SDAR_F",
        "arifle_SDAR_F",
        "arifle_SDAR_F",
        "arifle_SDAR_F",
        "arifle_SDAR_F"
    ],
    [
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "20Rnd_556x45_UW_mag",
        "U_O_Wetsuit",
        "U_O_Wetsuit",
        "U_O_Wetsuit",
        "U_O_Wetsuit",
        "U_O_Wetsuit",
        "V_RebreatherIA",
        "V_RebreatherIA",
        "V_RebreatherIA",
        "V_RebreatherIA",
        "V_RebreatherIA"
    ],
    [
        "B_Carryall_oli",
        "B_Bergen_tna_F",
        "B_ViperHarness_oli_F"
    ]
];

// I only made some of the variables in this file "private" because I couldn't bother making all of them private :p
private _crate = ["Box_IND_AmmoVeh_F",[5630,3100,0]] call DMS_fnc_SpawnCrate;
_crate setVariable ["DMS_AllowSmoke", false];


[_crate, "DiverGear"] call DMS_fnc_FillCrate;



private _sub1 = ["Exile_Boat_SDV_CSAT",[0,0,0]] call DMS_fnc_SpawnNonPersistentVehicle;
_sub1 setPosASL [5884,2997,-66];
_sub1 setVariable ["DMS_AllowSmoke", false];

private _sub2 = ["Exile_Boat_SDV_CSAT",[0,0,0]] call DMS_fnc_SpawnNonPersistentVehicle;
_sub2 setPosASL [5893.5,3037,-55];
_sub2 setVariable ["DMS_AllowSmoke", false];



private _diverGearSet =
[
    "arifle_SDAR_F",
    [],
    [["20Rnd_556x45_UW_mag",6]],
    "",
    [],
    ["Rangefinder","ItemGPS","NVGoggles"],
    "",
    "",
    "U_O_Wetsuit",
    "V_RebreatherIA",
    "B_Bergen_mcamo"
];


private _temp = DMS_ai_use_launchers;
DMS_ai_use_launchers = false;

private _diverGroup =
[
    [
        [5850.8,3048.1,-37.8057],
        [5863.21,3036.56,-38.2891],
        [5871.43,3054.4,-39.343],
        [5915.36,3021.77,-58.8748],
        [5905.08,2987.15,-65.313],
        [5877.29,2984.19,-60.6961],
        [5887.88,2986.54,-60.7556],
        [5909.77,3037.79,-52.0807],
        [5878.36,3045.98,-48.1157],
        [5845.63,3028.38,-49.0821],
        [5851.09,3009.14,-52.1915],
        [5856.83,3016.01,-49.785],
        [5869.44,3017.86,-49.7803],
        [5879.65,3022.51,-47.769],
        [5892.57,3030.16,-48.894],
        [5900.21,3031.82,-50.4109],
        [5882.36,3003.04,-55.3779],
        [5858.68,2977.79,-63.6817],
        [5899.83,3044.99,-51.4147],
        [5875.81,3007.73,-55.331],
        [5899.77,2994.57,-61.1307]
    ],
	21,
	"hardcore",
	"custom",
	_side,
    _diverGearSet
] call DMS_fnc_SpawnAIGroup_MultiPos;

DMS_ai_use_launchers = _temp;


{
    _x disableAI "PATH";
} forEach (units _diverGroup);





private _landGroup =
[
	[5633,3108,0],
	5,
	"hardcore",
	"sniper",
	"bandit"
] call DMS_fnc_SpawnAIGroup;



// Define mission-spawned AI Units
_missionAIUnits =
[
	_diverGroup, 		// We only spawned the single group for this mission
    _landGroup
];

// Define the group reinforcements
_groupReinforcementsInfo =
[
    // Removed reinforcements for this because while I was testing the mission the AI took too long to get back to the objective, and that's annoying
    /////////////////////// this was commented out /////////////////////////
	[
		_diverGroup,			// pass the group
		[
			[
				-1,		// Let's limit number of units instead...
				0
			],
			[
				10,	    // Maximum 10 units can be given as reinforcements.
				0
			]
		],
		[
			180,		// About a 3 minute delay between reinforcements.
			diag_tickTime
		],
		[
            [5810,2874,1],
            [5933,2912,2],
            [5862,3132,0.5]
        ],
		"custom",
		"hardcore",
		_side,
		"reinforce",
		[
			5,			// Reinforcements will only trigger if there's fewer than 5 members left in the group
			3			// 3 reinforcement units per wave.
		],
        _diverGearSet
	]
    /////////////////////// this was commented out /////////////////////////
];

// Define mission-spawned objects and loot values
_missionObjs =
[
	[],
	[_sub1, _sub2],
	[
        [
            _sub1,
            [
                1,
                [2,DMS_Box_BaseParts_Concrete],
                1
            ]
        ],
        [
            _sub2,
            [
                [2,DMS_sniper_weps],                // Spawn a random 5 weapons that AI snipers can spawn with.
                [5,DMS_BoxSurvivalSupplies],
                1
            ]
        ]
    ]
];

// Define Mission Start message
_msgStart = ['#FFFF00', "The CSAT are storing money and supplies in an underwater stash! Eliminate them and take the supplies!"];

// Define Mission Win message
_msgWIN = ['#0080ff',"Convicts have successfully eliminated the CSAT and obtained the underwater stash!"];

// Define Mission Lose message
_msgLOSE = ['#FF0000',"Seems like CSAT forces moved their stash away..."];

// Define mission name (for map marker and logging)
_missionName = "Underwater Stash";

// Create Markers
_markers =
[
	_pos,
	_missionName,
	"hardcore"
] call DMS_fnc_CreateMarker;

// Record time here (for logging purposes, otherwise you could just put "diag_tickTime" into the "DMS_AddMissionToMonitor" parameters directly)
_time = diag_tickTime;

// Parse and add mission info to missions monitor
_added =
[
	_pos,
	[
		[
			"kill",
			_diverGroup              // Only need to kill the diver group.
		],
		[
			"playerNear",
			[_sub1,40]
		]
	],
	_groupReinforcementsInfo,
	[
		_time,
		DMS_StaticMissionTimeOut call DMS_fnc_SelectRandomVal
	],
	_missionAIUnits,
	_missionObjs,
	[_missionName,_msgWIN,_msgLOSE],
	_markers,
	_side,
	"hardcore",
	[],
    [
        [
            [
                _sub1,
                {_this setVariable ["ExileMoney",25000,true]}                       // The submarine will have 25,000 poptabs after the mission completes. The capacity is actually 5000, but I just overload it.
            ]
        ],
        [],
        {},
        {}
    ]
] call DMS_fnc_AddMissionToMonitor_Static;

// Check to see if it was added correctly, otherwise delete the stuff
if !(_added) exitWith
{
	diag_log format ["DMS ERROR :: Attempt to set up mission %1 with invalid parameters for DMS_fnc_AddMissionToMonitor_Static! Deleting mission objects and resetting DMS_MissionCount.",_missionName];

	_cleanup = [];
	{
		_cleanup pushBack _x;
	} forEach _missionAIUnits;

	_cleanup pushBack ((_missionObjs select 0)+(_missionObjs select 1));

	{
		_cleanup pushBack (_x select 0);
	} foreach (_missionObjs select 2);

	_cleanup call DMS_fnc_CleanUp;


	// Delete the markers directly
	{deleteMarker _x;} forEach _markers;


	// Reset the mission count
	DMS_MissionCount = DMS_MissionCount - 1;
};


// Notify players
[_missionName,_msgStart] call DMS_fnc_BroadcastMissionStatus;



if (DMS_DEBUG) then
{
	(format ["MISSION: (%1) :: Mission #%2 started at %3 with %4 AI units and %5 difficulty at time %6",_missionName,_num,_pos,26,"hardcore",_time]) call DMS_fnc_DebugLog;
};
*/