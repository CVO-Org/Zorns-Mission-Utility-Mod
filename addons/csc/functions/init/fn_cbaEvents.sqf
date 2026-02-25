#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add CBA Events
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


// CBA Events for the cration of the Crate
[
    QGVAR(EH_ace_setDraggable),
    {
        if !(hasInterface) exitWith {};
        _this call ace_dragging_fnc_setDraggable;
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(EH_ace_setCarryable),
    {
        if !(hasInterface) exitWith {};
        _this call ace_dragging_fnc_setCarryable;
    }
] call CBA_fnc_addEventHandler;

// CBA Events for the handling of the request

[QGVAR(EH_request), FUNC(request_server)] call CBA_fnc_addEventHandler;
