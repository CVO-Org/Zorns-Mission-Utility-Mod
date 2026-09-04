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


params [ ["_player", ACE_player], ["_target", objNull], "_accessPointID" ];

//// Input Sanitasation

if (isNil "_accessPointID" && {_target isNil QGVAR(accessPointID)}) exitWith {};
if (isNil "_accessPointID" ) exitWith { _accessPointID = _target getVariable QGVAR(accessPointID) };

private _accessPointData = GVAR(accessPoints) getOrDefault [_accessPointID, createHashMap];

private _crates =        _accessPointData getOrDefault [ "crates",        [] ];
private _destinations =  _accessPointData getOrDefault [ "destinations",  [] ];
private _deliveryModes = _accessPointData getOrDefault [ "deliveryModes", [] ];

private _display = createDialog [QGVAR(request), true];

_display setVariable ["requester", _player];
_display setVariable ["target", _target];
_display setVariable ["isZeus", _accessPointID isEqualTo "#ZEUS"];


_display setVariable [ QGVAR(crates),        [ _crates,        "CRATES"       ] call FUNC(validateFrameworkIDs) ];
_display setVariable [ QGVAR(destinations),  [ _destinations,  "DESTINATIONS" ] call FUNC(validateFrameworkIDs) ];
_display setVariable [ QGVAR(deliveryModes), [ _deliveryModes, "DELIVERYMODES"] call FUNC(validateFrameworkIDs) ];

// Add Tooltips to all 3 Description Text Boxes.
displayCtrl MUM_IDC_CSC_Crates_ListNBox_Description ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
displayCtrl MUM_IDC_CSC_Delivery_Description        ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
displayCtrl MUM_IDC_CSC_Destination_Description     ctrlSetTooltip "Click on textbox and use Arrow Up and Down to scroll.";
