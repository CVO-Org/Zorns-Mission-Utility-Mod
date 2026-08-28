#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to convert an [itemA, itemA] array into an [ [itemA, n]] array
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


if !( _this isEqualType [] ) exitWith { false };
if  ( _this isEqualTo [] ) exitWith { [] };

private _tempMap = createHashMap;
{ _tempMap set [ _x, (_tempMap getOrDefault [_x, 0]) + 1 ]; } forEach _this;

private _return = [];
{ _return pushBack [_x, _y] } forEach _tempMap;
_return
