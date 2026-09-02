#include "../../script_component.hpp"

/*
* Author: Zorn
* Unload Function - Reads UI Variables and creates the request-hashmap
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

params ["_display", "_exitCode"];


GVAR(waitForGridCoordinates) = switch (_exitCode) do {
    case 1: { _display getVariable QGVAR(position) };
    default { false };
};

diag_log text format ['[CVO](debug)(fn_ui_grid_onUnload) GVAR(waitForGridCoordinates): %1', GVAR(waitForGridCoordinates)];
systemChat format ['[CVO](debug)(fn_ui_grid_onUnload) GVAR(waitForGridCoordinates): %1', GVAR(waitForGridCoordinates)];


nil
