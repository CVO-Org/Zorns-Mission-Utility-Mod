#include "../../script_component.hpp"

/*
* Author: Zorn
* UI Event Fnc
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

params ["_control", "", ""]; // [control, _lbCurSel, sth]

private _display = ctrlParent _control;

// Trigger instant update of the list/buttons
_display call FUNC(ui_update);

// trigger update of map frame
[ _display, _display displayCtrl 1600 ] call FUNC(ui_update_map);
