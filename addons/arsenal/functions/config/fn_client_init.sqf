#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to handle the init of the arsenal access points on the individual clients.
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

// Un-used alternative to cba globalJIP. not needed anymore. delete later maybe.

if !(hasInterface) exitWith {};

[
    { !isNil QGVAR(globalAccesspointArray) },
    {
        ZRN_LOG_MSG(GlobalAccessPoints detected - applying Actions);
        GVAR(globalAccesspointArray) call FUNC(addAction);
    },
    "",
    90,
    { ZRN_LOG_MSG(globalAccesspointArray not found - timeout); }
] call CBA_fnc_waitUntilAndExecute;
