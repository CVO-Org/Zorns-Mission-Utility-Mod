#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to get a crates current counter.
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

params [ "_group", "_crateID" ];

GVAR(counters) getVariable [ _group, createHashMap ] getOrDefault [ _crateID, 0 ]
