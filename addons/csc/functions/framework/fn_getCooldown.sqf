#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Retrieves remaining cooldown time for a delivery mode.
*
* Arguments:
* 0: _deliveryClassName - Delivery mode classname/ID <STRING>
*
* Return Value:
* Remaining cooldown in seconds, or false if no cooldown active <NUMBER or BOOL>
*
* Example:
* ["airdrop_heli"] call mum_csc_fnc_getCooldown
*
* Public: No
*/

params ["_deliveryClassname"];

switch (true) do {
    case ( isNil QGVAR(cooldowns) ): { false };
    case ( GVAR(cooldowns) isNil _deliveryClassname ): { false };
    default { (GVAR(cooldowns) get _deliveryClassname) - CBA_missionTime }
} // return
