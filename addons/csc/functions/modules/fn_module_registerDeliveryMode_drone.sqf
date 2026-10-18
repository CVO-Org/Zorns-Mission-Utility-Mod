#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module function: registers a drone delivery mode.
*
* Arguments:
* 0: _logic - Module logic <OBJECT>
* 1: _units - Synced objects <ARRAY>
* 2: _activated - Module activated <BOOL>
*
* Return Value:
* None
*
* Example:
* Called by the module
*
* Public: No
*/

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

private _deliveryModeData = createHashMap;

// Common Module Attributes
{ _deliveryModeData set [_x, _logic getVariable _x]; } forEach [ "id", "displayName", "description_string", "maxCrates", "cooldown" ];

// Hard Data
_deliveryModeData set [ "code", QFUNC(base_drone) ];

// Parameters
private _parameters = createHashMap;
{ _parameters set [_x, _logic getVariable _x]; } forEach [ "drone_class", "drone_protected", "drone_side", "mode", "pos_start", "pos_end", "alt_journey", "alt_final", "alt_drop" ];

// Custom Handling
if (_parameters get "pos_start" isEqualTo [0,0,0]) then { _parameters set ["pos_start", getPos _logic]; };

_deliveryModeData set [ "parameters", _parameters ];

//Store Data
[FUNC(registerDeliveryMode), [_deliveryModeData]] call CBA_fnc_execNextFrame;
