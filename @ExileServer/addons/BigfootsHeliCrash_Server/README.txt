# **Bigfoot's Heli Crash - Experimental Version**  
### **Enhanced Heli Crash Missions with AI, Water Crashes, and Reinforcements**  

**Updated & Maintained by:** sko & Ghost | PGM DEV TEAM  

## **Overview**  

Bigfoot’s Heli Crash spawner creates dynamic land and underwater helicopter crash missions in Exile.  
This mod is **server-side only** and does **not require** players to download anything.  

This version expands the original system with:  

- **Land & Water-Based Heli Crashes**  
- **AI Protection & Reinforcements**  
- **Balanced Loot & Underwater Gear Spawns**  
- **Dynamic AI Scaling Based on Player Count**  
- **Radio Chatter for Tactical Awareness**  
- **Configurable Settings in `config.sqf`**  

## **Features & Enhancements**  

### **Land & Water Crashes**  
- Crashes spawn on both **land and water**.  
- **Different map markers** for land and water crashes.  

### **AI Protection & Scaling**  
- AI **guard the wreckage** and **engage all factions**.  
- AI **difficulty and count scale dynamically** with server population.  
- **Underwater AI patrol the wreck** but return if players leave the area.  
- **Land AI defend loot crates** and call reinforcements if attacked.  

### **AI Reinforcements (Land, Air, & Sea)**  
- If players take too long, reinforcements may arrive via:  
  - **Land** (APCs, Infantry)  
  - **Air** (Helicopters)  
  - **Sea** (Gunboats, Divers)  

### **Zodiac Boats & Shore Gear Drops**  
- **Underwater missions spawn Zodiacs (3 boats) near shore** for transport.  
- **Shore loot box spawns diving gear** for underwater wreck retrieval.  
- **Unused boats & loot despawn** after a set time.  

### **AI Radio Chatter & Player Alerts**  
- Players with **XM8 or radios** receive **AI warnings and battle updates**.  
- **Strategic alerts help players decide whether to engage or avoid.**  

## **Installation Guide**  

1. **Download & Pack**  
   - Use a PBO manager to pack `BigfootsHeliCrash_Server_Experimental` into a `.pbo` file.  

2. **Deploy to Server**  
   - Place the `.pbo` file inside:  
     ```
     @ExileServer/addons/
     ```

3. **Restart the Server**  
   - The mod runs automatically upon **server startup**.  

4. **Adjust Settings (Optional)**  
   - Configure AI behavior, loot, difficulty, and spawn rates in:  
     ```
     BigfootsHeliCrash_Server/config.sqf
     ```

## **Configuration (`config.sqf`)**  

### **General Settings**  
- `BH_count_HeliCrash` - Number of **land** heli crash missions per cycle.  
- `BH_count_HeliCrashWater` - Number of **water-based** heli crashes per cycle.  
- `BH_debug_logCrateFill` - Enables logging of crate contents.  

### **AI Settings**  
- `BH_AI_enable` - Enable/Disable AI guarding crash sites.  
- `BH_AI_minUnits` - Minimum AI per crash.  
- `BH_AI_maxUnits` - Maximum AI per crash.  
- `BH_AI_difficulty` - AI skill level (`easy`, `medium`, `hard`, `insane`).  
- `BH_AI_radioChatter` - Enables AI communication messages.  

### **AI Reinforcements**  
- `BH_AI_reinforce_enable` - Enable backup AI squads.  
- `BH_AI_reinforce_min` - Minimum reinforcements.  
- `BH_AI_reinforce_max` - Maximum reinforcements.  
- `BH_AI_reinforce_time` - Time in seconds before reinforcements arrive.  

### **AI for Water Missions**  
- `BH_AI_water_enable` - Enable AI for underwater missions.  
- `BH_AI_water_min` - Minimum AI for underwater missions.  
- `BH_AI_water_max` - Maximum AI for underwater missions.  
- `BH_AI_water_persist` - Water AI return to mission area after combat.  

### **Vehicle Spawning**  
- `BH_vehicle_enableZodiacs` - Enable Zodiac spawns for water missions.  
- `BH_vehicle_zodiacCount` - Number of Zodiacs per mission.  
- `BH_vehicle_cleanupTime` - Time before unused vehicles despawn.  

### **Loot Settings**  
- `BH_loot_enablePoptabs` - Enable poptabs in crates.  
- `BH_loot_count_poptabs_seed` - Randomized poptab spawn values.  
- `BH_loot_gearBox_enable` - Spawns an **underwater gear box** near shore.  
- `BH_loot_gearBox_items` - Items found in the gear box.  

### **Markers**  
- `BH_marker_colorLand` - Color of markers for land crashes.  
- `BH_marker_colorWater` - Color of markers for water crashes.  

## **License & Credits**  

This mod is licensed under **APL-SA**.  
Original concept by **Bigfoot**. Enhanced & maintained by **sko & Ghost | PGM DEV TEAM**.  
