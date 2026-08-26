#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to return a fixed position from the cfg parameters
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

params [ "_request", "_parameters" ];

diag_log format ['[CVO](debug)(fn_base_relativeTo) _request: %1', _request];
diag_log format ['[CVO](debug)(fn_base_relativeTo) _parameters: %1', _parameters];

private _return = _parameters getOrDefault ["position", [0,0,0]];

private _randomOffset = _parameters getOrDefault ["randomOffset", 0];

if (_randomOffset isNotEqualTo 0) then {
    _return = _return vectorAdd [
        selectRandom [-1, 0, 1] * _randomOffset,
        selectRandom [-1, 0, 1] * _randomOffset,
        0
    ];
};

_return
