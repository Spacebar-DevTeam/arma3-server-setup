/*
 * Bigfoot's Heli Crash - Server Configuration
 *
 * 	Updated by: sko & Ghost PGM DEV TEAM
 * 
 * This file defines the required dependencies and initializes key functions for the Heli Crash spawner.
*/

class CfgPatches
{
	class BigfootsHeliCrash_Server
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"exile_client", "exile_server"};
	};
};

class CfgFunctions
{
	class BigfootsHeliCrash
	{
		class bootstrap
		{
			file = "\BigfootsHeliCrash_Server\bootstrap";
			
			class ExileServer_BigfootsHeliCrash_preInit
			{
				preInit = 1;
				file = "\BigfootsHeliCrash_Server\bootstrap\fn_preInit.sqf";
			};
			
			class ExileServer_BigfootsHeliCrash_postInit
			{
				postInit = 1;
				file = "\BigfootsHeliCrash_Server\bootstrap\fn_postInit.sqf";
			};
		};

		class code
		{
			file = "\BigfootsHeliCrash_Server\code";
			class ExileServer_BigfootsHeliCrash_addItemsToCrateCommand{};
			class ExileServer_BigfootsHeliCrash_addMoneyToCrateCommand{};
			class ExileServer_BigfootsHeliCrash_createHeliCrashMarkerCommand{};
			class ExileServer_BigfootsHeliCrash_getWreckIdForSpawnCountIndexQuery{};
			class ExileServer_BigfootsHeliCrash_initialize{};
			class ExileServer_BigfootsHeliCrash_maintainHeliCrashCommand{};
			class ExileServer_BigfootsHeliCrash_manageAIPatrols{};
			class ExileServer_BigfootsHeliCrash_sendClientNotificationCommand{};
			class ExileServer_BigfootsHeliCrash_setupCrateCommand{};
			class ExileServer_BigfootsHeliCrash_spawnAIReinforcements{};
			class ExileServer_BigfootsHeliCrash_spawnHeliCrashCommand{};
			class ExileServer_BigfootsHeliCrash_spawnSupportAssets{};
			class ExileServer_BigfootsHeliCrash_util_logCommand{};
		};
	};
};

/* testing above
 * Bigfoot's Heli Crash - Server Configuration
 * Updated by: sko & Ghost PGM DEV TEAM
 * 
 * This file defines the required dependencies and initializes key functions for the Heli Crash spawner.


class CfgPatches
{
    class BigfootsHeliCrash_Server
    {
        requiredVersion = 0.1;
        requiredAddons[] = {"exile_server"}; // Ensure the mod loads after Exile Server
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions 
{
    class BigfootsHeliCrash_Server 
    {
        class main 
        {            
            file = "BigfootsHeliCrash_Server\bootstrap";
            class preInit
            {
                preInit = 1; // Function runs before mission starts
            };
            class postInit
            {
                postInit = 1; // Function runs after mission starts
            };
        };
    };
};
*/