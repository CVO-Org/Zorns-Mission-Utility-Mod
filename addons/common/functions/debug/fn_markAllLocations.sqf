#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to put a marker on all locations.
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


params [ ["_filter", [], [[]] ] ];

private _worldSize = worldSize;


{

    private _loc = _x;
    _filter pushBackUnique "Mount";
    if (type _loc in _filter) then {continue;};
    
    private _marker = createMarkerLocal [ format ["Location_%1", _forEachIndex ], locationPosition _loc];
    _marker setMarkerTypeLocal "selector_selectedFriendly";
    _marker setMarkerText format ["%1: %2 -%3",_forEachIndex, className _loc, type _loc ];

    
} forEach nearestLocations [
    [_worldSize/2, _worldSize/2],
    [],
    sqrt (2 * _worldSize^2)
];


