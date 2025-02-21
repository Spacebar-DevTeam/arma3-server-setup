class CfgPatches
{
	class a3_zcp_exile
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		a3_zcp_exile_version = "V1.0";
		requiredAddons[] = {"exile_client", "exile_server", "a3_dms"};
		author[] = 
		{
			"[FPS]kuplion",
			"2025-0220 updated/modified - sko & Ghost PGM DEV TEAM"
		};
	};
};

class CfgFunctions
{
	class ZCP
	{
		class main
		{			
			class ZCP_init
			{
				postInit = 1;
				file = "\a3_zcp_exile\initServer.sqf"; 
			};
		};

		class functions
		{
			file = "\a3_zcp_exile\functions";
			class fn_airbomb{};
			class fn_airstrike{};
			class fn_changeCircleColor{};
			class fn_cleanupAI{};
			class fn_cleanupBase{};
			class fn_createDMSGroup{};
			class fn_createDMSSoldier{};
			class fn_createEdenConvertedBase{};
			class fn_createM3eBase{};
			class fn_createM3eEdenBase{};
			class fn_createM3eEdenCity{};
			class fn_createMarker{};
			class fn_createSmokeScreen{};
			class fn_createTrigger{};
			class fn_createVirtualCircle{};
			class fn_createWaypoint{};
			class fn_createWinMarker{};
			class fn_createXcamBase{};
			class fn_deleteLoot{};
			class fn_deleteRuins{};
			class fn_endMission{};
			class fn_fillCrate{};
			class fn_findPosition{};
			class fn_fly{};
			class fn_getRandomCity{};
			class fn_giveReward{};
			class fn_inDebug{};
			class fn_initCPData{};
			class fn_monitorMission{};
			class fn_nearWater{};
			class fn_paraDrop{};
			class fn_preCreateRewards{};
			class fn_preRewardBox{};
			class fn_preRewardVehicle{};
			class fn_removeMarker{};
			class fn_rewardBox{};
			class fn_rewardPoptabs{};
			class fn_rewardReputation{};
			class fn_rewardVehicle{};
			class fn_selectMagazine{};
			class fn_showNotification{};
			class fn_spawnAI{};
			class fn_spawnCrate{};
			class fn_start{};
			class fn_translate{};
			class fn_waveAI{};
		};
	};
};


/*
class CfgPatches {
	class a3_exile_zcp {	// Make sure this matches the folder and prefix convention
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		////////////////////// commented out //////////////////////
			Required Addons Hierarchy:
			The dependency chain in requiredAddons[] must load in the correct order:

				a3_dms depends on exile_client and exile_server_config.
				a3_exile_occupation depends on a3_dms.
				a3_zcp_exile depends on exile_client and exile_server_config but does not list a3_dms or a3_exile_occupation as dependencies.

			If ZCP uses functions or resources from DMS or Occupation, you need to include them in requiredAddons[]:
			  requiredAddons[] = {"exile_client","exile_server_config","a3_dms","a3_exile_occupation"};
		
			  // Default setting:
			  requiredAddons[] = {"exile_client","exile_server_config"};
		////////////////////// commented out //////////////////////
		requiredAddons[] = {"exile_client","exile_server_config","a3_dms","a3_exile_occupation"};
	};
};
class CfgFunctions {
	class zcp {
		tag = "ZCP";
		class main {
			file = "\a3_zcp_exile\x\addons\ZCP";
			class startZCP
			{
				postInit = 1;
			};
			class config {};
			class missions {};
			class cities {};
			class translations {};
			class missionLooper {};

		};
		class compileFunctions {
			file = "\a3_zcp_exile\x\addons\ZCP\functions";
			class inDebug {};
			class nearWater {};
			class paraDrop {};
			class start {};
			class findPosition {};
			class cleanupBase {};
			class initCPData {};
			class giveReward {};
			class createMarker {};
			class createWinMarker {};
			class createM3eBase {};
			class airbomb {};
			class airstrike {};
			class fly {};
			class spawnAI {};
			class spawnCrate {};
			class fillCrate {};
			class selectMagazine {};
			class removeMarker {};
			class translate {};
			class showNotification {};
			class createXcamBase {};
			class createEdenConvertedBase {};
			class createM3eEdenBase {};
			class rewardReputation {};
			class rewardPoptabs {};
			class rewardVehicle {};
			class rewardBox {};
			class createVirtualCircle {};
			class changeCircleColor {};
			class createTrigger {};
			class deleteLoot {};
			class deleteRuins {};
			class monitorMission {};
			class waveAI {};
			class createDMSSoldier {};
			class createDMSGroup {};
			class createWaypoint {};
			class createSmokeScreen {};
			class cleanupAI {};
			class preCreateRewards {};
			class preRewardBox {};
			class preRewardVehicle {};
			class getRandomCity {};
			class createEdenConvertedCity {};
			class endMission {};
		};
	};
};
*/