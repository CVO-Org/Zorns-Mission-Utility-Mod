#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to increase
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

params ["_request", "_cratesData"];


private _mode = _request getOrDefault ["limitMode", "GLOBAL"];

private _group = switch (_mode) do {
    case "Side": { str side (_request get "requester") };
    case "AccessPoint": { _request get "AccessPointID" };
    case "Global": { "#global" };
    default { "#global" };
};

private _groupIDs = _cratesData apply { _x get "id" };

[  _group,  _groupIDs ] call FUNC(addCratesCounter);
[ "#stats", _groupIDs ] call FUNC(addCratesCounter);
