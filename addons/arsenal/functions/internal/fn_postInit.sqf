#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to init CBA Custom Events
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

if !(hasInterface) exitWith {};

player addEventHandler ["Respawn", {
    if (SET(load_onRespawn)) then {
        params ["_unit", "_corpse"];

        private _loadout = player getVariable [QGVAR(Loadout), []];
        [player, _loadout] call CBA_fnc_setLoadout;
    };
}];

// Apply 3den Attribute Roles
private _3denRoles = player getVariable [QGVAR(3den_roles), ""] splitString ", ";
if (_3denRoles isNotEqualTo []) then { [ player, _3denRoles ] call FUNC(addUnitRoles); };

nil
