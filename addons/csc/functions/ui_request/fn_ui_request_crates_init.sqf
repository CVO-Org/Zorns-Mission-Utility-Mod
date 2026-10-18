#include "../../script_component.hpp"

/*
* Author: Zorn
* Fills the destination, delivery mode and crate lists of the request dialog.
*
* Arguments:
* 0: _display - Request dialog <DISPLAY>
*
* Return Value:
* None
*
* Example:
* [_display] call mum_csc_fnc_ui_request_crates_init
*
* Public: No
*/

params ["_display"];

// Init Vars
_display setVariable [QGVAR(maxCrates), 3];
_display setVariable [QGVAR(totalCrates), 0];

// Destination and Delivery Mode ListBoxes are populated first,
// as selecting a crate below already requires a selected delivery mode.

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


//// Update Crates ListNBox
private _crates = _display getVariable QGVAR(crates);

_crates sort true;

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
