#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Set/Increase Crates count
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

params ["_group", "_crateIDs"];

if !(_crateIDs isEqualType []) then { _crateIDs = [_crateIDs] };

private _counters = GVAR(counters);

private _groupData = _counters getVariable [ _group, createHashMap ];
{ _groupData set [ _x, (_groupData getOrDefault [_x, 0]) + 1 ]; } forEach _crateIDs;

_counters setVariable [ _group, _groupData, true ];
