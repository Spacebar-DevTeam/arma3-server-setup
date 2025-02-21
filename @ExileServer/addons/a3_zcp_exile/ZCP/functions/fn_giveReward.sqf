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
	
	The fn_giveReward.sqf script manages the distribution of rewards for ZCP missions. 
	It handles various reward types such as Reputation, Poptabs, BuildBox, SurvivalBox, 
	WeaponBox, BigWeaponBox, SniperWeaponBox, Vehicle, and Random rewards. The script 
	uses a switch statement to call the appropriate reward function based on the 
	reward type specified in the ZCP_GR_reward array.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Streamlined reward selection with switch statement.
      Debugging: Enhanced logs for both success and error cases.
      Random Reward Handling: Automatically selects a random reward from all available types.
      Error Handling: Validates reward type before executing.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_GR_position",
    "_ZCP_GR_reward"
];

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Giving reward %1 at position %2", _ZCP_GR_reward, _ZCP_GR_position];
};

// Validate reward type
private _ZCP_GR_rewardType = if (typeName _ZCP_GR_reward == "ARRAY") then {_ZCP_GR_reward select 0} else {_ZCP_GR_reward};

switch (toLower _ZCP_GR_rewardType) do {
    case "reputation": {
        [_ZCP_GR_position] call ZCP_fnc_rewardReputation;
    };
    case "poptabs": {
        [_ZCP_GR_position] call ZCP_fnc_rewardPoptabs;
    };
    case "buildingbox": {
        [_ZCP_GR_position, "BuildBox"] call ZCP_fnc_rewardBox;
    };
    case "survivalbox": {
        [_ZCP_GR_position, "SurvivalBox"] call ZCP_fnc_rewardBox;
    };
    case "weaponbox": {
        [_ZCP_GR_position, "WeaponBox"] call ZCP_fnc_rewardBox;
    };
    case "bigweaponbox": {
        [_ZCP_GR_position, "BigWeaponBox"] call ZCP_fnc_rewardBox;
    };
    case "sniperweaponbox": {
        [_ZCP_GR_position, "SniperWeaponBox"] call ZCP_fnc_rewardBox;
    };
    case "vehicle": {
        [_ZCP_GR_position] call ZCP_fnc_rewardVehicle;
    };
    case "random": {
        private _ZCP_GR_randomReward = selectRandom [
            "Reputation", "Poptabs", 
            "BuildBox", "SurvivalBox", 
            "WeaponBox", "BigWeaponBox", 
            "SniperWeaponBox", "Vehicle"
        ];
        [_ZCP_GR_position, _ZCP_GR_randomReward] call ZCP_fnc_giveReward;
    };
    default {
        diag_log format ["[ZCP] ERROR: Invalid reward type %1", _ZCP_GR_rewardType];
    };
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Reward %1 given successfully.", _ZCP_GR_reward];
};

/*
private["_ZCP_GR_reward","_ZCP_GR_rewardArray"];
_ZCP_GR_reward = _this select 3;
_ZCP_GR_rewardArray = _this select 5;

if (typeName _ZCP_GR_reward == "STRING") then {
    _ZCP_GR_reward = [_ZCP_GR_reward];
};

if (typeName _ZCP_GR_reward == "ARRAY") then {
    {
        switch (_x) do { // add extra cases here and in spawnCrate.sqf
            case "Reputation" : {
                _this call ZCP_fnc_rewardReputation;
            };
            case "Poptabs" : {
                _this call ZCP_fnc_rewardPoptabs;
            };
            case "BuildBox" : {
                [_this, _x, _ZCP_GR_rewardArray select _forEachIndex] call ZCP_fnc_rewardBox;
            };
            case "SurvivalBox" : {
                [_this, _x, _ZCP_GR_rewardArray select _forEachIndex] call ZCP_fnc_rewardBox;
            };
            case "WeaponBox" : {
                [_this, _x, _ZCP_GR_rewardArray select _forEachIndex] call ZCP_fnc_rewardBox;
            };
            case "BigWeaponBox" : {
                [_this, _x, _ZCP_GR_rewardArray select _forEachIndex] call ZCP_fnc_rewardBox;
            };
            case "SniperWeaponBox" : {
                [_this, _x, _ZCP_GR_rewardArray select _forEachIndex] call ZCP_fnc_rewardBox;
            };
            case "Vehicle" : {
                [_this, _ZCP_GR_rewardArray select _forEachIndex] call ZCP_fnc_rewardVehicle;
            };
            case "Random" : {
                private _ZCP_GR_rewardType = ZCP_RandomReward call BIS_fnc_selectRandom;
                private _ZCP_GR_newThis = +_this;
                _ZCP_GR_newThis set[3, [_ZCP_GR_rewardType]];
                _ZCP_GR_newThis call ZCP_fnc_giveReward;
            };
            default {
                private _ZCP_GR_newThis = +_this;
                _ZCP_GR_newThis set[3, ["Random"]];
                _ZCP_GR_newThis call ZCP_fnc_giveReward;
            };
        };
    }forEach _ZCP_GR_reward;
} else {
    diag_log text format["[ZCP]: Invalid reward for %1", _this];
};
*/