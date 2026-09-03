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


if (_index isEqualTo -1) exitWith { ctrlSetText [ MUM_IDC_CSC_Destination_Description, "Nothing selected." ]; };

private _display = findDisplay MUM_IDD_CSC_REQUEST;

// Get cfg based on index of currently selected.

private _destinationMap = [
    QGVAR(destinations),
    _display getVariable QGVAR(destinations) select _index, // Get classname from display based on currently selected
    createHashMap
] call EFUNC(catalog,getEntry);

// Store currently selected Mode
_display setVariable [QGVAR(destination), _destinationMap get "id"];

private _text = _destinationMap get "description_string";

ctrlSetText [MUM_IDC_CSC_Destination_Description, _text];
