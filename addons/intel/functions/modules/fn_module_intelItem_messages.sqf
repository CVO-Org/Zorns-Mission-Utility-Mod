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



// Get Content
private _senderName = _logic getVariable QGVAR(senderName);
private _senderMeta = _logic getVariable QGVAR(senderMeta);

if (_senderName isEqualTo "") then { _senderName = "Unkown"; };
if (_senderMeta isEqualTo "") then { _senderMeta = "Last Activity: Unkown"; };

// Get Content as Array
private _messages = [];
for "_i" from 1 to 6 do {
    _messages pushBack [
        _logic getVariable [ [ QADDON, "message", _i, "type" ] joinString "_", ""],
        _logic getVariable [ [ QADDON, "message", _i, "text" ] joinString "_", ""]
    ];

};

#define MAX_LENGTH 40
#define COLOR_RECIPIENT color=QQ(#429ed3)
#define COLOR_SENDER color=QQ(#42d3a3)

// Compose Intel Body
private _intelContent  = "<br/>";
private _intelDesc = _logic getVariable QGVAR(intel_desc);
if (_intelDesc isNotEqualTo "") then { _intelContent = _intelContent + format [Q(<font COLOR_GREY face='RobotoCondensedLight'>%1</font><br/><br/>), _intelDesc]; };

_intelContent = _intelContent + format [Q(<font face='EtelkaMonospaceProBold'COLOR_GREY size='12'>Sender: </font><font face='EtelkaMonospaceProBold' COLOR_SENDER size='15'>%1</font><br/>), _senderName];
_intelContent = _intelContent + format [Q(<font face='EtelkaMonospacePro' COLOR_GREY size='10'>%1</font><br/><br/>), _senderMeta];

// Process Content Array
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
    if (_messagePart isNotEqualTo "") then { _intelContent = _intelContent + _messagePart; };
} forEach _messages;

// Apply Intel
{
    [
        _x,
        _logic getVariable QGVAR(intelTitle),
        _intelContent,
        _logic getVariable QGVAR(intelGroup),
        _logic getVariable QGVAR(removeObject),
        _logic getVariable QGVAR(actionTitle),
        _logic getVariable QGVAR(actionDuration),
        _logic getVariable QGVAR(actionSound),
        _logic getVariable QGVAR(shareWith)
    ] call FUNC(createIntel)
} forEach _units;

nil
