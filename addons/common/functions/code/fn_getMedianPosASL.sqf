#include "../../script_component.hpp"

/*
* Author: Zorn - Jenna
* returns middle position of all objects within a layer
*
* Arguments:
0   _objectArray <array> Array of Objects to calculate median position. (ASL)
*
* Return Value:
* _medianPosition - Position in ASL Format
*
* Example:
* [_objArray, true] call mum_common_fnc_getMedianPosASL
*
* Public: Yes
*/

params [
    [ "_input",               [],     [[]]    ],
    [ "_returnMinMaxRadius",  false,  [true]  ]
];

if (_input isEqualTo []) exitWith {false};


// get Median Position as "target pos" - thanks jenna!

private _positions = _input apply {
    switch (true) do {
        case (_x isEqualType []): { _x };
        case (_x isEqualType objNull): { getPosASL _x };
        default { nil };
    };
} select { !isNil "_x" };

private _medianPosition = [];
{ _medianPosition = _medianPosition vectorAdd _x; } forEach _positions;
_medianPosition = _medianPosition vectorMultiply (1/count _positions);

private _radii = _positions apply { _medianPosition vectorDistance _x };

[ _medianPosition, [_medianPosition, selectMin _radii, selectMax _radii]] select _returnMinMaxRadius // return
