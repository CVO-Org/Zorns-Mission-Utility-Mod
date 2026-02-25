#include "../../script_component.hpp"

/*
* Author: Zorn
* Function that handles the +- Buttons for the Crates ListNBox
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [ 1 ] call FUNC(ui_update_crates);
*
* Public: No
*/

params ["_change", ["_buttonCtrl", controlNull]];

if (!isNull _buttonCtrl && { !ctrlEnabled _buttonCtrl }) exitWith { false };

private _display = findDisplay MUM_IDD_CSC_REQUEST;

private _row = lnbCurSelRow MUM_IDC_CSC_Crates_ListNBox;

private _oldValue = lnbValue [MUM_IDC_CSC_Crates_ListNBox, [_row, 0]];
private _newValue = (_oldValue + _change) max 0;

lnbSetValue [ MUM_IDC_CSC_Crates_ListNBox, [ _row, 0 ], _newValue ];
lnbSetText  [ MUM_IDC_CSC_Crates_ListNBox, [ _row, 1 ], str _newValue ];

// Handle total selected crates
private _oldTotal = _display getVariable [QGVAR(totalCrates), 0];
private _newTotal = [ _oldTotal, _oldTotal + _change ] select (_newValue != _oldValue);
_display setVariable [QGVAR(totalCrates), _newTotal];

[] call FUNC(ui_update_arrows);

true
