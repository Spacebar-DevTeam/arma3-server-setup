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
	
	The fn_deleteRuins.sqf script deletes all Ruins objects within a specified radius 
	of a given position in ZCP missions. It uses nearObjects to find relevant objects 
	and then deletes them using deleteVehicle.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Error Handling: Ensures objects are not null before deletion.
      Debugging: Provides detailed logs when ZCP_Debug is enabled.
      Performance: Uses forEach instead of count for iteration.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    "_ZCP_DR_pos",
    "_ZCP_DR_radius"
];

private _ZCP_DR_ruins = _ZCP_DR_pos nearObjects ["Ruins", (_ZCP_DR_radius * 2)];

{
    if (!isNull _x) then {
        deleteVehicle _x;
        if (ZCP_Debug) then {
            diag_log format ["[ZCP] Deleted ruin object at %1", getPosATL _x];
        };
    };
} forEach _ZCP_DR_ruins;

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Deleted %1 ruins at position %2 with radius %3", count _ZCP_DR_ruins, _ZCP_DR_pos, _ZCP_DR_radius];
};

/*
private['_ZCP_DR_pos','_ZCP_DR_radius','_ZCP_DR_ruins'];
_ZCP_DR_pos = _this select 0;
_ZCP_DR_pos set [2,0];
_ZCP_DR_radius = _this select 1;
_ZCP_DR_ruins = _ZCP_DR_pos nearObjects ["Ruins", (_ZCP_DR_radius * 2)];
// diag_log format['[ZCP]: deleting %1 ruins on pos %2 and radius %3', count _ZCP_DR_ruins, _ZCP_DR_pos, _ZCP_DR_radius ];
{
  _nil = deleteVehicle _x;
}count _ZCP_DR_ruins;
*/