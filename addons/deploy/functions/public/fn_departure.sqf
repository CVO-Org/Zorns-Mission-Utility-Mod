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
* [this] call MUM_deploy_fnc_departure;
*
* Public: Yes
*/


params [
    ["_object",         objNull,    [objNull]     ],
    ["_networkName",    "Default",  [objNull, ""] ],
    ["_offset",         [0,0,0],    [[]], [3]     ]
];

if (_object isEqualTo objNull) exitWith {};
_object setVariable [QGVAR(NetworkName), _networkName];

private _network = [_networkName] call FUNC(network);

_network get "departure" pushBackUnique _object;

[_object, _networkName, _offset] call FUNC(addAction);

