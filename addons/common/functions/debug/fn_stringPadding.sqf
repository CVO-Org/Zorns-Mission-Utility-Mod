#include "../../script_component.hpp"

/*
* Author: Zorn
* This function returns a string with padding to be as long as the desired value.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [_str, _targetWidth] call mum_common_fnc_stringPadding
*
* Public: No
*/

params [
    "_str",
    [ "_width",     2,          [0]  ],
    [ "_align",     "RIGHT",    [""] ],
    [ "_padding",   " ",        [""] ]
];


if !(_str isEqualType "") then { _str = str _str };

private _countStr = count _str;

if ( _countStr >= _width ) exitWith { _str };

private _reqPadding = _width - _countStr;

for "_i" from 1 to _reqPadding do {

    switch (_align) do {
        case "LEFT":  { _str = _str insert [-1, _padding]; };
        case "RIGHT": { _str = _str insert [ 0, _padding]; };
        case "CENTER";
        default {
            if (_i mod 2 == 0) then {
                _str = _str insert [-1, _padding];
            } else {
                _str = _str insert [ 0, _padding];
            };
        };
    };
};

_str
