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

private _crates = _display getVariable QGVAR(crates);

// get crate data
private _array = [];
{
    _array pushBack [
        [
            GVAR(crates) get _x getOrDefault ["displayName", "EMPTY"],
            "0"
        ],  // Text
        [
            0
        ],  // value
        [
            _x
        ]   // Data // Config Name
    ]
} forEach _crates;   // array of Configs

// add crate data
lnbAddArray [ MUM_IDC_CSC_Crates_ListNBox, _array ];
lbSetCurSel [MUM_IDC_CSC_Crates_ListNBox, 0];
call FUNC(ui_request_update_crate_desc);

//// Update Destination ListBox
{
    lbAdd [
        MUM_IDC_CSC_Destination_ListBox,
        GVAR(destinations) get _x getOrDefault ["displayName", "EMPTY"]
    ];
} forEach (_display getVariable QGVAR(destinations));   // array of Configs
lbSetCurSel [MUM_IDC_CSC_Destination_ListBox, 0];


//// Update Delivery Mode ListBox
{
    lbAdd [
        MUM_IDC_CSC_Delivery_ListBox,
        GVAR(deliveryModes) get _x getOrDefault ["displayName", "EMPTY"]
    ];
} forEach (_display getVariable QGVAR(deliveryModes));   // array of Configs
lbSetCurSel [MUM_IDC_CSC_Delivery_ListBox, 0];
