#include "../../script_component.hpp"

/*
* Author: Zorn
* Unload Function - Reads UI Variables and creates the request-hashmap
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

params ["_display", "_exitCode"];

if (_exitCode == 2) exitWith {}; //


// Get Crates
private _crate_list = call FUNC(ui_request_crates_getCratesFromControl);

private _crates = [];
{
    _x params ["_classname", "_amount"];
    if (_amount == 0) then { continue };
    for "_i" from 1 to _amount do { _crates pushBack _className; };

} forEach _crate_list;

// Create Request dataset
private _request = createHashMapFromArray [
    [ "crates",        _crates ],
    [ "requester",     _display getVariable "requester" ],
    [ "target",        _display getVariable "target" ],
    [ "destination",   _display getVariable QGVAR(destination) ],
    [ "delivery_mode", _display getVariable QGVAR(delivery_mode) ],
    [ "isZeus",        _display getVariable "isZeus" ],
    [ "accessPointID", _display getVariable "accessPointID" ]
];

ZRN_LOG_MSG_1(REQUEST Established. Handling Destination next,_request);

[_request] call FUNC(handle_destination);

// Remove updateUI EventHandler
[QGVAR(EH_updateCSCRequestUI), GVAR(EHID_updateCSCRequestUI)] call CBA_fnc_removeEventHandler;
GVAR(EHID_updateCSCRequestUI) = nil;

nil
