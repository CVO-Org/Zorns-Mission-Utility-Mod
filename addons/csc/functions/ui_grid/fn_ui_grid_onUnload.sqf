#include "../../script_component.hpp"

/*
* Author: Zorn
* onUnload handler of the grid coordinates dialog: stores the entered position, or false when cancelled, in mum_csc_waitForGridCoordinates.
*
* Arguments:
* 0: _display - Dialog <DISPLAY>
* 1: _exitCode - Exit code, 1 for OK <NUMBER>
*
* Return Value:
* None
*
* Example:
* [_display, 1] call mum_csc_fnc_ui_grid_onUnload
*
* Public: No
*/

params ["_display", "_exitCode"];


GVAR(waitForGridCoordinates) = switch (_exitCode) do {
    case 1: { _display getVariable QGVAR(position) };
    default { false };
};

nil
