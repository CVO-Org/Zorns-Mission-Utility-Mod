#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to check and update the max possible crates.
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

params ["", "_index"];

private _display = findDisplay MUM_IDD_CSC_REQUEST;

// Get cfg based on index of currently selected.

private _cfg = [
    QGVAR(destinations),
    _display getVariable QGVAR(destinations) select _index, // Get classname from display based on currently selected
    configNull
] call EFUNC(catalog,getEntry);

// Store currently selected Mode
_display setVariable [QGVAR(destination), toLower configName _cfg];

private _text = getText (_cfg >> "description");

ctrlSetText [MUM_IDC_CSC_Destination_Description, _text];
