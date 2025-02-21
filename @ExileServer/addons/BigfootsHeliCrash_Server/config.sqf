/*
 * Bigfoot's Heli Crash - Configuration File
 * =========================================
 * Updated & Maintained by: sko & Ghost PGM DEV TEAM
 *
 * Contains settings for mission behavior, AI, loot, and reinforcements.
 */

/* --- Debugging --- */
BH_debug_logCrateFill = true;       				// Logs crate loot in server .RPT
BH_debug_logAI = true;              				// Logs AI spawn and behavior details

/* --- Mission Settings --- */
BH_count_HeliCrash = 3;             				// Number of helicopter crash sites
BH_count_HeliCrashWater = 2;        				// Number of water helicopter crash sites

/* --- Location Settings --- */
BH_locations_center = [6750, 6750, 0];    			// Approximate center of Chernarus Redux
BH_locations_distance_min = 500;          			// Ensures wrecks can be close to shore
BH_locations_distance_max = 6000;         			// Max distance offshore
BH_locations_shoreGearDropRadius = 200;   			// Distance from shore to drop underwater gear loot box

/* --- AI Settings --- */
BH_AI_enable = true;                 				// Enables AI protecting wrecks
BH_AI_minUnits = 3;                   				// Minimum AI per crash
BH_AI_maxUnits = 8;                   				// Maximum AI per crash
BH_AI_difficulty = "hard";            				// AI skill level: ["easy", "medium", "hard", "insane"]
BH_AI_radioChatter = true;            				// AI sends radio warnings to players in range

/* --- AI Reinforcements --- */
BH_AI_reinforce_enable = true;        				// Allow backup squads to arrive after 15 min if loot remains
BH_AI_reinforce_min = 3;              				// Min reinforcements
BH_AI_reinforce_max = 6;              				// Max reinforcements
BH_AI_reinforce_time = 900;           				// Time in seconds before reinforcements arrive (15 min)

/* --- AI for Water Missions --- */
BH_AI_water_enable = true;            				// AI spawns for underwater crashes
BH_AI_water_min = 2;                 				// Minimum AI for underwater missions
BH_AI_water_max = 5;                  				// Maximum AI for underwater missions
BH_AI_water_persist = true;           				// Water AI remain near the mission if players respawn

/* --- Loot Settings --- */
BH_loot_enablePoptabs = true;						// Enable poptabs in crates
BH_loot_count_poptabs_seed = [500, 5000, 50000];   	// Min/mid/max poptabs

/* --- Vehicle Spawning --- */
BH_vehicle_enableZodiacs = true;      				// Spawns Zodiacs near shore
BH_vehicle_zodiacCount = 3;           				// Number of Zodiacs per water mission
BH_vehicle_cleanupTime = 900;         				// Time in seconds before unoccupied vehicles despawn

/* --- Loot Crates --- */
BH_loot_gearBox_enable = true;        				// Drops an underwater gear box near shore for water missions
BH_loot_gearBox_class = "Box_IND_Ammo_F"; 			// Class of the loot box
BH_loot_gearBox_items = [
    ["V_RebreatherB", 1], 
    ["G_Diving", 1], 
    ["NVGoggles_OPFOR", 1], 
    ["arifle_SDAR_F", 1],
    ["20Rnd_556x45_UW_mag", 3]
];

/* --- Markers --- */
BH_marker_colorLand = "ColorRed";     				// Marker color for land crashes
BH_marker_colorWater = "ColorBlue";   				// Marker color for water crashes

/* --- Public Variables --- */
publicVariable "BH_debug_logCrateFill";
publicVariable "BH_debug_logAI";
publicVariable "BH_count_HeliCrash";
publicVariable "BH_count_HeliCrashWater";
publicVariable "BH_locations_center";
publicVariable "BH_locations_distance_min";
publicVariable "BH_locations_distance_max";
publicVariable "BH_locations_shoreGearDropRadius";
publicVariable "BH_AI_enable";
publicVariable "BH_AI_minUnits";
publicVariable "BH_AI_maxUnits";
publicVariable "BH_AI_difficulty";
publicVariable "BH_AI_radioChatter";
publicVariable "BH_AI_reinforce_enable";
publicVariable "BH_AI_reinforce_min";
publicVariable "BH_AI_reinforce_max";
publicVariable "BH_AI_reinforce_time";
publicVariable "BH_AI_water_enable";
publicVariable "BH_AI_water_min";
publicVariable "BH_AI_water_max";
publicVariable "BH_AI_water_persist";
publicVariable "BH_loot_enablePoptabs";
publicVariable "BH_loot_count_poptabs_seed";
publicVariable "BH_vehicle_enableZodiacs";
publicVariable "BH_vehicle_zodiacCount";
publicVariable "BH_vehicle_cleanupTime";
publicVariable "BH_loot_gearBox_enable";
publicVariable "BH_loot_gearBox_class";
publicVariable "BH_loot_gearBox_items";
publicVariable "BH_marker_colorLand";
publicVariable "BH_marker_colorWater";
