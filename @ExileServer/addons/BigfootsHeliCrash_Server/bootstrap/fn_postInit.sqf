/*
 * Bigfoot's Heli Crash - Post Initialization
 * ==========================================
 * 
 * Updated and maintained by:
 *   - sko   | PGM DEV TEAM
 *   - Ghost | PGM DEV TEAM
 * Laods config (config.sqf)
 * AI Initialization
 * Handles water missions
 * Error handling
 * 
 * This script ensures all components of Bigfoot's Heli Crash system initialize correctly.
 * It loads configuration settings, starts AI protection, and schedules reinforcements.
 * 
 * Changes:
 * - Ensures `config.sqf` is loaded before anything else
 * - Adds support for AI protection at heli crash sites
 * - Initializes underwater heli crashes & support assets
 */

if (!isServer) exitWith {};

// Log that postInit has started
"Bigfoot's Heli Crash: PostInit started..." call ExileServer_BigfootsHeliCrash_util_logCommand;

// Load configuration settings
call compile preprocessFileLineNumbers "BigfootsHeliCrash_Server\config.sqf";

// Start main initialization
[] call ExileServer_BigfootsHeliCrash_initialize;

// Schedule AI reinforcements after 15 min if mission not completed
if (BH_AI_reinforce_enable) then {
    [] spawn {
        uiSleep BH_AI_reinforce_time;
        [] call ExileServer_BigfootsHeliCrash_spawnAIReinforcements;
    };
};

// Initialize AI behavior at crash sites
if (BH_AI_enable) then {
    [] spawn ExileServer_BigfootsHeliCrash_spawnAIUnits;
};

// Initialize underwater support assets (Zodiacs, gear crates)
if (BH_vehicle_enableZodiacs) then {
    [] spawn ExileServer_BigfootsHeliCrash_spawnSupportAssets;
};

// Final confirmation log
"Bigfoot's Heli Crash: PostInit complete!" call ExileServer_BigfootsHeliCrash_util_logCommand;
