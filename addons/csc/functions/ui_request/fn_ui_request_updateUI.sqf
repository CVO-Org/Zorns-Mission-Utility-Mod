#include "..\..\script_component.hpp"

/*
* Author: Zorn
* UI Function to update all UI Elements
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

// Update Crates
[] call FUNC(ui_request_update_crate_desc);

// Update Delivery Method
[] call FUNC(ui_request_delivery_onSelected); // ToDo

// Update Destination
[] call FUNC(ui_request_destination_onSelected); // ToDo

// Update Validation
[] call FUNC(ui_request_update_arrows);
// call FUNC(ui_request_update_canRequest); // Gets triggered through update_arrows
