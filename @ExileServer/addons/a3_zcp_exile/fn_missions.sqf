/**
*   Learn how to configure the missions
*   https://github.com/DevZupa/ZCP-A3-Exile/wiki/Configuration#mission-config
*/

[
	[
		"ZCP Alpha", // name (0)
		[[10000,10000,0],[10000,10000,0]], // [[x,y,z],[x,y,z]] if using static location (1)
		["Poptabs", "WeaponBox", "Buildingbox"], // Reward -> Random, Poptabs, Vehicle, Buildingbox, WeaponBox , BigWeaponBox, SniperWeaponBox (2)
		"alpha", // unique varname -> this gets checked and fixed automaticly on server start ( so don't really worry about it ).
		0, // unique index -> this gets checked and fixed automaticly on server start ( so don't really worry about it ).
		true, // spawnAI on start of the missions ( NEEDS AI system for this ) (5)
		false, // isStatic location ( if true it will take the location specified earlier) (6)
		["ec_audacity.sqf","ec_bravery.sqf","ec_courage.sqf", "ec_defiance.sqf","ec_endurance.sqf","ec_fortitude.sqf","m3e_exoBase1.sqf","m3e_exoBase2.sqf","m3e_exoBase3.sqf"], // baseFile -> Random OR the name of the sqf file OR array of basefiles to choose from ( eg: ["m3e_base1.sqf","m3e_village.sqf"], )
		-1, // capradius if you use a specific static basefile. -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		-1, // max terrainGradient -> when specific static basefile is used (9) -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		-1, // distancefromojects -> when specific static basefile is used (10) -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		300, // captime in seconds for this mission (11)
		4, // Minimum amount of AI at the start of mission (12)
        8, // Maximum amount of AI at start of mission ( If you want it to always be a number change MIN and MAX to the same number. )
        true, // deploy smoke on the circle border when mission is finished (14)
        0, // ammount of seconds to wait before deploying the smokescreen (15)
        0, // ammount of meters outside the circle to place the smoke sources ( 0 is ON the circle border, 50 would be 50 meter outside the border)
		true, // use Waves of AI to attack the base when a player is capping (17)
		[ // array of waves of AI () (18)
			[
				15, // percentage of the cap time to start attack (50 = 50% of the total captime)
				3, // Amount of AI units in a group
				1, // Amount of AI groups
				200, // distance in meter form ZCP for the ai to spawn
				true // false -> all groups from 1 random location, true -> all groups from their own random location
			]
			,
			[
				45, // percentage of the cap time to start attack (50 = 50% of the total captime)
				3, // Amount of AI units in a group
				2, // Amount of AI groups
				200, // distance in meter form ZCP for the ai to spawn
				false // false -> all groups from 1 random location, true -> all groups from their own random location
			]
			,
			[
				60, // percentage of the cap time to start attack (50 = 50% of the total captime)
				3, // Amount of AI units in a group
				2, // Amount of AI groups
				200, // distance in meter form ZCP for the ai to spawn
				true // false -> all groups from 1 random location, true -> all groups from their own random location
			]
		],
		1, // Minimum amount of launchers for starting AI (19)
        2, // Maximum amount of launchers for starting AI (20)
        1, // Minimum amount of launchers for Wave AI (21)
        1,  // Maximum amount of launchers for Wave AI (22)
        ["moderate","random","AWARE", "YELLOW"], // Defender AI settings ['DMS difficulty','DMS gear', 'Behaviour', 'CombatMode'] (23)
        ["moderate","random","AWARE", "YELLOW"], // Wave AI difficulty (24)
        true, // spawn rewards in the air after the mission, false -> prespawn them on the ground empty and fill them on completion. ( Boxes and Vechicles only ).
        false, // City mode. -> Takes a city/village from the map as cappoint and places a flag in the center ( No base file needed ). This ignores the position configs. (26)
        true // Allow spawning of extra objects in the town if sqf file(s) is/are provided. (27)
    ]
	,
    [
        "ZCP Bravo", // name (0)
        [[10000,10000,0],[10000,10000,0]], // [[x,y,z],[x,y,z]] if using static location (1)
       	["Vehicle", "BigWeaponBox", "Poptabs"], // Reward -> Random, Poptabs, Vehicle, Buildingbox, WeaponBox , BigWeaponBox, SniperWeaponBox (2)
        "beta", // unique varname -> this gets checked and fixed automaticly on server start ( so don't really worry about it ).
        1, // unique index -> this gets checked and fixed automaticly on server start ( so don't really worry about it ).
        true, // spawnAI on start of the missions ( NEEDS AI system for this ) (5)
        false, // isStatic location ( if true it will take the location specified earlier) (6)
        'Random', // baseFile -> Random ( from Capbases array- OR the name of the sqf file OR array of basefiles to choose from ( eg: ["m3e_base1.sqf","m3e_village.sqf"], )
        -1, // capradius if you use a specific static basefile. -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
        -1, // max terrainGradient -> when specific static basefile is used (9) -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
        -1, // distancefromojects -> when specific static basefile is used (10) -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
        300, // captime in seconds for this mission (11)
        4, // Minimum amount of AI at the start of mission (12)
        8, // Maximum amount of AI at start of mission ( If you want it to always be a number change MIN and MAX to the same number. )
        true, // deploy smoke on the circle border when mission is finished (14)
        20, // ammount of seconds to wait before deploying the smokescreen (15)
        50, // ammount of meters outside the circle to place the smoke sources ( 0 is ON the circle border, 50 would be 50 meter outside the border)
        true, // use Waves of AI to attack the base when a player is capping (17)
        [ // array of waves of AI () (18)
            [
                30, // percentage of the cap time to start attack (50 = 50% of the total captime)
                3, // Amount of AI units in a group
                2, // Amount of AI groups
                200, // distance in meter form ZCP for the ai to spawn
                true // false -> all groups from 1 random location, true -> all groups from their own random location
            ]
            ,
            [
                75, // percentage of the cap time to start attack (50 = 50% of the total captime)
                2, // Amount of AI units in a group
                3, // Amount of AI groups
                200, // distance in meter form ZCP for the ai to spawn
                false // false -> all groups from 1 random location, true -> all groups from their own random location
            ]
        ],
        1, // Minimum amount of launchers for starting AI
        2, // Maximum amount of launchers for starting AI
        1, // Minimum amount of launchers for Wave AI
        1 , // Maximum amount of launchers for Wave AI
        ["moderate","random","AWARE", "YELLOW"], // Defender AI difficulty (23)
        ["moderate","random","AWARE", "YELLOW"], // Wave AI difficulty (24)
        false, // spawn rewards in the air after the mission, false -> prespawn them on the ground empty and fill them on completion. ( Boxes and Vechicles only ). (25)
        false, // City mode. -> Takes a city/village from the map as cappoint and places a flag in the center ( No base file needed ). This ignores the position configs. (26)
        true // Allow spawning of extra objects in the town if sqf file(s) is/are provided. (27)
    ]
	,
	[
		"ZCP Charlie", // name (0)
		[[10000,10000,0],[10000,10000,0]], // [[x,y,z],[x,y,z]] if using static location (1)
		["Buildingbox", "WeaponBox", "Random"], // Reward -> Random, Poptabs, Vehicle, Buildingbox, WeaponBox , BigWeaponBox, SniperWeaponBox (2)
		"charlie", // unique varname -> this gets checked and fixed automaticly on server start ( so don't really worry about it ).
		0, // unique index -> this gets checked and fixed automaticly on server start ( so don't really worry about it ).
		true, // spawnAI on start of the missions ( NEEDS AI system for this ) (5)
		false, // isStatic location ( if true it will take the location specified earlier) (6)
		["ec_audacity.sqf","ec_bravery.sqf","ec_courage.sqf", "ec_defiance.sqf","ec_endurance.sqf","ec_fortitude.sqf","m3e_exoBase1.sqf","m3e_exoBase2.sqf","m3e_exoBase3.sqf"], // baseFile -> Random OR the name of the sqf file OR array of basefiles to choose from ( eg: ["m3e_base1.sqf","m3e_village.sqf"], )
		-1, // capradius if you use a specific static basefile. -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		-1, // max terrainGradient -> when specific static basefile is used (9) -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		-1, // distancefromojects -> when specific static basefile is used (10) -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		300, // captime in seconds for this mission (11)
		4, // Minimum amount of AI at the start of mission (12)
		8, // Maximum amount of AI at start of mission ( If you want it to always be a number change MIN and MAX to the same number. )
		true, // deploy smoke on the circle border when mission is finished (14)
		0, // ammount of seconds to wait before deploying the smokescreen (15)
		0, // ammount of meters outside the circle to place the smoke sources ( 0 is ON the circle border, 50 would be 50 meter outside the border)
		true, // use Waves of AI to attack the base when a player is capping (17)
		[ // array of waves of AI () (18)
			[
				15, // percentage of the cap time to start attack (50 = 50% of the total captime)
				3, // Amount of AI units in a group
				1, // Amount of AI groups
				200, // distance in meter form ZCP for the ai to spawn
				true // false -> all groups from 1 random location, true -> all groups from their own random location
			]
			,
			[
				45, // percentage of the cap time to start attack (50 = 50% of the total captime)
				3, // Amount of AI units in a group
				2, // Amount of AI groups
				200, // distance in meter form ZCP for the ai to spawn
				false // false -> all groups from 1 random location, true -> all groups from their own random location
			]
			,
			[
				60, // percentage of the cap time to start attack (50 = 50% of the total captime)
				3, // Amount of AI units in a group
				2, // Amount of AI groups
				200, // distance in meter form ZCP for the ai to spawn
				true // false -> all groups from 1 random location, true -> all groups from their own random location
			]
		],
		1, // Minimum amount of launchers for starting AI (19)
		2, // Maximum amount of launchers for starting AI (20)
		1, // Minimum amount of launchers for Wave AI (21)
		1,  // Maximum amount of launchers for Wave AI (22)
		["moderate","random","AWARE", "YELLOW"], // Defender AI settings ['DMS difficulty','DMS gear', 'Behaviour', 'CombatMode'] (23)
		["moderate","random","AWARE", "YELLOW"], // Wave AI difficulty (24)
		true, // spawn rewards in the air after the mission, false -> prespawn them on the ground empty and fill them on completion. ( Boxes and Vechicles only ).
		true, // City mode. -> Takes a city/village from the map as cappoint and places a flag in the center ( No base file needed ). This ignores the position configs. (26)
		true // Allow spawning of extra objects in the town if sqf file(s) is/are provided. (27)
	]
	,
	[
		"ZCP Delta", // name (0)
		[[10000,10000,0],[10000,10000,0]], // [[x,y,z],[x,y,z]] if using static location (1)
		["Poptabs", "SniperWeaponBox", "Random"], // Reward -> Random, Poptabs, Vehicle, Buildingbox, WeaponBox , BigWeaponBox, SniperWeaponBox (2)
		"delta", // unique varname -> this gets checked and fixed automaticly on server start ( so don't really worry about it ).
		1, // unique index -> this gets checked and fixed automaticly on server start ( so don't really worry about it ).
		true, // spawnAI on start of the missions ( NEEDS AI system for this ) (5)
		false, // isStatic location ( if true it will take the location specified earlier) (6)
		'Random', // baseFile -> Random ( from Capbases array- OR the name of the sqf file OR array of basefiles to choose from ( eg: ["m3e_base1.sqf","m3e_village.sqf"], )
		-1, // capradius if you use a specific static basefile. -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		-1, // max terrainGradient -> when specific static basefile is used (9) -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		-1, // distancefromojects -> when specific static basefile is used (10) -> put -1 if you want to use the corresponding one from the ZCP_Capbasses array).
		300, // captime in seconds for this mission (11)
		4, // Minimum amount of AI at the start of mission (12)
		8, // Maximum amount of AI at start of mission ( If you want it to always be a number change MIN and MAX to the same number. )
		true, // deploy smoke on the circle border when mission is finished (14)
		20, // ammount of seconds to wait before deploying the smokescreen (15)
		50, // ammount of meters outside the circle to place the smoke sources ( 0 is ON the circle border, 50 would be 50 meter outside the border)
		true, // use Waves of AI to attack the base when a player is capping (17)
		[ // array of waves of AI () (18)
			[
				30, // percentage of the cap time to start attack (50 = 50% of the total captime)
				3, // Amount of AI units in a group
				2, // Amount of AI groups
				200, // distance in meter form ZCP for the ai to spawn
				true // false -> all groups from 1 random location, true -> all groups from their own random location
			]
			,
			[
				75, // percentage of the cap time to start attack (50 = 50% of the total captime)
				2, // Amount of AI units in a group
				3, // Amount of AI groups
				200, // distance in meter form ZCP for the ai to spawn
				false // false -> all groups from 1 random location, true -> all groups from their own random location
			]
		],
		1, // Minimum amount of launchers for starting AI
		2, // Maximum amount of launchers for starting AI
		1, // Minimum amount of launchers for Wave AI
		1 , // Maximum amount of launchers for Wave AI
		["moderate","random","AWARE", "YELLOW"], // Defender AI difficulty (23)
		["moderate","random","AWARE", "YELLOW"], // Wave AI difficulty (24)
		false, // spawn rewards in the air after the mission, false -> prespawn them on the ground empty and fill them on completion. ( Boxes and Vechicles only ). (25)
		true, // City mode. -> Takes a city/village from the map as cappoint and places a flag in the center ( No base file needed ). This ignores the position configs. (26)
		true // Allow spawning of extra objects in the town if sqf file(s) is/are provided. (27)
	]
	,
	[
		"ZCP Echo", // Mission Name
		[[10500,10500,0],[10500,10500,0]], // Position (Static or Dynamic)
		["BigWeaponBox", "Poptabs", "Vehicle"], // Rewards
		"echo", // Unique varname
		2, // Unique index
		false, // No AI spawn at mission start
		false, // Not a static location
		"Random", // Base file selection method
		-1, // Cap radius (default from ZCP_Capbases array)
		-1, // Max terrain gradient
		-1, // Distance from objects
		350, // Capture time in seconds
		6, // Minimum AI at start (if spawnAI was true)
		10, // Maximum AI at start (if spawnAI was true)
		true, // Deploy smoke on mission completion
		25, // Seconds before smoke deployment
		60, // Smoke distance from circle border
		true, // Use AI attack waves during mission
		[ // AI Waves Configuration
			[
				25, // Wave 1 at 25% of cap time (87.5 seconds)
				3, // AI units per group
				2, // AI groups
				250, // Spawn distance
				true // Individual random spawn locations
			],
			[
				65, // Wave 2 at 65% of cap time (227.5 seconds)
				4, // AI units per group
				3, // AI groups
				250, // Spawn distance
				false // Single random location
			],
			[
				90, // Wave 3 at 90% of cap time (315 seconds)
				5, // AI units per group
				2, // AI groups
				200, // Spawn distance
				true // Individual random spawn locations
			]
		],
		1, // Min launchers for initial AI (unused since no AI spawns at start)
		3, // Max launchers for initial AI
		1, // Min launchers for wave AI
		2, // Max launchers for wave AI
		["high","random","COMBAT", "RED"], // Defender AI difficulty
		["high","random","COMBAT", "RED"], // Wave AI difficulty
		false, // Spawn rewards on the ground
		true, // City mode
		true // Allow extra objects in town
	]

]
