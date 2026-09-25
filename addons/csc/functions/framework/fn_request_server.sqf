#include "../../script_component.hpp"

/*
* Author: Zorn
* Server-side request handler.
* Creates crate objects from classnames, updates request structure, executes delivery handling.
*
* Arguments:
* 0: _request - Request hashmap with delivery_mode, destination, crate IDs, etc. <HASHMAP>
*
* Return Value:
* nil
*
* Example:
* [requestHashMap] call mum_csc_fnc_request_server
*
* Public: No
*/

params ["_request"]; // hashmap
// INFO_1(Request Recieved On Server: %1,_request);

private _cratesData = _request get "crates" apply { GVAR(crates) get _x };

//// Handle Limited Crates
[_request, _cratesData] call FUNC(increaseCrateCounters);


// Update CSC UI on other clients
[QGVAR(EH_updateCSCRequestUI)] call CBA_fnc_globalEvent;

//// Handle Creation of the Crates
// Array of Classnames -> Array of hashmaps -> crate objects
private _crates = _cratesData apply { [_x] call FUNC(createCrate) };


// Store the crates in the request hashmap
_request set ["crates", _crates];

ZRN_LOG_MSG_1(Crates created. Next: Delivery,_crates);

[_request] call FUNC(handle_delivery);

nil
