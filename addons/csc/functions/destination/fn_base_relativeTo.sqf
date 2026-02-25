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

private _reference = _paramsHashmap getOrDefault ["reference", objNull];

_reference = switch (true) do {
    case (_reference isEqualTo "PLAYER"): { _requestHashmap getOrDefault ["requester", ACE_Player] };
    case (_reference isEqualTo "TARGET"): { _requestHashmap getOrDefault ["target", objNull] };
    case (!isNil _reference): { missionNamespace getVariable _reference };
    default { objNull };
};

if (isNull _reference) exitWith { [0,0,0] };

private _mode = _paramsHashmap getOrDefault ["mode", "FRONT"];



private _return = switch (_mode) do {
    case "FRONT": {
        private _maxSize = selectMax (_requestHashmap get "crates" apply { getText (([QGVAR(crates), _x] call EFUNC(catalog,getEntry)) >> "box_class") call EFUNC(common,getSizeOf) });
        _reference getRelPos [ (_reference call BIS_fnc_boundingBoxDimensions select 0) / 2 + 3 + _maxSize, 0 ];
    };

    case "BEHIND": {
        private _maxSize = selectMax (_requestHashmap get "crates" apply { getText (([QGVAR(crates), _x] call EFUNC(catalog,getEntry)) >> "box_class") call EFUNC(common,getSizeOf) });
        _reference getRelPos [ (_reference call BIS_fnc_boundingBoxDimensions select 0) / 2 + 3 + _maxSize, 180 ];
    };
    
    case "OFFSET": {
        private _offset = _paramsHashmap getOrDefault ["offset", [0,0,2]];
        getPosASL _reference vectorAdd _offset
    };
    
    default { [0,0,0] };
};

private _randomOffset = _paramsHashmap getOrDefault ["randomOffset", 0];

if (_randomOffset isNotEqualTo 0) then {
    _return = _return vectorAdd [
        selectRandom [-1, 0, 1] * _randomOffset,
        selectRandom [-1, 0, 1] * _randomOffset,
        0
    ];
};

_return
