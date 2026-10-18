#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the point on the map edge closest to the input position, or the map corner furthest from it.
*
* Arguments:
* 0: _input - Reference position or object, random position when nil <ARRAY or OBJECT> (default: nil)
* 1: _getFurthest - Return the furthest corner instead of the closest edge <BOOL> (default: false)
*
* Return Value:
* Position [x, y] <ARRAY>
*
* Example:
* [getPos player, true] call mum_csc_fnc_getPosEdge
*
* Public: No
*/

params [
    [ "_input",       nil,   [objNull,[]], [2,3] ],
    [ "_getFurthest", false, [true]              ]
];

// Const Vars
private _worldSize = worldSize;

// Sanitise Input
switch (true) do {
    case ( isNil "_input" ): { [ random _worldSize, random _worldSize] };
    case ( _input isEqualType [] ): { _input };
    case ( _input isEqualType objNull ): { getPos _input };
    default { [ random _worldSize, random _worldSize] };
} params ["_x", "_y"];


private _return = switch (_getFurthest) do {
    case false: {
        private _distLeft   = _x;
        private _distRight  = _worldSize - _x;
        private _distBottom = _y;
        private _distTop    = _worldSize - _y;

        switch (selectMin [_distLeft, _distRight, _distBottom, _distTop]) do {
            case _distLeft:   { [  0,         _y ] };
            case _distRight:  { [ _worldSize, _y ] };
            case _distBottom: { [ _x,          0 ] };
            case _distTop:    { [ _x, _worldSize ] };
        } // return
    };
    case true: {
        [
            [0,_worldSize] select ( _x < (_worldSize / 2) ),
            [0,_worldSize] select ( _y < (_worldSize / 2) )
        ]
    };
}; // Return

_return
