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

        private _loadout = player getVariable [QGVAR(savedLoadout), []];
        [player, _loadout] call CBA_fnc_setLoadout;
    };
}];

["ace_arsenal_displayClosed", {
    if (SET(save_arsenalClose)) then {

        [
            {
                private _loadout = [ace_player] call CBA_fnc_getLoadout;
                player setVariable [QGVAR(savedLoadout), _loadout];
            },
            [],
            3
        ] call CBA_fnc_waitAndExecute;
    };
}] call CBA_fnc_addEventHandler;


nil
