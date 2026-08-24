#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module Function to turn an object into a an MUM Intel item.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

if (_units isEqualTo []) exitWith {};



// Content Data

private _senderName = _logic getVariable [QGVAR(senderName), ""];
private _senderMeta = _logic getVariable [QGVAR(senderMeta), ""];

if (_senderName isEqualTo "") then { _senderName = "Unkown"; };
if (_senderMeta isEqualTo "") then { _senderMeta = "Last Activity: Unkown"; };

private _messages = [];

for "_i" from 1 to 6 do {
    _messages pushBack [
        _logic getVariable [ [ QADDON, "message", _i, "type" ] joinString "_", ""],
        _logic getVariable [ [ QADDON, "message", _i, "text" ] joinString "_", ""]
    ];

};

// Compose Intel Body
#define MAX_LENGTH 30

#define COLOR_RECIPIENT color=QQ(#429ed3)
#define COLOR_SENDER color=QQ(#42d3a3)
#define COLOR_META color=QQ(#b8b9b9)

private _intelContent = "<br/>";

_intelContent = _intelContent + format [Q(<font face='EtelkaMonospaceProBold'COLOR_META size='12'>Messages with </font><font face='EtelkaMonospaceProBold' COLOR_SENDER size='15'>%1</font><br/>), _senderName];
_intelContent = _intelContent + format [Q(<font face='EtelkaMonospacePro' COLOR_META size='10'>%1</font><br/><br/>), _senderMeta];

{
    _x params ["_type", "_message"];

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

    if (_messagePart isNotEqualTo "") then {
        _intelContent = _intelContent + _messagePart;
    };


} forEach _messages;

// Get Data
private _intelGroup =     _logic getVariable [QGVAR(intelGroup), ""];
private _intelTitle =     _logic getVariable [QGVAR(intelTitle), ""];

// Intel Meta
private _removeObject =   _logic getVariable [QGVAR(removeObject), true];
private _actionTitle =    _logic getVariable [QGVAR(actionTitle), ""];
private _actionDuration = _logic getVariable [QGVAR(actionDuration), 15];
private _actionSound =    _logic getVariable [QGVAR(actionSound), ""];
private _shareWith =      _logic getVariable [QGVAR(shareWith), ""];

// Handle Intel
{ [_x, _intelTitle, _intelContent, _intelGroup, _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith] call FUNC(createIntel) } forEach _units;

nil
