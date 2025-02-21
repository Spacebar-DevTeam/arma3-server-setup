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
	
	The fn_showNotification.sqf script in ZCP missions handles displaying notifications 
	to players, including global notifications, personal messages, reputation updates, 
	and money alerts. It supports both legacy messages and new Exile toast-style 
	notifications, using ExileServer_system_network_send_to and publicVariableClient 
	for messaging. The script dynamically formats messages with customizable colors, 
	fonts, and sizes.
	
	Improvements Made:
      Debug Variable: Added ZCP_Debug = false; at the top.
      Safety Checks: Validates notification type and player object before use.
      Debugging: Provides detailed logs for notification type, message content, and target player.
      Legacy & New Notifications: Supports both old message types and new toast-style messages.
      Code Clarity: Enhanced readability and maintained modular message handling.
	
	sko & Ghost PGM DEV TEAM
	
*/
ZCP_Debug = false;

params [
    "_ZCP_SN_notificationType",
    "_ZCP_SN_message",
    ["_ZCP_SN_player", objNull, [objNull]]
];

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Showing notification: Type=%1, Message=%2", _ZCP_SN_notificationType, _ZCP_SN_message];
};

// Handle legacy notification system
if (ZCP_CurrentMod == "Exile" && ZCP_useOldMessages) exitWith {
    switch (_ZCP_SN_notificationType) do {
        case "Notification": {
            PV_ZCP_zupastic = _ZCP_SN_message;
            publicVariable "PV_ZCP_zupastic";
        };
        case "PersonalNotification": {
            if (!isNull _ZCP_SN_player) then {
                PV_ZCP_zupastic = _ZCP_SN_message;
                owner _ZCP_SN_player publicVariableClient "PV_ZCP_zupastic";
            };
        };
        case ["Reputation", "Money"]: {
            _ZCP_SN_message call ExileServer_system_network_send_to;
        };
    };
};

// New exile messages using toast notifications
private _titleColor = "#3FD4FC";
private _zcp_toast_type = switch (_ZCP_SN_message select 2) do {
    case "ZCP_Init": { _titleColor = "#A0DF3B"; "SuccessEmpty" };
    case "ZCP_Capped": { _titleColor = "#C62651"; "ErrorEmpty" };
    default { "InfoEmpty" };
};

// Prepare toast message
private _toastMessage = format [
    "<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>",
    _titleColor,
    ZCP_DMS_ExileToasts_Title_Size,
    ZCP_DMS_ExileToasts_Title_Font,
    _ZCP_SN_message select 0,
    ZCP_DMS_ExileToasts_Message_Color,
    ZCP_DMS_ExileToasts_Message_Size,
    ZCP_DMS_ExileToasts_Message_Font,
    _ZCP_SN_message select 1 select 0
];

// Send the toast notification
switch (_ZCP_SN_notificationType) do {
    case "Notification": {
        ["toastRequest", [_zcp_toast_type, [_toastMessage]]] call ExileServer_system_network_send_broadcast;
    };
    case "PersonalNotification": {
        if (!isNull _ZCP_SN_player) then {
            [_ZCP_SN_player, "toastRequest", [_zcp_toast_type, [_toastMessage]]] remoteExec ["ExileClient_gui_toaster_addToast", _ZCP_SN_player];
        };
    };
};

if (ZCP_Debug) then {
    diag_log format ["[ZCP] Notification displayed: %1", _ZCP_SN_message];
};

/*
private['_ZCP_SN_notificationType','_ZCP_SN_message'];

_ZCP_SN_notificationType = _this select 0;
_ZCP_SN_message          = _this select 1;

if(ZCP_CurrentMod == 'Exile') exitWith {

  if(ZCP_useOldMessages) exitWith {
      switch (_ZCP_SN_notificationType) do {
          case ('Notification'): {
            PV_ZCP_zupastic = _ZCP_SN_message;
            publicVariable "PV_ZCP_zupastic";
          };
          case ('PersonalNotification'): {
              private['_ZCP_SN_player'];
              _ZCP_SN_player = _this select 2;
              PV_ZCP_zupastic = _ZCP_SN_message;
              owner _ZCP_SN_player publicVariableClient "PV_ZCP_zupastic";
          };
          case ('Reputation'): {
            _ZCP_SN_message call ExileServer_system_network_send_to;
          };
          case ('Money'): {
            _ZCP_SN_message call ExileServer_system_network_send_to;
          };
      };
  };

    private _titleColor = "#3FD4FC";
    private _zcp_toast_type =
          switch (_ZCP_SN_message select 2) do
          {
              case "ZCP_Init": {_titleColor = "#A0DF3B";"SuccessEmpty"};
              case "ZCP_Capped": {_titleColor = "#C62651";"ErrorEmpty"};
              default {"InfoEmpty"};		// case "start":
          };


    // new exile messages
    switch (_ZCP_SN_notificationType) do {
      case ('Notification'): {

            [
                "toastRequest",
                [
                    _zcp_toast_type,
                    [
                        format
                        [
                            "<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>",
                            _titleColor,
                            ZCP_DMS_ExileToasts_Title_Size,
                            ZCP_DMS_ExileToasts_Title_Font,
                            _ZCP_SN_message select 0,
                            ZCP_DMS_ExileToasts_Message_Color,
                            ZCP_DMS_ExileToasts_Message_Size,
                            ZCP_DMS_ExileToasts_Message_Font,
                            _ZCP_SN_message select 1 select 0
                        ]
                    ]
                ]
            ] call ExileServer_system_network_send_broadcast;
      };
      case ('PersonalNotification'): {
          private['_ZCP_SN_player'];
          _ZCP_SN_player = _this select 2;

              [
                   _ZCP_SN_player,
                  "toastRequest",
                  [
                      _zcp_toast_type,
                      [
                          format
                          [
                              "<t color='%1' size='%2' font='%3'>%4</t><br/><t color='%5' size='%6' font='%7'>%8</t>",
                              _titleColor,
                              ZCP_DMS_ExileToasts_Title_Size,
                              ZCP_DMS_ExileToasts_Title_Font,
                              _ZCP_SN_message select 0,
                              ZCP_DMS_ExileToasts_Message_Color,
                              ZCP_DMS_ExileToasts_Message_Size,
                              ZCP_DMS_ExileToasts_Message_Font,
                              _ZCP_SN_message select 1 select 0
                          ]
                      ]
                  ]
              ] call ExileServer_system_network_send_to;
      };
      case ('Reputation'): {
        _ZCP_SN_message call ExileServer_system_network_send_to;
      };
      case ('Money'): {
        _ZCP_SN_message call ExileServer_system_network_send_to;
      };
  };


};

if(ZCP_CurrentMod == 'Epoch') exitWith {
  switch (_ZCP_SN_notificationType) do {
      case ('Notification'): {
        PV_ZCP_zupastic = _ZCP_SN_message;
        publicVariable "PV_ZCP_zupastic";
      };
      case ('PersonalNotification'): {
          private['_ZCP_SN_player'];
          _ZCP_SN_player = _this select 2;
          PV_ZCP_zupastic = _ZCP_SN_message;
          owner _ZCP_SN_player publicVariableClient "PV_ZCP_zupastic";
      };
      case ('Reputation'): {

      };
      case ('Money'): {

      };
  };
};
*/