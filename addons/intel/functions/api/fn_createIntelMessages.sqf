#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to create an Intel Item formatted as a message history, the same way as the "Intel Item - Messages" module. Server only - does nothing on clients.
*
* Arguments:
* 0: _objects       <OBJECT|ARRAY of OBJECTS>
*           Object(s) which shall be the intel. Each object becomes its own intel item.
*
* 1: _intelGroup    <STRING>  <OPTIONAL> <DEFAULT: "General">
*           Group Name of the Intel - Only used for the Intel Summary Feature.
*
* 2: _intelTitle    <STRING>  <OPTIONAL> <DEFAULT: "Messages">
*           The title of the Intel piece.
*
* 3: _intelDesc     <STRING>  <OPTIONAL> <DEFAULT: "">
*           Short description, shown in grey above the content. Empty string to skip.
*
* 4: _senderName    <STRING>  <OPTIONAL> <DEFAULT: "Unknown">
*           Name of the chat partner. Empty string uses the default.
*
* 5: _senderMeta    <STRING>  <OPTIONAL> <DEFAULT: "Last Activity: Unknown">
*           Subtitle under the chat partner's name. Empty string uses the default.
*
* 6: _messages      <ARRAY>   <OPTIONAL> <DEFAULT: []>
*           Messages in order, each as [_type, _text]. _type can be "SENDER" or "RECIPIENT", any other type is skipped.
*           No limit on the number of messages.
*
* 7-11: _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith <OPTIONAL>
*           Same as MUM_intel_fnc_createIntel arguments 4-8. Default Action Title: "Check for messages..."
*
* Return Value:
* Success? <BOOLEAN>
*
* Example:
* [intel_courier_phone, "River Crossing", "Pager", "The screen is cracked.", "R.", "Last Activity: 2h ago", [["SENDER", "At the mill. Midnight."], ["RECIPIENT", "Understood."]]] call MUM_intel_fnc_createIntelMessages;
*
* Public: Yes
*/

if !(isServer) exitWith { false };

params [
    ["_objects",        [],                         [objNull, []]  ],
    ["_intelGroup",     "General",                  [""]           ],
    ["_intelTitle",     "Messages",                 [""]           ],
    ["_intelDesc",      "",                         [""]           ],
    ["_senderName",     "",                         [""]           ],
    ["_senderMeta",     "",                         [""]           ],
    ["_messages",       [],                         [[]]           ],
    ["_removeObject",   false,                      [true]         ],
    ["_actionTitle",    "Check for messages...",    [""]           ],
    ["_actionDuration", 15,                         [0]            ],
    ["_actionSound",    "AUTO",                     [""]           ],
    ["_shareWith",      "DEFAULT",                  [""]           ]
];

if (_objects isEqualType objNull) then { _objects = [_objects]; };
if (_objects isEqualTo []) exitWith { false };

if (_senderName isEqualTo "") then { _senderName = "Unknown"; };
if (_senderMeta isEqualTo "") then { _senderMeta = "Last Activity: Unknown"; };

#define MAX_LENGTH 40
#define COLOR_RECIPIENT color=QQ(#429ed3)
#define COLOR_SENDER color=QQ(#42d3a3)

// Compose Intel Body
private _content = "<br/>";
if (_intelDesc isNotEqualTo "") then { _content = _content + format [Q(<font COLOR_GREY face='RobotoCondensedLight'>%1</font><br/><br/>), _intelDesc]; };

_content = _content + format [Q(<font face='EtelkaMonospaceProBold' COLOR_GREY size='12'>Sender: </font><font face='EtelkaMonospaceProBold' COLOR_SENDER size='15'>%1</font><br/>), _senderName];
_content = _content + format [Q(<font face='EtelkaMonospacePro' COLOR_GREY size='10'>%1</font><br/><br/>), _senderMeta];

// Process Messages
{
    _x params [["_type", "", [""]], ["_message", "", [""]]];
    private _messagePart = switch (_type) do {
        case "SENDER":    {
            private _lines = ([_message, MAX_LENGTH, nil, "LEFT"] call EFUNC(common,multilineStringPadding));
            _lines = _lines apply { "     " + _x + "<br/>"};
            format [Q(<font face='EtelkaMonospacePro' COLOR_SENDER    size='12'>%1</font><br/>), _lines joinString ""];
        };
        case "RECIPIENT": {
            private _lines = ([_message, MAX_LENGTH, nil, "RIGHT"] call EFUNC(common,multilineStringPadding));
            _lines = _lines apply { "          " + _x + "<br/>"};
            format [Q(<font face='EtelkaMonospacePro' COLOR_RECIPIENT size='12'>%1</font><br/>), _lines joinString ""];
        };
        default { "" };
    };
    if (_messagePart isNotEqualTo "") then { _content = _content + _messagePart; };
} forEach _messages;

// Apply Intel
private _results = _objects apply {
    [_x, _intelTitle, _content, _intelGroup, _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith] call FUNC(createIntel)
};

!(false in _results)
