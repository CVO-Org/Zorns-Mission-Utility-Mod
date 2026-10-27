#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module function to turn the synced objects into MUM intel items, formatted as a message history of up to 6 messages.
*
* Arguments:
* 0: Module logic <OBJECT>
* 1: Synced objects <ARRAY>
* 2: Activated <BOOL>
*
* Return Value:
* None
*
* Example:
* [_logic, [_object], true] call mum_intel_fnc_module_intelItem_messages
*
* Public: No
*/

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

if (_units isEqualTo []) exitWith {};

// Get Messages as Array
private _messages = [];
for "_i" from 1 to 6 do {
    _messages pushBack [
        _logic getVariable [ [ QADDON, "message", _i, "type" ] joinString "_", ""],
        _logic getVariable [ [ QADDON, "message", _i, "text" ] joinString "_", ""]
    ];
};

[
    _units,
    _logic getVariable QGVAR(intelGroup),
    _logic getVariable QGVAR(intelTitle),
    _logic getVariable QGVAR(intel_desc),
    _logic getVariable QGVAR(senderName),
    _logic getVariable QGVAR(senderMeta),
    _messages,
    _logic getVariable QGVAR(removeObject),
    _logic getVariable QGVAR(actionTitle),
    _logic getVariable QGVAR(actionDuration),
    _logic getVariable QGVAR(actionSound),
    _logic getVariable QGVAR(shareWith)
] call FUNC(createIntelMessages);

nil
