#include "../../script_component.hpp"

/*
* Author: Zorn
* Returns the MUM Arsenal roles of a unit.
*
* Arguments:
* 0: Unit <OBJECT> (default: ACE_player)
*
* Return Value:
* Roles, lowercase <ARRAY of STRINGS>
*
* Example:
* [ACE_player] call mum_arsenal_fnc_getUnitRoles;
*
* Public: No
*/

params [
    ["_unit", ACE_player, [objNull] ]
];

if (isNull _unit) exitWith {[]};

private _roles = _unit getVariable [QGVAR(roles), []];

_roles apply { toLowerANSI _x } // Return
