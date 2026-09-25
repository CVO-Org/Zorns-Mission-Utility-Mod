#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to return nested array of currently selected crates
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


// Get Crates
private _ctrl_crates = findDisplay MUM_IDD_CSC_REQUEST displayCtrl MUM_IDC_CSC_Crates_ListNBox;
// Extract
// [classname, amount]
private _crate_list = [];
private _size = (lnbSize _ctrl_crates select 0) - 1;


for "_i" from 0 to _size do {
    _crate_list pushBack [
        _ctrl_crates lnbData  [_i, 0],
        _ctrl_crates lnbValue [_i, 0]
    ];
};

_crate_list
