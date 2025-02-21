private ["_crate"];
_crate = _this;

// Initialize crate
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;

_crate setVariable ["permaLoot", true]; 
_crate allowDamage false;
_crate enableRopeAttach true;

// Select Loot Type (Randomly Choose Between "Sniper" and "Standard")
private _lootType = selectRandom ["Sniper", "Standard"];

if (_lootType isEqualTo "Sniper") then
{
    diag_log format ["BigfootsHeliCrash :: Spawning Sniper loot in crate %1", _crate];

    private _crateValues = DMS_CrateCase_Sniper;

    if !((_crateValues params ["_weps", "_items", "_backpacks"]))
    exitWith
    {
        diag_log format ["BigfootsHeliCrash ERROR :: Invalid _crateValues for Sniper: %1", _crateValues];
    };

    // Weapons
    {
        if (_x isEqualType "") then
        {
            _x = [_x, 1];
        };
        _crate addWeaponCargoGlobal _x;
    } forEach _crateValues select 0;

    // Items
    {
        if (_x isEqualType "") then
        {
            _x = [_x, 1];
        };
        _crate addItemCargoGlobal _x;
    } forEach _crateValues select 1;

    // Backpacks
    {
        if (_x isEqualType "") then
        {
            _x = [_x, 1];
        };
        _crate addBackpackCargoGlobal _x;
    } forEach _crateValues select 2;

    diag_log format ["BigfootsHeliCrash :: Sniper crate %1 filled with loot.", _crate];
}
else
{
    diag_log format ["BigfootsHeliCrash :: Filling crate %1 with standard loot.", _crate];

    // Example standard loot (adjust as needed)
    _crate addWeaponCargoGlobal ["arifle_MX_F", 2];
    _crate addItemCargoGlobal ["FirstAidKit", 5];
    _crate addBackpackCargoGlobal ["B_AssaultPack_mcamo", 1];
};


/*
private ["_crate"];

_crate = _this;

// Initialize crate
clearMagazineCargoGlobal _crate;
clearWeaponCargoGlobal _crate;
clearItemCargoGlobal _crate;

_crate setVariable ["permaLoot", true]; 
_crate allowDamage false;
_crate enableRopeAttach true;
*/