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

nil
