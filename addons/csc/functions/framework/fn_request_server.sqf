#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
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

/*

private _request = createHashMapFromArray [
    [ "requester",     _display getVariable "requester" ],
    [ "target",        _display getVariable "target"    ],
    [ "crates",        _crates           ],
    [ "destination",   [0,0,0]   ],
    [ "delivery_mode", _display getVariable QGVAR(delivery_mode) ]
];
*/

params ["_request"]; // hashmap

// INFO_1(Request Recieved On Server: %1,_request);

//// Handle Creation of the Crates
// Array of Classnames -> Array of hashmaps -> crate objects
private _crates = _request get "crates" apply { GVAR(crates) get _x } apply { [_x] call FUNC(createCrate) };


// Store the crates in the request hashmap
_request set ["crates", _crates];

ZRN_LOG_MSG_1(Crates created. Next: Delivery,_crates);

[_request] call FUNC(handle_delivery);

nil
