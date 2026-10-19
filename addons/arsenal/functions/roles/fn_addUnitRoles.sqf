#include "../../script_component.hpp"

/*
* Author: Zorn
* Adds one or more roles to a unit, keeping its existing roles.
*
* Arguments:
* 0: Unit <OBJECT>
* 1: Role identifier(s) - need to match the role property of a kit. Not case-sensitive <STRING or ARRAY of STRINGS>
*
* Return Value:
* Roles applied <BOOL>
*
* Example:
* [this, "someRole"] call mum_arsenal_fnc_addUnitRoles;
* [this, ["someRole", "anotherRole"]] call mum_arsenal_fnc_addUnitRoles;
*
* Public: Yes
*/

params [
    [ "_unit",  objNull,    [ objNull ] ],
    [ "_roles", "",         [ [], ""  ] ]
];

if ( isNull _unit ) exitWith { ERROR_1("Unit not found - could not apply roles: %1",_roles); false };
if ( _roles isEqualTo "" ) exitWith { ERROR_1("No roles provided for unit: %1",_unit); false };

if ( _roles isEqualType "" ) then { _roles = [_roles]; };

_roles = _roles apply { toLowerANSI _x };

private _array = [];

{ _array pushBackUnique _x; } forEach _roles;
{ _array pushBackUnique _x; } forEach ([_unit] call FUNC(getUnitRoles));

[_unit, _array] call FUNC(setUnitRoles);

true
