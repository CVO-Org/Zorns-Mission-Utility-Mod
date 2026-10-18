#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module function: registers an access point on every synced object.
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

if (_units isEqualTo []) exitWith {};

// Get Data
private _accessPointID = _logic getVariable ["id", ""];
private _crates =        _logic getVariable "crates"        splitString ", ";
private _destinations =  _logic getVariable "destinations"  splitString ", ";
private _deliveryModes = _logic getVariable "deliveryModes" splitString ", ";

{ [FUNC(registerAccessPoint), [_x, _accessPointID, _crates, _deliveryModes, _destinations]] call CBA_fnc_execNextFrame; } forEach _units;

