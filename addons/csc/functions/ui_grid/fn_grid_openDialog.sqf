#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to open the Enter Grid-Coordinates Dialog.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [] call mum_csc_fnc_request_openDialog;
*
* Public: No
*/


params ["_request", "_parameters"];

private _display = createDialog [QGVAR(gridCoordinates), true];

nil
