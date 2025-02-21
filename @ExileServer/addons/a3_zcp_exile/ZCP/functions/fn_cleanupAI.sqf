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
      Simplification: Removed unnecessary nested loops.
      Target Specific AI: Uses side _x == east to clean up only enemy AI.
      Debugging: Adds optional logs to monitor cleanup operations.
	
	sko & Ghost DEV TEAM
*/
ZCP_Debug = false;

uiSleep ZCP_AI_killAIAfterMissionCompletionTimer;

{
    if (!isNull _x && {alive _x}) then {
        _x setDamage 1;
        if (ZCP_Debug) then {
            diag_log format ["[ZCP] Cleaning up AI unit: %1", _x];
        };
    };
} forEach (allUnits select {side _x == east}); // Only targets enemy AI

if (ZCP_Debug) then {
    diag_log "[ZCP] AI cleanup complete.";
};

/*
uiSleep ZCP_AI_killAIAfterMissionCompletionTimer;
{
    private['_y'];
    _y = _x;
    {
        if( !isNull _x && alive _x) then
        {
             _x setDamage 1;
        };
    }count (units _y);
}forEach _this;
*/