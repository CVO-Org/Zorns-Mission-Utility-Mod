#include "../../script_component.hpp"

/*
* Author: Zorn
* Applies the roles from the 3den attribute "Arsenal Roles" to the local player.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call mum_arsenal_fnc_postInit
*
* Public: No
*/

if !(hasInterface) exitWith {};

// Apply 3den Attribute Roles
private _3denRoles = player getVariable [QGVAR(3den_roles), ""] splitString ", ";
if (_3denRoles isNotEqualTo []) then { [ player, _3denRoles ] call FUNC(addUnitRoles); };

nil
