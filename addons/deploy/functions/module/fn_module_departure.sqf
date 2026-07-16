#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module Function: Deploy - Departure Module
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
    ["_logic", objNull, [objNull]],        // Argument 0 is module logic
    ["_units", [], [[]]],                // Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
    ["_activated", true, [true]]        // True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

if (_units isEqualTo []) exitWith { false };

private _network = _logic getVariable [QGVAR(network), "Default"];

{ [_x, _network] call FUNC(departure); } forEach _units;

nil
