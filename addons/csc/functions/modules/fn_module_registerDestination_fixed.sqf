#include "..\..\script_component.hpp"

/*
* Author: Zorn
* INIT Module Function to register a Destination (Fixed Position).
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

private _destinationData = createHashMap;

// Common Module Attributes
{ _destinationData set [_x, _logic getVariable _x]; } forEach [ "id", "displayName", "description_string" ];

// Hard Data
_destinationData set [ "code", QFUNC(base_fixedPos) ];

private _position = _logic getVariable "fixed_position"; // cannot be "position" lol
if (_position isEqualTo [0,0,0]) then { _position = getPosASL _logic; };

// Parameters
_destinationData set [
    "parameters",
    createHashMapFromArray [
        ["position",  _position],
        ["radius", _logic getVariable "radius" ]
    ]
];

//Store Data
[_destinationData] call FUNC(registerDestination);
