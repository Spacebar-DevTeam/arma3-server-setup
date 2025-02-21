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
	
	The fn_rewardReputation.sqf script in ZCP missions rewards all online players with 
	Reputation points upon mission completion. It calculates the reward, distributes it to 
	eligible players, and logs the process for debugging purposes. The script ensures the 
	reward is only applied to active players and provides clear notifications for both players 
	and server logs.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Validates reputation amount and player eligibility before proceeding.
      Debugging: Provides detailed logs for reward distribution and errors.
      Performance: Uses remoteExec for efficient player notifications.
      Code Clarity: Clear separation of reward logic and debugging output.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    ["_ZCP_RR_amount", 500, [0]]
];

if (_ZCP_RR_amount <= 0) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid reputation amount provided to fn_rewardReputation.sqf"; };
};

private _ZCP_RR_players = allPlayers select {alive _x && isPlayer _x};

if (count _ZCP_RR_players == 0) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] No eligible players online for reputation reward."; };
};

// Distribute reputation points to all eligible players
{
    _x addScore _ZCP_RR_amount;
    [_x, format ["You have received %1 reputation points!", _ZCP_RR_amount]] remoteExec ["hint", _x];
} forEach _ZCP_RR_players;

// Server-side notification
["Server", format ["All online players received %1 reputation points as a reward.", _ZCP_RR_amount]] remoteExec ["hint", -2];

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Distributed %1 reputation points to %2 players.", _ZCP_RR_amount, count _ZCP_RR_players];
};

/*
private['_ZCP_RR_awardToGive','_ZCP_RR_playerScore','_ZCP_RR_currentCapper'];

_ZCP_RR_currentCapper = _this select 0;

_ZCP_RR_awardToGive = ZCP_MinReputationReward + (ZCP_ReputationReward) * (count playableUnits);
_ZCP_RR_playerScore = _ZCP_RR_currentCapper getVariable ["ExileScore", 0];
_ZCP_RR_playerScore = _ZCP_RR_playerScore + _ZCP_RR_awardToGive;

_ZCP_RR_currentCapper setVariable ["ExileScore",_ZCP_RR_playerScore];
_ZCP_RR_currentCapper setVariable['PLAYER_STATS_VAR', [_ZCP_RR_currentCapper getVariable ['ExileMoney', 0], _ZCP_RR_playerScore],true];

format["setAccountScore:%1:%2", _ZCP_RR_playerScore,getPlayerUID _ZCP_RR_currentCapper] call ExileServer_system_database_query_fireAndForget;

['Reputation',[_ZCP_RR_currentCapper, "showFragRequest", [[[format ["ZCP %1", [9] call ZCP_fnc_translate],_ZCP_RR_awardToGive]]]]] call ZCP_fnc_showNotification;

ExileClientPlayerScore = _ZCP_RR_playerScore;
(owner _ZCP_RR_currentCapper) publicVariableClient "ExileClientPlayerScore";
ExileClientPlayerScore = nil;

_ZCP_RR_currentCapper call ExileServer_object_player_database_update;

if( ZCP_ReputationRewardForGroup > 0 ) then {
  private['_ZCP_RR_capperGroup','_ZCP_RR_newScore'];
  _ZCP_RR_capperGroup = group _ZCP_RR_currentCapper;
  if( _ZCP_RR_capperGroup != grpNull ) then {
    {
      if (_x != _ZCP_RR_currentCapper && _x distance2D _ZCP_RR_currentCapper < ZCP_CONFIG_GroupDistanceForRespect ) then {
        _ZCP_RR_newScore = (_x getVariable ["ExileScore", 0]) + ZCP_ReputationRewardForGroup;
        _x setVariable ["ExileScore", _ZCP_RR_newScore ];
        _x setVariable['PLAYER_STATS_VAR', [_x getVariable ['ExileMoney', 0], _ZCP_RR_newScore],true];
        format["setAccountScore:%1:%2", _ZCP_RR_newScore, getPlayerUID _x] call ExileServer_system_database_query_fireAndForget;
        _x call ExileServer_object_player_database_update;

        ExileClientPlayerScore = _ZCP_RR_newScore;
        (owner _x) publicVariableClient "ExileClientPlayerScore";
        ExileClientPlayerScore = nil;

        ['Reputation', [_x, "showFragRequest", [[[format ["ZCP %1", [10] call ZCP_fnc_translate],ZCP_ReputationRewardForGroup]]]]] call ZCP_fnc_showNotification;
      }
    }count (units _ZCP_RR_capperGroup);
  };
};
*/