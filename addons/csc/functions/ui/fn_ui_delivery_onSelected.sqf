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

private _deliveryMap = [
    QGVAR(deliveryModes),
    _display getVariable QGVAR(deliveryModes) select _index, // Get classname from display based on currently selected
    createHashMap
] call EFUNC(catalog,getEntry);

// Store currently selected Mode
_display setVariable [QGVAR(delivery_mode), _deliveryMap get "id"];

//// Update Max Crates
private _maxCrates = _deliveryMap get "maxCrates";
_display setVariable [QGVAR(maxCrates), _maxCrates];

// Request crate amount check
[] call FUNC(ui_update_arrows);


//// Update Description
private _code_desc = _deliveryMap get "code_description" call CBA_fnc_convertStringCode;

private _desc = _deliveryMap call _code_desc;
_desc = format ["Up to %1 crates%2", _maxCrates, _desc];

ctrlSetText [
    MUM_IDC_CSC_Delivery_Description,
    _desc
];
