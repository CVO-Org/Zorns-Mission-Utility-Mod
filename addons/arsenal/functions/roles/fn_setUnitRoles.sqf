#include "../../script_component.hpp"

/*
* Author: Zorn
* Function for Mission Makers to add CVO Arsenal Roles
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [ this, "EOD" ] call mum_arsenal_fnc_setUnitRoles;
* [ this, ["EOD", "Officer"] ] call mum_arsenal_fnc_setUnitRoles;
*
* Public: No
*/

params [
    [ "_unit",  objNull,    [ objNull ] ],
    [ "_roles", "",         [ [], ""  ] ]
];

if ( isNull _unit ) exitWith { ERROR_1("Unit not found - could not apply roles: %1",_roles); false };
if ( _roles isEqualTo "" ) exitWith { ERROR_1("No roles provided for unit: %1",_unit); false };

if ( _roles isEqualType "" ) then { _roles = [_roles]; };

_roles = _roles apply { toLowerANSI _x };

_unit setVariable [QGVAR(roles), _roles];

true
