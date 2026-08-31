#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to register: Delivery Mode
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


params [ ["_inputData", nil, [createHashMap] ] ];

if (isNil "_inputData") exitWith { false };

// Validate ID
private _id = (_inputData getOrDefault ["id", ""]);
_id = toLowerANSI _id;
if !(_id isEqualType "")  exitWith { ["DELIVERYMODE ID must be a string"]            call BIS_fnc_error; ERROR("DELIVERYMODE ID must be a string"); };
if  (_id isEqualTo "")    exitWith { ["DELIVERYMODE ID cannot be empty"]             call BIS_fnc_error; ERROR("DELIVERYMODE ID cannot be empty"); };
if  (_id in GVAR(crates)) exitWith { ["DELIVERYMODE ID: %1 already registered", _id] call BIS_fnc_error; ERROR_1("DELIVERYMODE ID: %1 already registered",_id); };
_inputData set ["id", _id];



// Get Default Data
private _data = + GVAR(base_deliveryMode);
_data merge [_inputData, true];

// Validate Data
if (_data get "code_description" isEqualTo "") then { _data set ["code_description", """ will be delivered."""]};
_data set ["maxcrates", (_data get "maxcrates") max 1];

// Store Data
GVAR(deliveryModes) set [_id, _data];

true
