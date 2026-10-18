#include "../../script_component.hpp"

/*
* Author: Zorn
* Selection handler of the crate list: updates the crate description and the +/- buttons.
*
* Arguments:
* 0: _ctrl - Crate list <CONTROL>
* 1: _index - Selected row <NUMBER>
*
* Return Value:
* None
*
* Example:
* [_ctrl, 0] call mum_csc_fnc_ui_request_crates_onLBSelChanged
*
* Public: No
*/

params ["_ctrl", "_index"];

call FUNC(ui_request_update_crate_desc);

call FUNC(ui_request_update_arrows);
