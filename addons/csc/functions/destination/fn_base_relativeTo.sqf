#include "../../script_component.hpp"

/*
* Author: Zorn
* Returns position relative to reference object/unit.
* Supports PLAYER, TARGET, or custom reference with FRONT/BEHIND/OFFSET positioning modes.
*
* Arguments:
* 0: _request - Request hashmap (not used in this function). <HASHMAP>
* 1: _parameters - Destination parameters hashmap with ref, mode, distance, etc. <HASHMAP>
*
* Return Value:
* Array [x, y, z] position, or [0,0,0] on error <ARRAY>
*
* Example:
* [requestHashMap, parametersHashMap] call mum_csc_fnc_base_relativeTo
*
* Public: No
*/

params ["_request", "_parameters"];

private _reference = _parameters getOrDefault ["reference", objNull];

_reference = switch (true) do {
    case (_reference isEqualTo "PLAYER"): { _request getOrDefault ["requester", ACE_Player] };
    case (_reference isEqualTo "TARGET"): { _request getOrDefault ["target", objNull] };
    case (!isNil _reference): { missionNamespace getVariable _reference };
    default { objNull };
};

if (isNull _reference) exitWith { [0,0,0] };

private _mode = _parameters getOrDefault ["mode", "FRONT"];



private _return = switch (_mode) do {
    case "FRONT": {
        private _maxSize = selectMax (_request get "crates" apply { ( [QGVAR(crates), _x] call EFUNC(catalog,getEntry) get "box_class" ) call EFUNC(common,getSizeOf) });
        _reference getRelPos [ (_reference call BIS_fnc_boundingBoxDimensions select 0) / 2 + 3 + _maxSize, 0 ];
    };

    case "BEHIND": {
        private _maxSize = selectMax (_request get "crates" apply { ( [QGVAR(crates), _x] call EFUNC(catalog,getEntry) get "box_class" ) call EFUNC(common,getSizeOf) });
        _reference getRelPos [ (_reference call BIS_fnc_boundingBoxDimensions select 0) / 2 + 3 + _maxSize, 180 ];
    };

    case "OFFSET": {
        private _offset = _parameters getOrDefault ["offset", [0,0,2]];
        getPosASL _reference vectorAdd _offset
    };

    default { [0,0,0] };
};

private _randomOffset = _parameters getOrDefault ["randomOffset", 0];

if (_randomOffset isNotEqualTo 0) then {
    _return = _return vectorAdd [
        selectRandom [-1, 0, 1] * _randomOffset,
        selectRandom [-1, 0, 1] * _randomOffset,
        0
    ];
};

_return
