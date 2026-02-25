#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to add an item or items
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

if (!isServer) exitWith {};

params [
    [ "_code",   {}, [{}] ],
    [ "_params", []       ]
];

if ( _code isEqualTo {} ) exitWith {};

if !(_params isEqualType []) then { _params = [_params] };


// Handle Existing Units

private _units = allUnits;

private _recCode = {
    params [ "_units", "_code", "_params", "_recCode" ];

    private _unit = _units deleteAt 0;

    [
        QGVAR(EH_remote),
        [
            [_unit] + _params,
            _code
        ],
        _unit
    ] call CBA_fnc_targetEvent;

    if (_units isNotEqualTo []) then { [ _recCode, _this ] call CBA_fnc_execNextFrame; };
}; 

if (_units isNotEqualTo []) then { [ _recCode, [_units, _code, _params, _recCode] ] call CBA_fnc_execNextFrame; };


// Handle created units.
addMissionEventHandler [

    "EntityCreated",

    {
        params ["_entity"];
        _thisArgs params ["_code", "_params"];
        if ( _entity isKindOf "CAManBase" ) then { 
            [
                CBA_fnc_targetEvent,
                [QGVAR(EH_remote), [[_entity] + _params, _code], _entity]
            ] call CBA_fnc_execNextFrame;
        };
    },

    [_code, _params]

];
