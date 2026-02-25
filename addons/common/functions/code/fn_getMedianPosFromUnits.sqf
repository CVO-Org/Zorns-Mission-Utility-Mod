#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to provide a safePos based of the MedianPosASL of a group of units
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
    ["_units",        objNull,         [objNull, []]       ]
];

if (_units isEqualType objNull) then { _units = [_units]; };

_units = _units select { ! isNull _x };

[ _units, true ] call mum_common_fnc_getMedianPosASL params [ "_position", "_minRadius", "_maxRadius" ];

// finds a safe pos around the median pos, with a radius being the average of min and max distance from median pos
[ ASLToAGL _position, 0, (_maxRadius + _minRadius) / 2, 2, 0, 0.1, 0 ] call BIS_fnc_findSafePos // return
