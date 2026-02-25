#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
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

params ["_display"];

[
    {
        !(_this isNil QGVAR(delivery_modes))
    },
    {
        // QGVAR(destinations), QGVAR(delivery_modes)

        [_this] call FUNC(ui_crates_init);

    }, 
    _display
] call CBA_fnc_waitUntilAndExecute;
