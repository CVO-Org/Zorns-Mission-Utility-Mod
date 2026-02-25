#include "../../script_component.hpp"

/*
* Author: Zorn
* Unload Function - Reads UI Variables and creates the request-hashmap
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

params ["_display", "_exitCode"];

if (_exitCode == 2) exitWith { };

private _ctrl_crates = _display displayCtrl MUM_IDC_CSC_Crates_ListNBox;

// Extract
// [classname, amount]
private _crate_list = [];
private _size = (lnbSize _ctrl_crates select 0) - 1;


for "_i" from 0 to _size do {
    _crate_list pushBack [
        _ctrl_crates lnbData  [_i, 0],
        _ctrl_crates lnbValue [_i, 0]
    ];
};

private _crates = [];
{
    _x params ["_classname", "_amount"];
    if (_amount == 0) then { continue };
    for "_i" from 1 to _amount do { _crates pushBack _className; };

} forEach _crate_list;


private _request = createHashMapFromArray [
    [ "crates",        _crates ],
    [ "requester",     _display getVariable "requester" ],
    [ "target",        _display getVariable "target" ],
    [ "destination",   _display getVariable QGVAR(destination) ],
    [ "delivery_mode", _display getVariable QGVAR(delivery_mode) ],
    [ "isZeus",        _display getVariable "isZeus" ]
];

ZRN_LOG_MSG_1(REQUEST Established. Handling Destination next,_request);

[_request] call FUNC(handle_destination);

