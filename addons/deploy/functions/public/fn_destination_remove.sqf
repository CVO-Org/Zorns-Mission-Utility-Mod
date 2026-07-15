#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to remove a destination from the network.
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

params [
    ["_target",         objNull,    [objNull, []], [2,3] ],
    ["_networkName",    "Default",  [""]                 ]
];

if (_target isEqualTo objNull) exitWith {false};

private _network = [_networkName] call FUNC(network);

private _index = _network get "destinations" findIf { _x get "target" isEqualTo _target };

if (_index == -1) exitWith {false};
_network get "destinations" deleteAt _index;

true
