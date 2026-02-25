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

private _ctrlList = _display displayCtrl  MUM_IDC_CSC_Crates_ListNBox;

private _curRow = lnbCurSelRow _ctrlList;


if (_curRow != -1) then {
    private _value = _ctrlList lnbValue [_curRow, 0];

    switch (true) do {
        case (_value <= 0): { ctrlEnable [MUM_IDC_CSC_Crates_ListNBox_arrowMinus, false]; };
        case (_value >  0): { ctrlEnable [MUM_IDC_CSC_Crates_ListNBox_arrowMinus, true ]; };
    };
};


private _curTotal = _display getVariable [QGVAR(totalCrates), 0];
private _maxCrates = _display getVariable [QGVAR(maxCrates), 3];

switch (true) do {
    case (_curTotal >= _maxCrates): { ctrlEnable [MUM_IDC_CSC_Crates_ListNBox_arrowPlus, false]; };
    case (_curTotal <  _maxCrates): { ctrlEnable [MUM_IDC_CSC_Crates_ListNBox_arrowPlus, true ]; };
};

ctrlSetText [MUM_IDC_CSC_Crates_Subtitle_Text, format ["Custom Supply Crates [ %1 / %2 ]", _curTotal, _maxCrates ]];

call FUNC(ui_update_canRequest);
