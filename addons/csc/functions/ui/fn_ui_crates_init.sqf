#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to update the ListNBox control
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

params ["_display"];


//// Update Crates ListNBox
// Init Vars
_display setVariable [QGVAR(maxCrates), 3];
_display setVariable [QGVAR(totalCrates), 0];

// get crate data
private _array = [];
{
    _array pushBack [
        [
            getText ([QGVAR(crates), _x, configNull] call EFUNC(catalog,getEntry) >> "displayName"),
            "0"
        ],  // Text
        [
            0
        ],  // value
        [
            _x
        ]   // Data // Config Name
    ]
} forEach (_display getVariable QGVAR(crates));   // array of Configs

// add crate data
lnbAddArray [ MUM_IDC_CSC_Crates_ListNBox, _array ];
lbSetCurSel [MUM_IDC_CSC_Crates_ListNBox, 0];
call FUNC(ui_update_crate_desc);

//// Update Destination ListBox
{
    lbAdd [
        MUM_IDC_CSC_Destination_ListBox,
        getText ([QGVAR(destinations), _x, configNull] call EFUNC(catalog,getEntry) >> "displayName")
    ];
} forEach (_display getVariable QGVAR(destinations));   // array of Configs
lbSetCurSel [MUM_IDC_CSC_Destination_ListBox, 0];


//// Update Delivery Mode ListBox
{
    lbAdd [
        MUM_IDC_CSC_Delivery_ListBox,
        getText ([QGVAR(delivery_modes), _x, configNull] call EFUNC(catalog,getEntry) >> "displayName")
    ];
} forEach (_display getVariable QGVAR(delivery_modes));   // array of Configs
lbSetCurSel [MUM_IDC_CSC_Delivery_ListBox, 0];
