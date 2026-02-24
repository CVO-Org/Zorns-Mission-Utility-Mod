#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to get the cvo arsenal roles of a unit
*
* Arguments:
*
* Return Value:
* Array of Roles
*
* Example:
* [ace_player] call cvo_arsenal_fnc_getUnitRoles;
*
* Public: No
*/

params [
    ["_unit", ACE_player, [objNull] ]
];

if (isNull _unit) exitWith {[]};

private _roles = _unit getVariable [QGVAR(roles), []];

_roles apply { toLowerANSI _x } // Return
