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

if (_index isEqualTo -1) exitWith { ctrlSetText [ MUM_IDC_CSC_Delivery_Description, "Nothing selected." ]; };

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
[] call FUNC(ui_request_update_arrows);



//// Update Description

// Default Line: Max Crates
private _lines = [ format ["<t size='0.7'><t color='#B3B3B3'>Can transport up to </t>%1 <t color='#B3B3B3'>crates.</t>", _maxCrates] ];

// Handle Cooldown Line
private _cooldown = _deliveryMap get "cooldown";
if (_cooldown isNotEqualTo 0) then {
    private _currentCooldown = _deliveryClassName call FUNC(getCooldown);

    private _line = if (_currentCooldown isNotEqualTo false) then {
        format ["<t color='#B3B3B3'>Remaining Cooldown:</t> <t color='#FFA500'>%1</t>.", _currentCooldown call EFUNC(common,secondsToString)]
    } else {
        format ["<t color='#B3B3B3'>Cooldown when used:</t> %1.", _cooldown call EFUNC(common,secondsToString)]
    };
    _lines pushBack _line;
};

// Handle Code Description
private _code_desc = _deliveryMap get "description_code";
if (_code_desc isNotEqualTo "") then {
    _lines pushBack (_deliveryMap call (_code_desc call cba_fnc_convertStringCode) );
};

// Handle Simple Description
private _stringDescription = _deliveryMap get "description_string";
if (_stringDescription isNotEqualTo "") then {
    _lines pushBack _stringDescription;
};


// Update UI Control
findDisplay MUM_IDD_CSC_REQUEST displayCtrl MUM_IDC_CSC_Delivery_Description ctrlSetStructuredText parseText (_lines joinString "<br />") ;
