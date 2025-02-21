class CfgPatches {
	class a3_exile_zcp {	// Make sure this matches the folder and prefix convention
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		/*
			Required Addons Hierarchy:
			The dependency chain in requiredAddons[] must load in the correct order:

				a3_dms depends on exile_client and exile_server_config.
				a3_exile_occupation depends on a3_dms.
				a3_zcp_exile depends on exile_client and exile_server_config but does not list a3_dms or a3_exile_occupation as dependencies.

			If ZCP uses functions or resources from DMS or Occupation, you need to include them in requiredAddons[]:
			  requiredAddons[] = {"exile_client","exile_server_config","a3_dms","a3_exile_occupation"};
		
			  // Default setting:
			  requiredAddons[] = {"exile_client","exile_server_config"};
		*/
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
