/*
	Zupa's Capture Points
	  Reward giver of ZCP
	  Capture points and earn money over time.

	╔════╗─────────╔═══╗────────╔╗─────────────╔╗
	╚══╗═║─────────╚╗╔╗║────────║║────────────╔╝╚╗
	──╔╝╔╬╗╔╦══╦══╗─║║║╠══╦╗╔╦══╣║╔══╦╗╔╦══╦═╗╚╗╔╬══╗
	─╔╝╔╝║║║║╔╗║╔╗║─║║║║║═╣╚╝║║═╣║║╔╗║╚╝║║═╣╔╗╗║║║══╣
	╔╝═╚═╣╚╝║╚╝║╔╗║╔╝╚╝║║═╬╗╔╣║═╣╚╣╚╝║║║║║═╣║║║║╚╬══║
	╚════╩══╣╔═╩╝╚╝╚═══╩══╝╚╝╚══╩═╩══╩╩╩╩══╩╝╚╝╚═╩══╝
	────────║║
	────────╚╝
	
	The fn_translate.sqf script in ZCP missions retrieves the appropriate translation for a 
	given text string based on the currently selected ZCP_Language. It searches the 
	ZCP_Translations array for a matching key and returns the corresponding localized text 
	for English, Spanish, or Ukrainian, defaulting to English if the language is not set. 
	The script includes error handling and debugging outputs to ensure smooth translation 
	management.
	
	
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params ["_ZCP_TR_textKey"];

if (isNil "_ZCP_TR_textKey" || {_ZCP_TR_textKey == ""}) exitWith {
    if (ZCP_Debug) then { diag_log "[ZCP] ERROR: Invalid text key provided to fn_translate.sqf"; };
    _ZCP_TR_textKey;
};

// Default translation is the key itself
private _ZCP_TR_translation = _ZCP_TR_textKey;

// Search for the key in the translations array
{
    if ((_x select 0) isEqualTo _ZCP_TR_textKey) exitWith {
        _ZCP_TR_translation = switch (ZCP_Language) do {
            case "es": { _x select 2 }; // Spanish
            case "uk": { _x select 3 }; // Ukrainian
            default { _x select 1 }; // English
        };
    };
} forEach ZCP_Translations;

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Translated key '%1' to '%2' (Language: %3)", _ZCP_TR_textKey, _ZCP_TR_translation, ZCP_Language];
};

_ZCP_TR_translation

// ((ZCP_Translations select (_this select 0)) select 1)

