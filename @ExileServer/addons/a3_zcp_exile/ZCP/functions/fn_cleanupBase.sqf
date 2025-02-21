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
	  Error Handling: Added isNull check to avoid trying to delete non-existent objects.
	  Debug Logging: Provides feedback for each object deleted and a completion message.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

{
    if (!isNull _x) then {
        deleteVehicle _x;
        if (ZCP_Debug) then {
            diag_log format ["[ZCP] Deleted base object: %1", _x];
        };
    };
} forEach _this;

if (ZCP_Debug) then {
    diag_log "[ZCP] Base cleanup completed.";
};

/*
{
	_nil = deleteVehicle _x;
}count _this;
*/