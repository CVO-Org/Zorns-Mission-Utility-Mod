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
* [] call mum_csc_fnc_request_openDialog;
*
* Public: No
*/


params [["_target", objNull], ["_player", ACE_player], ["_params", []]];

_params params [["_accessPoint", createHashMap]];

//// Input Sanitasation
private _crates = _accessPoint getOrDefault [QGVAR(crates), []];
private _destinations = _accessPoint getOrDefault [QGVAR(destinations), []];
private _delivery_modes = _accessPoint getOrDefault [QGVAR(deliveryModes), []];
private _isZeus = _accessPoint getOrDefault ["isZeus", false];


private _display = createDialog [QGVAR(request), true];

_display setVariable ["requester", _player];
_display setVariable ["target", _target];
_display setVariable ["isZeus", _isZeus];

_display setVariable [ QGVAR(crates),        _crates         ];
_display setVariable [ QGVAR(destinations),  _destinations   ];
_display setVariable [ QGVAR(deliveryModes), _delivery_modes ];

// Add Tooltips to all 3 Description Text Boxes.
displayCtrl MUM_IDC_CSC_Crates_ListNBox_Description ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
displayCtrl MUM_IDC_CSC_Delivery_Description        ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
displayCtrl MUM_IDC_CSC_Destination_Description     ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
