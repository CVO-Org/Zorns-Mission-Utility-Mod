#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to check the conditions and update the Arrows (Enable/Disable)
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* nil call prefix_component_fnc_functionname
*
* Public: No
*/


private _display = findDisplay MUM_IDD_CSC_REQUEST;

private _curTotal = _display getVariable [QGVAR(totalCrates), 0];
private _maxCrates = _display getVariable [QGVAR(maxCrates), 3];

private _curSel_delivery_mode = _display getVariable QGVAR(delivery_modes) select lbCurSel MUM_IDC_CSC_Delivery_ListBox;

private _isBusy = !isNil format ["%1_isBusy", _curSel_delivery_mode];


// Disable OK Button if more Crates are selected then maximum possible
switch (true) do {
    case ( _isBusy ): {
        ctrlEnable [MUM_IDC_CSC_ButtonOK, false];
        ctrlSetText [MUM_IDC_CSC_Status, "The selected delivery mode is currently busy."];
    };
    case ( _curTotal isEqualTo 0 ): {
        ctrlEnable [MUM_IDC_CSC_ButtonOK, false];
        ctrlSetText [MUM_IDC_CSC_Status, "No crates selected."];
    };
    case ( _curTotal >  _maxCrates ): {
        ctrlEnable [MUM_IDC_CSC_ButtonOK, false];
        ctrlSetText [MUM_IDC_CSC_Status, "Too many crates selected."];
    };
    case ( _curTotal <= _maxCrates ): {
        ctrlEnable [MUM_IDC_CSC_ButtonOK, true ];
        ctrlSetText [MUM_IDC_CSC_Status, "Request can be processed."];
    };
};
