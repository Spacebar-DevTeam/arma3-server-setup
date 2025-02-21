////////////////////////////////////////////////////////////////////////////////////////////
//
//		Server Occupation script by second_coming
//
//
//		http://www.exilemod.com/profile/60-second_coming/
//
//		This script uses the fantastic DMS by Defent and eraser1
//
//		http://www.exilemod.com/topic/61-dms-defents-mission-system/
//		special thanks to eichi for pointers on this script :)
//
////////////////////////////////////////////////////////////////////////////////////////////
//
//		I do not give permission for anyone to sell (or charge for the installation of)
//		any part of this set of scripts.
//
//		second_coming 2016
//
////////////////////////////////////////////////////////////////////////////////////////////

// added to ensure YORKS_init is executed 2025-0220 sko
hint "YORKS_init executed";
diag_log "YORKS_init executed";

SC_occupationVersion = getText (configFile >> "CfgPatches" >> "a3_exile_occupation" >> "a3_exile_occupation_version");

[] spawn 
{
    diag_log format ["[OCCUPATION]:: Occupation %2 Giving the server time to start before starting [OCCUPATION] (%1)",time,SC_occupationVersion];
    waitUntil { !(isNil "DMS_MinMax_Y_Coords") };
  
    sleep 10;
    diag_log format ["[OCCUPATION MOD]:: Occupation %2 Loading Config at %1",time,SC_occupationVersion];

    // Get the config for Occupation
    call compile preprocessFileLineNumbers "\a3_exile_occupation\config.sqf";
    
    if(isNil "SC_CompiledOkay") exitWith { diag_log format ["[OCCUPATION]:: Occupation failed to read config.sqf, check for typos (time: %1)",time]; };

    // Select the log style depending on config settings
    SC_fnc_log			            = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\occupationLog.sqf";

    // EventHandlers for AI reactions & player interactions
    SC_fnc_hitAir 			        = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\hitAir.sqf";
    SC_fnc_hitLand 			        = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\hitLand.sqf";
    SC_fnc_hitSea 			        = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\hitSea.sqf";
       
          
    SC_fnc_driverKilled 			= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\driverKilled.sqf";
    SC_fnc_vehicleDestroyed     	= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\vehicleDestroyed.sqf";

    SC_fnc_getIn			    	= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\getIn.sqf";
    SC_fnc_getOut			    	= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\getOut.sqf";
 
    SC_fnc_getOffBus				= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\getOffBus.sqf";
    SC_fnc_getOnBus			        = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\getOnBus.sqf";
    SC_fnc_locationUnitMPKilled     = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\locationUnitMPKilled.sqf";
    SC_fnc_staticUnitMPKilled		= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\staticUnitMPKilled.sqf";
	SC_fnc_randomUnitMPKilled		= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\randomUnitMPKilled.sqf";    
    SC_fnc_unitMPHit            	= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\unitMPHit.sqf";
    SC_fnc_unitMPKilled        	    = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\unitMPKilled.sqf";
    SC_fnc_unitFired        	    = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\eventHandlers\unitFired.sqf";
    
    SC_fnc_addMarker				= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\functions\fnc_addMarker.sqf";
    SC_fnc_findsafePos              = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\functions\fnc_findsafePos.sqf";
    SC_fnc_isSafePos                = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\functions\fnc_isSafePos.sqf";
	SC_fnc_isSafePosRandom          = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\functions\fnc_isSafePosRandom.sqf";	
    SC_fnc_selectGear               = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\functions\fnc_selectGear.sqf";
    SC_fnc_selectName               = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\functions\fnc_selectName.sqf";
    SC_fnc_spawnstatics				= compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\functions\fnc_spawnStatics.sqf";
    SC_fnc_unstick          	    = compile preprocessFileLineNumbers "\a3_exile_occupation\scripts\functions\fnc_unstick.sqf"; 


    _logDetail = "=============================================================================================================";
    [_logDetail] call SC_fnc_log;
    _logDetail = format ["[OCCUPATION MOD]:: Occupation %2 Initialised at %1",time,SC_occupationVersion];
    [_logDetail] call SC_fnc_log;
    _logDetail = "=============================================================================================================";
    [_logDetail] call SC_fnc_log;

    // Start Occupation
    []execVM "\a3_exile_occupation\scripts\startOccupation.sqf";
};