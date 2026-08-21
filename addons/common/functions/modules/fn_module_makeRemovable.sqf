#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module Function for the makeRemovable Function
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


private _duration = parseNumber (_logic getVariable [QGVAR(duration), 30]);
private _requireWirecutters = _logic getVariable [QGVAR(requireWirecutter), true];
{ [_x, _duration, _requireWirecutters] call FUNC(makeRemovable) } forEach _units;
