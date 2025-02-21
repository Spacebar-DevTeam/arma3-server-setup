/*
 * Bigfoot's Heli Crash - Initialization Script
 * ============================================
 * 
 * Updated & Maintained by: sko & Ghost PGM DEV TEAM
 * 
 * This script initializes the heli crash spawner, AI protection, and loot mechanics.
 * It handles both **land-based** and **underwater** heli crash sites, ensuring dynamic 
 * and engaging encounters for players.
 *
 * What This Script Does
 * - Spawns heli wrecks with loot crates at **random land & water locations**.
 * - Creates **AI guards** at crash sites (configurable).
 * - Supports **AI reinforcements** if players take too long.
 * - Spawns **Zodiacs & shore loot boxes** for water missions.
 * - Uses **separate markers** for **land vs. water** heli crashes.
 * - Handles **marker cleanup** and **global notifications** when loot is claimed.
 * 
 * Configurable Variables (from `config.sqf`)
 * ----------------------------------------------
 * - **General Settings**
 *   - `BH_count_HeliCrash`              → Number of land heli crashes per cycle
 *   - `BH_count_HeliCrashWater`         → Number of water heli crashes per cycle
 *   - `BH_locations_center`             → Map center for wreck spawning
 *   - `BH_locations_distance_min`       → Minimum spawn distance from center
 *   - `BH_locations_distance_max`       → Maximum spawn distance from center
 * 
 * - Loot & Crates
 *   - `BH_class_wreckage`               → List of possible wreck models
 *   - `BH_class_crate`                  → List of possible crate types
 *   - `BH_loot_itemCargo`               → Loot items configuration
 *   - `BH_loot_count_poptabs_seed`      → Pop-tab reward configuration
 *   - `BH_loot_enablePoptabs`           → Enable/disable pop-tab rewards
 * 
 * - AI Protection
 *   - `BH_AI_enable`                    → Enable AI at crash sites
 *   - `BH_AI_minUnits` / `BH_AI_maxUnits` → AI unit count per site
 *   - `BH_AI_difficulty`                → AI skill level ["easy", "medium", "hard", "insane"]
 *   - `BH_AI_water_enable`              → Enable AI at **underwater** crashes
 *   - `BH_AI_water_persist`             → AI behavior when players respawn
 * 
 * - Reinforcements
 *   - `BH_AI_reinforce_enable`          → Allow AI reinforcements
 *   - `BH_AI_reinforce_time`            → Time before reinforcements arrive (in seconds)
 *   - `BH_AI_reinforce_min` / `BH_AI_reinforce_max` → AI reinforcement unit count
 * 
 * - Vehicles & Gear
 *   - `BH_vehicle_enableZodiacs`        → Enable Zodiac boat spawns for water crashes
 *   - `BH_vehicle_zodiacCount`          → Number of Zodiacs spawned
 *   - `BH_vehicle_cleanupTime`          → Despawn timer for unused vehicles
 *   - `BH_loot_gearBox_enable`          → Enable shore loot box for diving gear
 * 
 * - Marker & Notification Settings
 *   - `BH_marker_colorLand` / `BH_marker_colorWater` → Map marker colors for wrecks
 *   - `BH_player_showCrateClaimMessage` → Enable/disable global crate claim messages
 *   - `BH_player_showCrateClaimMessageRadius` → Player proximity required for claim message
 * 
 */
if (!isServer) exitWith {};

// Log initialization start
["Bigfoot's Heli Crash (SERVER): Starting initialization..."] call ExileServer_BigfootsHeliCrash_util_logCommand;

// Validate required configuration variables
private _wreckCount = if (!isNil "BH_count_HeliCrash") then { BH_count_HeliCrash } else { 0 };
private _waterWreckCount = if (!isNil "BH_count_HeliCrashWater") then { BH_count_HeliCrashWater } else { 0 };

if (_wreckCount + _waterWreckCount <= 0) exitWith {
    ["ERROR: No heli crashes are configured to spawn! Check `config.sqf`."] call ExileServer_BigfootsHeliCrash_util_logCommand;
};

// Clear previous wrecks & markers
["Cleaning up old heli crashes..."] call ExileServer_BigfootsHeliCrash_util_logCommand;
[] call ExileServer_BigfootsHeliCrash_cleanupOldCrashes;

// Spawn heli crashes (land & water)
[
    _wreckCount,           // Number of land crashes
    _waterWreckCount,      // Number of water crashes
    BH_locations_center, 
    BH_locations_distance_min, 
    BH_locations_distance_max, 
    BH_class_wreckage, 
    BH_class_crate, 
    BH_loot_itemCargo, 
    BH_loot_count_poptabs_seed, 
    BH_debug_logCrateFill
] call ExileServer_BigfootsHeliCrash_spawnHeliCrashCommand;

// Initialize AI patrols
if (BH_AI_enable) then {
    ["Spawning AI for crash sites..."] call ExileServer_BigfootsHeliCrash_util_logCommand;
    [] spawn ExileServer_BigfootsHeliCrash_spawnAICommand;
};

// Initialize AI reinforcements
if (BH_AI_reinforce_enable) then {
    ["Setting up AI reinforcements..."] call ExileServer_BigfootsHeliCrash_util_logCommand;
    [] spawn ExileServer_BigfootsHeliCrash_spawnAIReinforcements;
};

// Initialize support assets (Zodiacs & shore loot for water crashes)
if (BH_vehicle_enableZodiacs) then {
    ["Deploying support assets for water missions..."] call ExileServer_BigfootsHeliCrash_util_logCommand;
    [] spawn ExileServer_BigfootsHeliCrash_spawnSupportAssets;
};

// Handles marker cleanup and player detection for loot claim notifications
[
    10, 
    ExileServer_BigfootsHeliCrash_maintainHeliCrashCommand, 
    [
        _wreckCount, 
        BH_player_showCrateClaimMessageRadius,
        BH_player_showCrateClaimMessage
    ], 
    true
] call ExileServer_system_thread_addTask;

// Log completion
["Bigfoot's Heli Crash (SERVER): Initialization complete!"] call ExileServer_BigfootsHeliCrash_util_logCommand;

// Broadcast initialization success message to server
["systemChatRequest", ["Bigfoot's Heli Crash Initialized"]] call ExileServer_system_network_send_broadcast;

true;
