/*
 * Bigfoot's Heli Crash - Server Configuration
 * Updated by: sko & Ghost PGM DEV TEAM
 * 
 * This file defines the required dependencies and initializes key functions for the Heli Crash spawner.
 */

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
