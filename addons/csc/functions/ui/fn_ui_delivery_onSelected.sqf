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

params ["_control", "_index"];

// Common
private _display = findDisplay MUM_IDD_CSC_REQUEST;

private _cfg = [
    QGVAR(delivery_modes),
    _display getVariable QGVAR(delivery_modes) select _index, // Get classname from display based on currently selected
    configNull
] call EFUNC(catalog,getEntry);

// Store currently selected Mode
_display setVariable [QGVAR(delivery_mode), toLower configName _cfg];

//// Update Max Crates
private _maxCrates = getNumber (_cfg >> "maxCrates");
_display setVariable [QGVAR(maxCrates), _maxCrates];

// Request crate amount check
[] call FUNC(ui_update_arrows);


//// Update Description
private _code_desc = getText (_cfg >> "code_description") call CBA_fnc_convertStringCode;

private _desc = _cfg call _code_desc;
_desc = format ["Up to %1 crates%2", _maxCrates, _desc];

ctrlSetText [
    MUM_IDC_CSC_Delivery_Description,
    _desc
];
