#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to check and update the max possible crates.
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

params ["_control", "_index"];

// Common
private _display = findDisplay MUM_IDD_CSC_REQUEST;

private _deliveryMap = [
    QGVAR(deliveryModes),
    _display getVariable QGVAR(deliveryModes) select _index, // Get classname from display based on currently selected
    createHashMap
] call EFUNC(catalog,getEntry);

private _deliveryClassName = _deliveryMap get "id";

// Store currently selected Mode
_display setVariable [QGVAR(delivery_mode), _deliveryClassName];

//// Update Max Crates
private _maxCrates = _deliveryMap get "maxCrates";
_display setVariable [QGVAR(maxCrates), _maxCrates];

// Request crate amount check
[] call FUNC(ui_update_arrows);



//// Update Description

// Default Line: Max Crates
private _lines = [ format ["Can transport up to %1 crates.", _maxCrates] ];

// Handle Cooldown Line
private _cooldown = _deliveryClassName call FUNC(getCooldown);
if (_cooldown isNotEqualTo false) then {
    _cooldown = _cooldown call EFUNC(common,secondsToString);
    _lines pushBack format ["On cooldown for %1.", _cooldown];
};


// Handle Description Lines
private _code_desc = _deliveryMap get "code_description";
if (_code_desc isEqualTo "") then {
    private _basicDescription = _deliveryMap get ["description", ""];
    if (_basicDescription isNotEqualTo "") then { _lines pushBack _basicDescription};
} else {
    private _code_return = (_deliveryMap call (_code_desc call CBA_fnc_convertStringCode));
    if (_code_return isNotEqualTo "") then { _lines pushBack _code_return};
};

// Update UI Control
ctrlSetText [
    MUM_IDC_CSC_Delivery_Description,
    _lines joinString "\n"
];
