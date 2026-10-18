#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Registers a delivery mode to the CSC framework.
* Validates the delivery mode ID, merges with base configuration, stores in registry.
*
* Arguments:
* 0: _inputData - Delivery mode configuration hashmap with id, displayName, code, maxCrates, cooldown, parameters, etc. <HASHMAP>
* 1: _overwrite - Replace an already registered entry with the same ID instead of rejecting it <BOOL> (default: false)
*
* Return Value:
* Boolean - true on successful registration, false on validation failure <BOOL>
*
* Example:
* [deliveryModeConfigHashMap] call mum_csc_fnc_registerDeliveryMode
*
* Public: Yes
*/

if (!isServer) exitWith {};

params [
    ["_inputData", nil,   [createHashMap] ],
    ["_overwrite", false, [true]          ]
];

if (isNil "_inputData") exitWith { false };

// Validate ID
private _id = (_inputData getOrDefault ["id", ""]);
if !(_id isEqualType "")         exitWith { ["DELIVERYMODE ID must be a string"]            call BIS_fnc_error; ERROR("DELIVERYMODE ID must be a string"); };
_id = toLowerANSI _id;
if  (_id isEqualTo "")           exitWith { ["DELIVERYMODE ID cannot be empty"]             call BIS_fnc_error; ERROR("DELIVERYMODE ID cannot be empty"); };
if  (_id in GVAR(deliveryModes) && { !_overwrite }) exitWith { ["DELIVERYMODE ID: %1 already registered", _id] call BIS_fnc_error; ERROR_1("DELIVERYMODE ID: %1 already registered",_id); };
if  (_id in GVAR(deliveryModes)) then { WARNING_1("DELIVERYMODE ID: %1 already registered - overwriting",_id); };
_inputData set ["id", _id];



// Get Default Data
private _data = + GVAR(base_deliveryMode);
_data merge [_inputData, true];

// Store Data
[QGVAR(EH_setData), [QGVAR(deliveryModes), _id, _data], [QGVAR(deliveryModes), _id] joinString ":"] call CBA_fnc_globalEventJIP; // fixed JIP ID, so an overwrite replaces the previous JIP entry

true
