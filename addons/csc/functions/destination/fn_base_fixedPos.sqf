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

params [ "_requestHashmap", "_paramsHashmap" ];

private _return = _paramsHashmap getOrDefault ["position", [0,0,0]];

private _randomOffset = _paramsHashmap getOrDefault ["randomOffset", 0];

if (_randomOffset isNotEqualTo 0) then {
    _return = _return vectorAdd [
        selectRandom [-1, 0, 1] * _randomOffset,
        selectRandom [-1, 0, 1] * _randomOffset,
        0
    ];
};

_return
