/*
 * This file is subject to the terms and conditions defined in
 * file 'APL-SA LICENSE.txt', which is part of this source code package.
 */




/////// This Code modified by Ketanna to automatically populate the map center and 2 water depth variables were added to allow player the ability to 
//////  declare how deep or how shallow the ship wrecks occure. The ship wreck icon was also changed to show only a blue ship icon.


BS_debug_logCrateFill = true; // True to log items spawned in crates to server .RPT, usually right after [Display #24]

BS_player_showCrateClaimMessage = true; // True to show toast and chat notification with coordinates to all players when any players are close to crate
BS_player_showCrateClaimMessageRadius = 20; // Players must be this close (in meters) to trigger serverwide chat/toast notification

BS_class_crate = "Exile_Container_SupplyBox"; // Class of loot crate.
BS_class_wreckage = "Land_UWreck_FishingBoat_F"; // Class of shipwreck.

BS_count_shipwrecks = 3; // Total wrecks



BS_locations_crateWreckOffset = 10; // Distance from wreck to spawn crate.

/////////////////////////// AUTO Map Configure added by Ketanna  /////////////////////
///////// This script automatically finds the map center and calculates where to place crates. 
private _MapCenter = worldSize / 2;
BS_locations_center = [_MapCenter,_MapCenter,0];     /// this code automatically finds the map center
BS_locations_distance_min = 0; // Minimum distance from BS_location_center to spawn crate.
BS_locations_distance_max =  _MapCenter - 2000;  /// this code automatically adjust the max distance from the edge of the map by 2000

////////////// Water Depth check for crate spawns added by Ketanna  ////////////////
///// This script based on your settings will limit how deep or shallow the water is where the crates spawn... no more deep deep water if desired
BS_locations_WaterDepth_max = 25;   /// the max water depth you want your crates to spawn in 
BS_locations_WaterDepth_MIN = 5;	   /// the min water depth you want your crates to spawn in



BS_loot_enablePoptabs = true; // True to spawn random number of poptabs in crates, otherwise false.
BS_loot_count_poptabs_seed = [1000, 2500, 5000]; // min/mid/max, so will spawn around 5k most of the time with small chance to be much closer to 18k and small chance to be closer to 3k

BS_loot_itemCargo = // Items to put in loot crate.
[   // [class (if array, picks one random item), guaranteed amount, possible random additional amount, % chance of spawning additional random amount]


	["CUP_item_CDF_dogtags", 1, 2, 30],
	
	["Exile_Item_Cement", 3, 4, 50],
	["Exile_Item_Sand", 3, 5, 50],
	["Exile_Item_FuelCanisterEmpty", 0, 2, 50],
	
	
	["Exile_Item_Codelock", 0, 2, 30],
	["Exile_Item_PortableGeneratorKit", 0, 1, 15],
	
	["Exile_Item_InstaDoc", 1, 2, 25],

    ["Exile_Item_DuctTape", 5, 5, 100],
    ["Exile_Item_PlasticBottleFreshWater", 5, 2, 100],
    ["Exile_Item_EMRE", 0, 2, 100],
	
	
    [["V_RebreatherB", "V_RebreatherIA", "V_RebreatherIR"], 1, 1, 100],
    [["G_Diving", "G_B_Diving", "G_O_Diving", "G_I_Diving"], 1, 1, 100],	
    [["NVGoggles", "NVGoggles_INDEP", "NVGoggles_OPFOR"], 1, 2, 100],
	
    ["Exile_Item_ConcreteWallKit", 4, 1, 25],
    ["Exile_Item_ConcreteFloorKit", 3, 1, 25],
    ["Exile_Item_FortificationUpgrade", 1, 2, 50],
	
    ["Exile_Item_RubberDuck", 0, 2, 14], // No ducks guaranteed, but 14% of the time, an additional 0-2 ducks could spawn.
    ["Exile_Item_Knife", 0, 1, 50]	// No knives guaranteed, but 25% of the time an additional 0-1 knives could spawn.
	//["APERSBoundingMine_Range_Mag", 4, 2, 50]
]; 

publicVariable "BS_debug_logCrateFill";
publicVariable "BS_player_showCrateClaimMessage";
publicVariable "BS_player_showCrateClaimMessageRadius";
publicVariable "BS_class_crate";
publicVariable "BS_class_wreckage";
publicVariable "BS_count_shipwrecks";
publicVariable "BS_locations_crateWreckOffset";
publicVariable "BS_locations_center";
publicVariable "BS_locations_distance_min";
publicVariable "BS_locations_distance_max";
publicVariable "BS_loot_enablePoptabs";
publicVariable "BS_loot_count_poptabs_seed";
publicVariable "BS_loot_itemCargo";