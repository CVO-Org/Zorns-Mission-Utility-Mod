#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to ...
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

params ["_ctrl", "_index"];

call FUNC(ui_request_update_crate_desc);

call FUNC(ui_request_update_arrows);
