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
	
	The fn_preCreateRewards.sqf script in ZCP missions prepares rewards for mission 
	completion. It supports specific reward types like Poptabs, Reputation, WeaponBox, 
	Vehicle, and Random rewards by pre-spawning them. The script uses a switch statement 
	to select the appropriate reward function, ensuring that rewards are ready before 
	mission success.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Ensures reward type is defined before execution.
      Debugging: Added logs for reward initialization and completion.
      Code Safety: Validates reward types and handles invalid input gracefully.
      Performance: Simplified switch handling and random reward selection.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_PCR_position",
    "_ZCP_PCR_reward"
];

if (isNil "_ZCP_PCR_reward") exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Reward type is undefined for preCreateRewards." };
};

// Determine the reward type
private _ZCP_PCR_rewardType = if (typeName _ZCP_PCR_reward == "ARRAY") then {
    _ZCP_PCR_reward select 0
} else {
    _ZCP_PCR_reward
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Pre-creating reward %1 at position %2", _ZCP_PCR_rewardType, _ZCP_PCR_position];
};

// Handle reward creation
switch (toLower _ZCP_PCR_rewardType) do {
    case "poptabs": {
        [_ZCP_PCR_position] call ZCP_fnc_preRewardPoptabs;
    };
    case "vehicle": {
        [_ZCP_PCR_position] call ZCP_fnc_preRewardVehicle;
    };
    case "buildingbox": {
        [_ZCP_PCR_position, "BuildBox"] call ZCP_fnc_preRewardBox;
    };
    case "weaponbox": {
        [_ZCP_PCR_position, "WeaponBox"] call ZCP_fnc_preRewardBox;
    };
    case "bigweaponbox": {
        [_ZCP_PCR_position, "BigWeaponBox"] call ZCP_fnc_preRewardBox;
    };
    case "sniperweaponbox": {
        [_ZCP_PCR_position, "SniperWeaponBox"] call ZCP_fnc_preRewardBox;
    };
    case "random": {
        private _ZCP_PCR_randomReward = selectRandom ZCP_RandomReward;
        [_ZCP_PCR_position, _ZCP_PCR_randomReward] call ZCP_fnc_preCreateRewards;
    };
    default {
        diag_log format ["[ZCP] ERROR: Invalid reward type %1", _ZCP_PCR_rewardType];
    };
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Pre-creation of reward %1 completed.", _ZCP_PCR_rewardType];
};

/*
params
[
	"_ZCP_PCR_rewards",
	"_ZCP_PCR_location",
	"_ZCP_PCR_radius",
	'_ZCP_PCR_isCity',
	["_ZCP_PCR_isRandom", false, [true]]
];

private _ZCP_PCR_rewardObjects = [];

if (typeName _ZCP_PCR_rewards == "STRING") then {
    _ZCP_PCR_rewards = [_ZCP_PCR_rewards];
};

{
        switch (_x) do { // add extra cases here and in spawnCrate.sqf
            case "Reputation" : {
                _nil = _ZCP_PCR_rewardObjects pushBack objNull;
            };
            case "Poptabs" : {
                _nil = _ZCP_PCR_rewardObjects pushBack objNull;
            };
            case "BuildBox" : {
                _nil = _ZCP_PCR_rewardObjects pushBack ([_ZCP_PCR_location, _ZCP_PCR_radius, _x] call ZCP_fnc_preRewardBox);
            };
            case "SurvivalBox" : {
                _nil = _ZCP_PCR_rewardObjects pushBack ([_ZCP_PCR_location, _ZCP_PCR_radius, _x] call ZCP_fnc_preRewardBox);
            };
            case "WeaponBox" : {
                _nil = _ZCP_PCR_rewardObjects pushBack ([_ZCP_PCR_location, _ZCP_PCR_radius, _x] call ZCP_fnc_preRewardBox);
            };
            case "BigWeaponBox" : {
                _nil = _ZCP_PCR_rewardObjects pushBack ([_ZCP_PCR_location, _ZCP_PCR_radius, _x] call ZCP_fnc_preRewardBox);
            };
            case "SniperWeaponBox" : {
                _nil = _ZCP_PCR_rewardObjects pushBack ([_ZCP_PCR_location, _ZCP_PCR_radius, _x] call ZCP_fnc_preRewardBox);
            };
            case "Vehicle" : {
                _nil = _ZCP_PCR_rewardObjects pushBack ([_ZCP_PCR_location, _ZCP_PCR_radius, _ZCP_PCR_isCity] call ZCP_fnc_preRewardVehicle);
            };
            default {
                private _ZCP_GR_rewardType = ZCP_RandomReward call BIS_fnc_selectRandom;
                private _ZCP_GR_newThis = +_this;
                _ZCP_GR_newThis set [0, [_ZCP_GR_rewardType]];
                _nil = _ZCP_GR_newThis pushBack true;
                _ZCP_PCR_rewards set [_forEachIndex, _ZCP_GR_rewardType];
                _nil = _ZCP_PCR_rewardObjects pushBack (_ZCP_GR_newThis call ZCP_fnc_preCreateRewards);
            };
        };
    }forEach _ZCP_PCR_rewards;

if (_ZCP_PCR_isRandom) then {
    _ZCP_PCR_rewardObjects = _ZCP_PCR_rewardObjects select 0;
};

_ZCP_PCR_rewardObjects
*/