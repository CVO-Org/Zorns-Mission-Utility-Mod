#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to run onLoad for MUM_deploy_dialog.
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

params ["_display", ""]; // display, config

// Wait until the network has been attached to the display
[
    {
        !(_this isNil QGVAR(network))
    },
    {
        // Start PFH to update/refresh the dialog content on a regular interval
        private _handle = [{ (_this#0) call FUNC(ui_update) }, 2, _this ] call CBA_fnc_addPerFrameHandler;

        [
            _this,
            _this displayCtrl 1600
        ] call FUNC(ui_update_map);

        // Add pfh handle so it can be stopped onUnload
        _this setVariable [QGVAR(pfh_handle), _handle];
    },
    _display
] call CBA_fnc_waitUntilAndExecute;

