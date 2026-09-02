#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Registers a destination type to the CSC framework.
* Validates the destination ID, merges with base configuration, stores in registry.
*
* Arguments:
* 0: _inputData - Destination configuration hashmap with id, displayName, code, parameters, etc. <HASHMAP>
*
* Return Value:
* Boolean - true on successful registration, false on validation failure <BOOL>
*
* Example:
* [destinationConfigHashMap] call mum_csc_fnc_registerDestination
*
* Public: Yes
*/


params [ ["_inputData", nil, [createHashMap] ] ];

if (isNil "_inputData") exitWith { false };

// Validate ID
private _id = (_inputData getOrDefault ["id", ""]);
_id = toLowerANSI _id;
if !(_id isEqualType "")  exitWith { ["DESTINATION ID must be a string"]            call BIS_fnc_error; ERROR("DESTINATION ID must be a string"); };
if  (_id isEqualTo "")    exitWith { ["DESTINATION ID cannot be empty"]             call BIS_fnc_error; ERROR("DESTINATION ID cannot be empty"); };
if  (_id in GVAR(destinations)) exitWith { ["DESTINATION ID: %1 already registered", _id] call BIS_fnc_error; ERROR_1("DESTINATION ID: %1 already registered",_id); };
_inputData set ["id", _id];

// Get Default Data
private _data = + GVAR(base_destination);
_data merge [_inputData, true];

// Validate Data


// Store Data
GVAR(destinations) set [_id, _data];

true
