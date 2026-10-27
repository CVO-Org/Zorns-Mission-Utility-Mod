#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module function to turn the synced objects into MUM intel items, formatted as a handwritten note.
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
* [_logic, [_object], true] call mum_intel_fnc_module_intelItem_handwrittenNote
*
* Public: No
*/

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

if (_units isEqualTo []) exitWith {};

[
    _units,
    _logic getVariable QGVAR(intelGroup),
    _logic getVariable QGVAR(intelTitle),
    _logic getVariable QGVAR(intel_desc),
    _logic getVariable QGVAR(intel_handwritten),
    _logic getVariable QGVAR(removeObject),
    _logic getVariable QGVAR(actionTitle),
    _logic getVariable QGVAR(actionDuration),
    _logic getVariable QGVAR(actionSound),
    _logic getVariable QGVAR(shareWith)
] call FUNC(createIntelHandwrittenNote);

nil
