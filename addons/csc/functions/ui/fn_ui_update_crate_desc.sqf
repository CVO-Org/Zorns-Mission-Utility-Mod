#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to update the Description Text of the Crates Section
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

if (_index isEqualTo -1) exitWith {
    ctrlSetText [
        MUM_IDC_CSC_Crates_ListNBox_Description,
        "No crate selected."
    ];
};

// Get CFG of the selected row
private _cfg = [
    QGVAR(crates),
    _display getVariable QGVAR(crates) select _index, // Get classname from display based on currently selected
    configNull
] call EFUNC(catalog,getEntry);

private _items = getArray (_cfg >> "items") apply { [_x#0 call cba_fnc_getItemConfig, _x#1] } select { _x#0 isNotEqualTo configNull };

private _desc ="Content:\n";

{
    _x params ["_cfg", "_quantity"];
    private _line = format [
        "%1x %2\n",
        [_quantity, 5] call EFUNC(common,stringPadding),
        getText (_cfg >> "displayName")
    ];
    _desc = _desc + _line;
} forEach _items;

ctrlSetText [
    MUM_IDC_CSC_Crates_ListNBox_Description,
    _desc
];
