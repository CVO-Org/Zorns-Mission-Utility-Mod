#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to update the crateLimit of the currently selected Crate
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

// Update the crate description below.
private _display = findDisplay MUM_IDD_CSC_REQUEST;

// Get Current Index
private _index = lbCurSel MUM_IDC_CSC_Crates_ListNBox;

private _crates = _display getVariable QGVAR(crates);
