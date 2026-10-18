#include "../../script_component.hpp"

/*
* Author: Zorn
* onLoad handler of the request dialog: initializes the lists once the registry is available.
*
* Arguments:
* 0: _display - Request dialog <DISPLAY>
*
* Return Value:
* None
*
* Example:
* [_display] call mum_csc_fnc_ui_request_onLoad
*
* Public: No
*/

params ["_display"];

[
    {
        !(_this isNil QGVAR(deliveryModes))
    },
    {
        // QGVAR(destinations), QGVAR(deliveryModes)

        _this call FUNC(ui_request_crates_init);
    },
    _display
] call CBA_fnc_waitUntilAndExecute;
