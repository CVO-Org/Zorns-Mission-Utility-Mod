#include "../../script_component.hpp"

/*
* Author: Zorn
* Selection handler of the destination list: stores the selection and updates the description.
*
* Arguments:
* 0: _control - Destination list <CONTROL>
* 1: _index - Selected row <NUMBER>
*
* Return Value:
* None
*
* Example:
* [_ctrl, 0] call mum_csc_fnc_ui_request_destination_onSelected
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
