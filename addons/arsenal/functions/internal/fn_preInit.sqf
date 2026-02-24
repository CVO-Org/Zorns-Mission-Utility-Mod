#include "../../script_component.hpp"

/*
* Author: Zorn
* PreInit Function
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

[QGVAR(EH_initBox), FUNC(initBox)] call CBA_fnc_addEventHandler;

["ace_arsenal_displayClosed", {
    if (SET(save_arsenalClose)) then {

        [
            {
                private _loadout = [ace_player] call CBA_fnc_getLoadout;
                player setVariable [QGVAR(Loadout), _loadout];
            },
            [],
            3
        ] call CBA_fnc_waitAndExecute;
    };
}] call CBA_fnc_addEventHandler;
