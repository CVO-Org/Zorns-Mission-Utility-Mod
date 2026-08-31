#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns remaining time in seconds or false, if there is no cooldown.
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

params ["_deliveryClassname"];

switch (true) do {
    case ( isNil QGVAR(cooldowns) ): { false };
    case ( GVAR(cooldowns) isNil _deliveryClassname ): { false };
    default { (GVAR(cooldowns) get _deliveryClassname) - CBA_missionTime }
} // return
