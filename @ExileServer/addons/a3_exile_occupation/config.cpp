#define _ARMA_

class CfgPatches
{
	class a3_exile_occupation
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.0;
		a3_exile_occupation_version = "V71 (23-01-2019)";
		requiredAddons[] = {"a3_dms"};
		author[]= 
		{
			"second_coming - updated/modified by [FPS]kuplion",
			"2025-02-20 updated/modified - sko & Ghost PGM DEV TEAM"
		};
	};
};

class CfgFunctions
{
	class yorkshire
	{
		class main
		{			
			file = "\a3_exile_occupation"; // Corrected root path
			class YORKS_init
			{
				postInit = 1;
				file = "\a3_exile_occupation\initServer.sqf";
			};
		};

		class scripts
		{
			file = "\a3_exile_occupation\scripts";
			class deleteMapMarkers{};
			class occupationFastNights{};
			class occupationHeliCrashes{};
			class occupationLog{};
			class occupationLootCrates{};
			class occupationMilitary{};
			class occupationMonitor{};
			class occupationPlaces{};
			class occupationRandomSpawn{};
			class occupationSea{};
			class occupationSky{};
			class occupationStatic{};
			class occupationTraders{};
			class occupationTransport{};
			class occupationVehicle{};
			class startOccupation{};
		};

		class eventHandlers
		{
			file = "\a3_exile_occupation\scripts\eventHandlers";
			class driverKilled{};
			class getIn{};
			class getOffBus{};
			class getOnBus{};
			class getOut{};
			class hitAir{};
			class hitLand{};
			class hitSea{};
			class locationUnitMPKilled{};
			class randomUnitMPKilled{};
			class staticUnitMPKilled{};
			class unitFired{};
			class unitMPHit{};
			class unitMPKilled{};
			class vehicleDestroyed{};
		};

		class extras
		{
			file = "\a3_exile_occupation\scripts\extras";
			class processReporter{};
		};

		class functions
		{
			file = "\a3_exile_occupation\scripts\functions";
			class fnc_addMarker{};
			class fnc_findsafePos{};
			class fnc_isSafePos{};
			class fnc_isSafePosRandom{};
			class fnc_placeTrader{};
			class fnc_selectGear{};
			class fnc_selectName{};
			class fnc_spawnStatics{};
			class fnc_unstick{};
		};

		class trader
		{
			file = "\a3_exile_occupation\trader";
			class trader1{};
		};
	};
};


/*
class CfgPatches
{
	class a3_exile_occupation
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		a3_exile_occupation_version = "V71 (23-01-2019)";
		requiredAddons[] = {"a3_dms"};
		author[]= 
		{
			"second_coming - updated/modified by [FPS]kuplion",
			"2025-0220 updated/modified - sko & Ghost PGM DEV TEAM"
		};
	};
};

class CfgFunctions
{
	class yorkshire
	{
		class main
		{			
			class YORKS_init
			{
				postInit = 1;
				file = "\a3_exile_occupation\initServer.sqf"; // updated path from "\x\addons\a3_exile_occupation\initServer.sqf";
			};
		};
	};
};
*/