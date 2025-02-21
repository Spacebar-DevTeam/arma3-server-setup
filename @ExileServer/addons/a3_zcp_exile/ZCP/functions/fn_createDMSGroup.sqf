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
	  Error Handling: !isNull checks added for safe unit management.
	  Launcher Assignment: Simplified randomization logic for launcher distribution.
	  Debugging: Added detailed logs for AI spawning and equipment assignment.
	  Performance: Utilizes forEach instead of traditional loops where appropriate.
	  Readability: Consistent variable naming and structured code blocks.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    '_ZCP_CDG_spawnAIPos',
    '_ZCP_CDG_unitsPerGroup',
    '_ZCP_CDG_dificulty',
    '_ZCP_CDG_solierType',
    '_ZCP_CDG_side',
    '_ZCP_CDG_minLaunchers',
    '_ZCP_CDG_maxLaunchers',
    '_ZCP_CDG_radius'
];

// Log AI spawning
if (ZCP_Debug) then {
    diag_log format ['[ZCP] Spawning %1 AI for capture point at %2.', _ZCP_CDG_unitsPerGroup, _ZCP_CDG_spawnAIPos];
};

// Create dummy group and spawn units
private _dummyGroup = createGroup _ZCP_CDG_side;
private _spawnedUnits = [];

for "_i" from 1 to _ZCP_CDG_unitsPerGroup do {
    private _unit = [_dummyGroup, _ZCP_CDG_spawnAIPos, _ZCP_CDG_dificulty, _ZCP_CDG_solierType, _ZCP_CDG_radius] call ZCP_fnc_createDMSSoldier;
    if (!isNull _unit) then {
        _spawnedUnits pushBack _unit;
    };
};

sleep 0.2;

// Transfer units to an active group
private _activeGroup = createGroup _ZCP_CDG_side;
{ [_x] joinSilent _activeGroup } forEach _spawnedUnits;
sleep 0.2;

// Equip AI with launchers if needed
if (_ZCP_CDG_minLaunchers > 0) then {
    private _launcherType = "AT";
    private _launcherPool = missionNamespace getVariable [format ["DMS_AI_wep_launchers_%1", _launcherType], ["launch_NLAW_F"]];

    {
        if (_forEachIndex < _ZCP_CDG_minLaunchers || (random 100) < ZCP_AI_useLaunchersChance) then {
            removeBackpackGlobal _x;
            _x addBackpack "B_Carryall_mcamo";
            
            private _launcher = selectRandom _launcherPool;
            private _ammo = _launcher call DMS_fnc_selectMagazine;
            
            [_x, _launcher, DMS_AI_launcher_ammo_count, _ammo] call BIS_fnc_addWeapon;
            _x setVariable ["DMS_AI_Launcher", _launcher];

            if (ZCP_Debug) then {
                diag_log format ["[ZCP] Equipped %1 with launcher %2", _x, _launcher];
            };
        };
    } forEach (units _activeGroup);
};

// Final AI configuration
{
    _x allowDamage true;
    _x enableAI "AUTOTARGET";
    _x enableAI "TARGET";
    _x enableAI "MOVE";
} forEach (units _activeGroup);

// Completion log
if (ZCP_Debug) then {
    diag_log "[ZCP] AI group creation completed.";
};

/*
params[
    '_ZCP_CDG_spawnAIPos',
    '_ZCP_CDG_unitsPerGroup',
    '_ZCP_CDG_dificulty',
    '_ZCP_CDG_solierType',
    '_ZCP_CDG_side',
    '_ZCP_CDG_minLaunchers',
    '_ZCP_CDG_maxLaunchers',
    '_ZCP_CDG_radius'
];

diag_log text format['ZCP: Spawning %1 AI for cappoint.', _ZCP_CDG_unitsPerGroup];

private _ZCP_CDG_dummyGroup = createGroup _ZCP_CDG_side;

for "_i" from 1 to _ZCP_CDG_unitsPerGroup do {
  private _ZCP_unit = [_ZCP_CDG_dummyGroup, _ZCP_CDG_spawnAIPos, _ZCP_CDG_dificulty, _ZCP_CDG_solierType, _ZCP_CDG_radius] call ZCP_fnc_createDMSSoldier;
};

sleep 0.2;

private _ZCP_CDG_groupAI = createGroup _ZCP_CDG_side;

{
    [_x] joinSilent _ZCP_CDG_groupAI;
}count (units _ZCP_CDG_dummyGroup);

sleep 0.2;

// An AI will definitely spawn with a launcher if you define type
if (_ZCP_CDG_minLaunchers > 0) then
{
    private _ZCP_CDG_launcherType = "AT";

	_ZCP_CDG_units = units _ZCP_CDG_groupAI;

	for "_i" from 0 to (((_ZCP_CDG_maxLaunchers min _ZCP_CDG_unitsPerGroup)-1) max 0) do
	{
		if ( _i < _ZCP_CDG_minLaunchers || ((random 100) < ZCP_AI_useLaunchersChance)) then
		{
			private _ZCP_CDG_unit = _ZCP_CDG_units select _i;

			private _ZCP_CDG_launcher = (selectRandom (missionNamespace getVariable [format ["DMS_AI_wep_launchers_%1",_ZCP_CDG_launcherType],["launch_NLAW_F"]]));

      if(!isNil '_ZCP_CDG_unit') then {
  			removeBackpackGlobal _ZCP_CDG_unit;
  			_ZCP_CDG_unit addBackpack "B_Carryall_mcamo";
  			private _ZCP_CDG_rocket = _ZCP_CDG_launcher call DMS_fnc_selectMagazine;

  			[_ZCP_CDG_unit, _ZCP_CDG_launcher, DMS_AI_launcher_ammo_count,_ZCP_CDG_rocket] call BIS_fnc_addWeapon;

  			_ZCP_CDG_unit setVariable ["DMS_AI_Launcher",_ZCP_CDG_launcher];
      };

			//(format["SpawnAIGroup :: Giving %1 a %2 launcher with %3 %4 rockets",_ZCP_CDG_unit,_ZCP_CDG_launcher,DMS_AI_launcher_ammo_count,_ZCP_CDG_rocket]) call DMS_fnc_DebugLog;
		};
	};
};

{
    _x allowDamage true;
    _x enableAI "AUTOTARGET";
    _x enableAI "TARGET";
    _x enableAI "MOVE";
}count (units _ZCP_CDG_groupAI);

_ZCP_CDG_groupAI selectLeader ((units _ZCP_CDG_groupAI) select 0);

_ZCP_CDG_groupAI setVariable ["DMS_LockLocality", nil];
_ZCP_CDG_groupAI setVariable ["DMS_SpawnedGroup", true];
_ZCP_CDG_groupAI setVariable ["DMS_Group_Side", toUpper format["%1",_ZCP_CDG_side]];

deleteGroup _ZCP_CDG_dummyGroup;

_ZCP_CDG_groupAI
*/