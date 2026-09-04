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

// if (_units isEqualTo []) exitWith { ["No synced object"] call BIS_fnc_error; ERROR("No synced object"); };

// Create copy of Default Data
private _crateData = + GVAR(base_crate);

// BatchProcess Module Attributes
{ _crateData set [_x, _logic getVariable _x]; } forEach [
    "id",
    "displayName",
    "items",
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

// Parse and Validate Item Arrays
private _items = [];
private _stringItems = _crateData get "items";
private _tempItems = _stringItems splitString " [],
"; // linebreak as seperator




while {_tempItems isNotEqualTo []} do {
    private _amount = parseNumber (_tempItems deleteAt 0);
    if (_amount isEqualTo 0) then { continue };

    private _className = _tempItems deleteAt 0;
    if !(_className isEqualType "") then { continue };

    _items pushBack [_className, _amount];
};


_crateData set ["items", _items];

// Handle Synced Crate
private _referenceBox = _units select 0;

// If there's no synce box, Register Crate now.
if (isNil "_referenceBox") exitWith { [_crateData] call FUNC(registerCrate); };

// when box_class empty, take classname from synced object
if ( _crateData get "box_class" isEqualTo "" ) then { _crateData set ["box_class", typeOf _referenceBox] };


// Handle Reference Inventory
[_referenceBox, true] call FUNC(getVehicleinventory) params ["_synced_items", "_synced_backpacks"];

// Store content, to be processed by API function
_crateData set ["synced_items",     _synced_items     ];
_crateData set ["synced_backpacks", _synced_backpacks ];


// Cleanup
deleteVehicle _referenceBox;

[FUNC(registerCrate), [_crateData]] call CBA_fnc_execNextFrame;
