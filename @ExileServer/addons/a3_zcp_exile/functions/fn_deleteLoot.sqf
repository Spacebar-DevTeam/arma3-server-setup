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
	
	The fn_deleteLoot.sqf script deletes loot objects within a ZCP mission area by iterating 
	through objects in the defined radius. It targets specific loot types and removes them 
	to clean up the mission zone, ensuring performance and reducing clutter.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Simplified Logic: Directly filters and deletes loot objects.
      Debugging: Provides detailed logs for deleted objects.
      Code Safety: Added !isNull check before deletion.
      Performance: Uses nearObjects with filtering for efficiency.
	
	sko & Ghost PGM DEV TEAM
*/
ZCP_Debug = false;

params [
    "_ZCP_DL_position",
    "_ZCP_DL_radius"
];

private _ZCP_DL_lootTypes = [
    "WeaponHolderSimulated",
    "WeaponHolder",
    "GroundWeaponHolder",
    "Land_CargoBox_V1_F",
    "Land_CargoBox_V2_F",
    "Exile_Container_Abstract",
    "Exile_Item_Base"
];

private _ZCP_DL_nearLoot = (_ZCP_DL_position nearObjects _ZCP_DL_radius) select {
    (typeOf _x) in _ZCP_DL_lootTypes
};

{
    if (!isNull _x) then {
        deleteVehicle _x;
        if (ZCP_Debug) then {
            diag_log format ["[ZCP] Deleted loot object: %1 at %2", typeOf _x, getPosATL _x];
        };
    };
} forEach _ZCP_DL_nearLoot;

if (ZCP_Debug) then {
    diag_log "[ZCP] Loot cleanup completed.";
};

/*
private['_ZCP_DL_pos','_ZCP_DL_radius','_ZCP_DL_loot','_lootToDelete'];
_ZCP_DL_pos = _this select 0;
_ZCP_DL_pos set [2,0];
_ZCP_DL_radius = _this select 1;
_ZCP_DL_loot = _ZCP_DL_pos nearObjects ["LootWeaponHolder", (_ZCP_DL_radius * 2)];
// diag_log format['[ZCP]: deleting %1 loot on pos %2 and radius %3', count _ZCP_DL_loot, _ZCP_DL_pos, _ZCP_DL_radius ];
{
  if(((getPosATL _x) select 2) > 0.5 ) then {
     _nil = deleteVehicle _x;
  };
}count _ZCP_DL_loot;
*/