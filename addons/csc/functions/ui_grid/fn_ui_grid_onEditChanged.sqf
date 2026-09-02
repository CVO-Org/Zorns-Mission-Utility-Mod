#include "..\..\script_component.hpp"

/*
* Author: Zorn
* UI Function to verify the provided input.
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

private _display = findDisplay MUM_IDD_CSC_GRIDCORD;

// Get Content of both Edit X and Y
private _stringX = ctrlText MUM_IDC_CSC_GRID_X;
private _stringY = ctrlText MUM_IDC_CSC_GRID_Y;

private _arrayX = _stringX splitString "" select { _x in [ "0","1","2","3","4","5","6","7","8","9" ] } apply { parseNumber _x };
private _arrayY = _stringY splitString "" select { _x in [ "0","1","2","3","4","5","6","7","8","9" ] } apply { parseNumber _x };

// Verify if current input is valid coordinates
private _isValid = switch (false) do {
    case ( count _stringX isEqualTo count _arrayX ): { false };
    case ( count _stringY isEqualTo count _arrayY ): { false };
    case ( count _arrayX  isEqualTo count _arrayY ): { false };
    case ( _stringX isNotEqualTo "" ): { false };
    default { true };
};

// If Valid coordinates, update _display SetVar and enable button, else set nil and disable button
if (_isValid) then {

    private _position = [_stringX + _stringY , true] call ace_common_fnc_getMapPosFromGrid;

    _display setVariable [QGVAR(position), _position];

    ctrlEnable [MUM_IDC_CSC_ButtonOK, true ];
    ctrlSetText [MUM_IDC_CSC_Status, format ["Valid Input: %1-%2", _stringX, _stringY]];

} else {

    ctrlEnable [MUM_IDC_CSC_ButtonOK, false ];
    _display setVariable [QGVAR(position), nil];

    ctrlSetText [MUM_IDC_CSC_Status, "Invalid Input"];

};

nil
