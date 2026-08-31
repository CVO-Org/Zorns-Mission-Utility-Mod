#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to register: Crate
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
if !(_id isEqualType "")  exitWith { ["CRATE ID must be a string"]            call BIS_fnc_error; ERROR("CRATE ID must be a string"); };
if  (_id isEqualTo "")    exitWith { ["CRATE ID cannot be empty"]             call BIS_fnc_error; ERROR("CRATE ID cannot be empty"); };
if  (_id in GVAR(crates)) exitWith { ["CRATE ID: %1 already registered", _id] call BIS_fnc_error; ERROR_1("CRATE ID: %1 already registered",_id); };
_inputData set ["id", _id];

// Get Default Data
private _data = + GVAR(base_crate);

_data merge [_inputData, true];

// Validate Data

// Seperate Items and Backpacks
private _items = [];
private _backpacks = [];
{
    if !(_x isEqualTypeArray ["",0]) then { continue };

    if ( getNumber (configFile >> "CfgVehicles" >> _x#0 >> "isBackpack") isEqualTo 1 ) then {
        _backpacks pushBack _x;
    } else {
        _items pushBack _x;
    };

} forEach (_data get "items");

// Handle Items from synced crate, as they are already propperly filtered
if !(_data isNil "synced_items"    ) then { _items     append (_data deleteAt "synced_items"    ) };
if !(_data isNil "synced_backpacks") then { _backpacks append (_data deleteAt "synced_backpacks") };

_data set ["items", _items];
_data set ["backpacks", _backpacks];

// Store Data
GVAR(crates) set [_id, _data];

true
