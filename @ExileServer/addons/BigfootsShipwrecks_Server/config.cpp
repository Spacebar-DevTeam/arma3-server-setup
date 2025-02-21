/*
 * This file is subject to the terms and conditions defined in
 * file 'APL-SA LICENSE.txt', which is part of this source code package.
*/
class CfgPatches
{
	class BigfootsShipwrecks_Server
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"exile_client", "exile_server"};
	};
};

class CfgFunctions
{
	class BigfootsShipwrecks
	{
		class bootstrap
		{
			file = "\BigfootsShipwrecks_Server\bootstrap";
			
			class ExileServer_BigfootsShipwrecks_preInit
			{
				preInit = 1;
				file = "\BigfootsShipwrecks_Server\bootstrap\fn_preInit.sqf";
			};
			
			class ExileServer_BigfootsShipwrecks_postInit
			{
				postInit = 1;
				file = "\BigfootsShipwrecks_Server\bootstrap\fn_postInit.sqf";
			};
		};

		class code
		{
			file = "\BigfootsShipwrecks_Server\code";
			class ExileServer_BigfootsShipwrecks_addItemsToCrateCommand{};
			class ExileServer_BigfootsShipwrecks_addMoneyToCrateCommand{};
			class ExileServer_BigfootsShipwrecks_createShipwreckMarkerCommand{};
			class ExileServer_BigfootsShipwrecks_getWreckIdForSpawnCountIndexQuery{};
			class ExileServer_BigfootsShipwrecks_initialize{};
			class ExileServer_BigfootsShipwrecks_maintainShipwrecksCommand{};
			class ExileServer_BigfootsShipwrecks_sendClientNotificationCommand{};
			class ExileServer_BigfootsShipwrecks_setupCrateCommand{};
			class ExileServer_BigfootsShipwrecks_spawnShipwrecksCommand{};
			class ExileServer_BigfootsShipwrecks_util_logCommand{};
		};
	};
};


/*
 * This file is subject to the terms and conditions defined in
 * file 'APL-SA LICENSE.txt', which is part of this source code package.

 
class CfgPatches
{
	class BigfootsShipwrecks_Server {
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"exile_client", "exile_server"};
	};
};

class CfgFunctions 
{
	class BigfootsShipwrecks_Server 
	{
		class main 
		{			
			file="BigfootsShipwrecks_Server\bootstrap";
			class preInit
            {
                preInit = 1;
            };
			class postInit
			{
				postInit = 1;
			};
		};
	};
};
*/