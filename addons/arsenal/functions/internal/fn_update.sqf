#include "../../script_component.hpp"

/*
    Author: Mr. Zorn

    Description:
        returns the _finalKit Array to be used in the CVO Arsenal.

    Parameter(s):

    Returns:
        <Array> List of classnames of additional gear to be used in ACE Arsenal

    Examples:
        <example>
        [] call cvo_arsenal_fnc_update;
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
systemChat format ['[CVO][ARSENAL] Player Roles: %1', _roles];

// ## get PlayerUID
private _id64 = getPlayerUID _unit;

// ## Get Kits Catalog
private _kits = ["arsenal_kits"] call EFUNC(catalog,getCatalog);

// Start Recursive Function
ZRN_LOG_MSG(Updating the Arsenal Kits...);
[_box, _unit, _roles, _id64, _kits] call FUNC(addItemsFromKit_recursive);

nil
