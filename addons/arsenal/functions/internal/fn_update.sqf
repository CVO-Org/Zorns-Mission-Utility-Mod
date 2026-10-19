#include "../../script_component.hpp"

/*
* Author: Zorn
* Fills the arsenal box with the items from mum_arsenal_api and all kits available to ACE_player.
*
* Arguments:
* 0: Arsenal box <OBJECT>
*
* Return Value:
* None
*
* Example:
* [mum_arsenal_local_box] call mum_arsenal_fnc_update
*
* Public: No
*/
if (!hasInterface) exitWith {};

params ["_box"];

private _finalKit = [];

_finalKit append ( missionNamespace getVariable [QGVAR(api), []] );

[_box, _finalkit] call ace_arsenal_fnc_addVirtualItems;

private _unit = ACE_player;

// ## get Roles
private _roles = [_unit] call FUNC(getUnitRoles);
_roles = [_unit, _roles] call FUNC(rolesByTrait);
systemChat format ['[%1][%2] Player Roles: %3', PREFIX,COMPONENT,_roles];

// ## get side
private _side = str side _unit;

// ## get PlayerUID
private _id64 = getPlayerUID _unit;

// ## Get Kits Catalog
private _kits = ["arsenal_kits"] call EFUNC(catalog,getCatalog);

// Start Recursive Function
ZRN_LOG_MSG(Updating the Arsenal Kits...);
[_box, _unit, _side, _roles, _id64, _kits] call FUNC(addItemsFromKit_recursive);

nil
