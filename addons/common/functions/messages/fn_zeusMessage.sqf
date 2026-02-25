#include "../../script_component.hpp"

/*
 * Author: 654wak654
 * Shows the given Zeus feedback message.
 * Handles localization and formatting multiple arguments.
 *
 * Arguments:
 * 0: Message <STRING>
 * N: Anything <ANY> (default: nil)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Message: %1", _hint] call zen_common_fnc_showMessage
 *
 * Public: Yes
*/

if !(_this isEqualTypeParams [""]) exitWith {
    ERROR_1("First argument must be a string - %1.",_this);
};

private _message = _this apply {if (_x isEqualType "" && {isLocalized _x}) then {localize _x} else {_x}};

if ([] call CBA_fnc_getActiveFeatureCamera isEqualTo "curator") then {
    
    [objNull, format _message] call BIS_fnc_showCuratorFeedbackMessage;

} else {
    [
        ["Zeus Message:", 1.5, [1, 1, 0, 1]],
        format _message
    ] call CBA_fnc_notify;
};

