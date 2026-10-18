#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to update the Description Text of the Crates Section
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* call mum_csc_fnc_ui_request_update_crate_desc
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
private _map = [
    QGVAR(crates),
    _display getVariable QGVAR(crates) select _index, // Get classname from display based on currently selected
    createHashMap
] call EFUNC(catalog,getEntry);

// Nested Array of Items and Backpacks: [config, amount]
private _items = (_map get "items") apply { [_x#0 call cba_fnc_getItemConfig, _x#1] };
_items append ((_map getOrDefault ["backpacks", []]) apply { [configFile >> "CfgVehicles" >> _x#0, _x#1] });
_items = _items select { !isNull (_x#0) };

// Create list of items
private _lines = ["Content:"];

{
    _x params ["_cfg", "_quantity"];
    private _line = format [
        "%1x %2",
        [_quantity, 5] call EFUNC(common,stringPadding),
        getText (_cfg >> "displayName")
    ];
    _lines pushBack _line;
} forEach _items;

ctrlSetText [
    MUM_IDC_CSC_Crates_ListNBox_Description,
    _lines joinString "\n"
];
