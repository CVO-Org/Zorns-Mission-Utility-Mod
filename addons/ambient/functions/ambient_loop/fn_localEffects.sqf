#include "../../script_component.hpp"

/*
* Author: Zorn
* dedicated say3d Function
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

diag_log format ['[MUM](debug)(fn_localEffects) _this: %1', _this];

if !(hasInterface) exitWith {};

params [
    ["_sound",      "",     [""]],
    ["_distance",   300,    [0] ],
    ["_direction",  nil,    [0] ]
];

if (isNil "_direction") then { _direction = ceil random 360 };

private _unit = ACE_player;

private _helper = createVehicleLocal [
    "Helper_Base_F",
    _unit getPos [_distance, _direction] vectorAdd [0,0, 2 + ceil random 8]
];

diag_log format ['[MUM](debug)(fn_localEffects) _helper: %1 - _sound: %2 - _distance: %3', _helper , _sound ,_distance];

private _soundsource = _helper say3D [ _sound, _distance * 2.5, 1 + random 0.5 ];

diag_log format ['[MUM](debug)(fn_localEffects) _soundSource: %1', _soundSource];

[
    { isNull (_this#0) },

    {
        params ["", "_helper", "_unit"];
        deleteVehicle _helper;
        _unit setVariable [QGVAR(lastPlayed), CBA_missionTime, true];
    },

    [ _soundsource, _helper, _unit ]
] call CBA_fnc_waitUntilAndExecute;

