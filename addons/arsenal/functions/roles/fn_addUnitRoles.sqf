#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add a role to the Unit
*
* Arguments:
* 0 - OBJECT - Unit whose roll shall be configured
* 1 - STRING or ARRAY OF STRINGS - Role Identifier - needs to match the role property of the kit configuration. Not case-sensitive.
*
* Return Value:
* None
*
* Example:
* [this, "someRole"] call mum_arsenal_fnc_addUnitRoles;
* [this, ["someRole", "anotherRole"]] call mum_arsenal_fnc_addUnitRoles;
*
* Public: yes
*/

params [
    [ "_unit",  objNull,    [ objNull ] ],
    [ "_roles", "",         [ [], ""  ] ]
];

if ( isNull _unit ) exitWith { ERROR_1("Unit not found - could not apply roles: %1",_roles); false };
if ( _roles isEqualTo "" ) exitWith { ERROR_1("No roles provided for unit: %1",_unit); false };

if ( _roles isEqualType "" ) then { _roles = [_roles]; };

_roles = _roles apply { toLowerANSI _x };

{ _roles pushBackUnique _x; } forEach ([_unit] call FUNC(getUnitRoles));

[_unit, _roles] call FUNC(setUnitRoles);

true
