#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to open the Custom Supply Crate Dialog.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [] call mum_csc_fnc_openDialog;
*
* Public: No
*/


params [["_target", objNull], ["_player", ACE_player], ["_params", []]];

_params params [["_accessPoint", createHashMap]];

//// Input Sanitasation
private _crates = _accessPoint getOrDefault [QGVAR(crates), []];
private _destinations = _accessPoint getOrDefault [QGVAR(destinations), []];
private _delivery_modes = _accessPoint getOrDefault [QGVAR(delivery_modes), []];
private _isZeus = _accessPoint getOrDefault ["isZeus", false];





private _display = createDialog [QGVAR(request), true];

_display setVariable ["requester", _player];
_display setVariable ["target", _target];
_display setVariable ["isZeus", _isZeus];

_display setVariable [
    QGVAR(crates),
    [_crates, keys (missionNamespace getVariable QGVAR(crates))] select (_crates isEqualTo [])
];

_display setVariable [
    QGVAR(destinations),
    [_destinations, keys (missionNamespace getVariable QGVAR(destinations))] select (_destinations isEqualTo [])
];

_display setVariable [
    QGVAR(delivery_modes),
    [_delivery_modes, keys (missionNamespace getVariable QGVAR(delivery_modes))] select (_delivery_modes isEqualTo [])
];

// Add Tooltips to all 3 Description Text Boxes.
displayCtrl MUM_IDC_CSC_Crates_ListNBox_Description ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
displayCtrl MUM_IDC_CSC_Delivery_Description        ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
displayCtrl MUM_IDC_CSC_Destination_Description     ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
