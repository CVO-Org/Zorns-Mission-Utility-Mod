#include "../../script_component.hpp"
/*
* Author: Zorn
* DELIVERY Function. Just teleports the crates, one after another at the desired location.
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
