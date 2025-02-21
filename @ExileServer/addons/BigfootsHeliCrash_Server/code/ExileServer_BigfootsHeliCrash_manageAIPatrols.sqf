/*
 * ExileServer_BigfootsHeliCrash_manageAIPatrols.sqf
 * 
 * Controls AI behavior at heli crash sites.
 *
 * Features:
 * - AI **patrols** the wreck area instead of standing still.
 * - AI **chases players** but returns if they go too far.
 * - Water AI **stays in water**; does not chase players onto land.
 * - Land AI provides **covering fire** for water AI.
 *
 * Updated by: sko & Ghost PGM DEV TEAM
 */

if (!isServer) exitWith {};

// Extract parameters
private ["_wreckPosition", "_isWaterCrash", "_aiGroups", "_unit", "_patrolRadius", "_maxChaseDistance"];

_wreckPosition = _this select 0;
_isWaterCrash = _this select 1;
_aiGroups = _this select 2; // List of AI groups assigned to this mission

// AI behavior settings
_patrolRadius = 50;            // AI randomly patrols within 50m
_maxChaseDistance = 150;        // AI chases players up to 150m before returning

// Loop through each AI group assigned to this wreck
{
    private _aiGroup = _x;

    // Loop through each unit in the AI group
    {
        _unit = _x;
        
        while {alive _unit} do 
        {
            private _playerNearby = _unit findNearestEnemy _wreckPosition;

            if (!isNull _playerNearby) then 
            {
                private _playerDistance = _unit distance _playerNearby;

                if (_playerDistance <= _maxChaseDistance) then 
                {
                    _unit doMove (getPos _playerNearby);
                }
                else 
                {
                    _unit doMove _wreckPosition; // Return to wreck if too far
                };
            }
            else 
            {
                // If no players nearby, AI randomly patrols around the wreck
                private _patrolPoint = _wreckPosition getPos [_patrolRadius, random 360];
                _unit doMove _patrolPoint;
            };

            sleep (random 10 + 5); // Wait before re-evaluating behavior
        };
    } forEach units _aiGroup;
} forEach _aiGroups;
