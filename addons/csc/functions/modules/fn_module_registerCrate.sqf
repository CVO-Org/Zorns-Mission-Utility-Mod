#include "..\..\script_component.hpp"

/*
* Author: Zorn
* 3den Module Function to
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

//
if (_units isEqualTo []) exitWith {
    ["No synced object"] call BIS_fnc_error;
    ERROR("No synced object");
};

// Create copy of Default Data
private _crateData = + GVAR(base_crate);

// BatchProcess Module Attributes
{ _crateData set [_x, _logic getVariable _x]; } forEach [
    "id",
    "displayName",
    "items",
    "backpacks",
    "box_class",
    "box_empty",
    "ace_medical_facility",
    "ace_medical_vehicle",
    "ace_repair_facility",
    "ace_repair_vehicle",
    "ace_rearm_source",
    "ace_rearm_source_value",
    "ace_refuel_source",
    "ace_refuel_source_value",
    "ace_refuel_source_nozzlePos",
    "ace_drag_canDrag",
    "ace_drag_relPOS",
    "ace_drag_dir",
    "ace_drag_ignoreWeight",
    "ace_carry_canCarry",
    "ace_carry_relPOS",
    "ace_carry_dir",
    "ace_carry_ignoreWeight",
    "ace_cargo_setSpace",
    "ace_cargo_setSize",
    "ace_cargo_add_spareWheels",
    "ace_cargo_add_tracks",
    "ace_cargo_add_jerrycans"
];

// Merge Extended Data, will Overwrite previous Data
private _extendedData = _logic getVariable QGVAR(extendedData);
if ( ! isNil "_extendedData" ) then { _crateData merge [_extendedData, true]; };


// Store CrateData
private _id = toLowerANSI (_crateData getOrDefault ["id", ""]);
if !(_id isEqualType "") exitWith {
    ["CRATE ID must be a string"] call BIS_fnc_error;
    ERROR("CRATE ID must be a string");
};

_id = toLowerANSI _id;
if (_id isEqualTo "") exitWith {
    ["CRATE ID cannot be empty"] call BIS_fnc_error;
    ERROR("CRATE ID cannot be empty");
};

_crateData set ["id", _id];



if ( _id in GVAR(crates) ) then {
    ["CRATE ID: %1 already registered", _id] call BIS_fnc_error;
    ERROR_1("CRATE ID: %1 already registered",_id);
} else {
    GVAR(crates) set [_id, _crateData];
};
