#include "../../script_component.hpp"
/*
* Author: Zorn
* Teleport delivery: instantaneously places crates at destination.
* Sorts crates by size descending, stacks them at destination with height calculations, recursive staggered placement.
*
* Arguments:
* 0: _request - Request hashmap with destination, crates, etc. <HASHMAP>
* 1: _params - Delivery parameters hashmap (currently unused for spawn). <HASHMAP>
*
* Return Value:
* nil
*
* Example:
* [requestHashMap, paramsHashMap] call mum_csc_fnc_base_spawn
*
* Public: No
*/

params [ "_request", "_params" ];

private _list = _request get "crates";

_list =  [_list, [], { typeOf _x call EFUNC(common,getSizeOf) }, "DESCEND"] call BIS_fnc_sortBy;

private _destination = _request get "destination";

private _recursive = {
    params ["_list", "_destination", "_recursive", ["_collectiveOffset", 0]];

    private _crate = _list deleteAt 0;

    private _height = _crate call BIS_fnc_objectHeight;
    _collectiveOffset = _collectiveOffset + _height;

    switch (true) do {
        case (_destination#2 > 0): { _crate setPosASL (_destination vectorAdd [0,0, _collectiveOffset + 0.5]); }; // Asume ASL
        default { _crate setPos (_destination vectorAdd [0,0, _collectiveOffset + _height/2]); };
    };

    if (_list isEqualTo []) exitWith {};
    [_recursive, [_list, _destination, _recursive, _collectiveOffset], 1] call CBA_fnc_waitAndExecute;
};

[_list, _destination, _recursive] call _recursive;
