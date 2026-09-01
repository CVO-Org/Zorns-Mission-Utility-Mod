#include "../../script_component.hpp"

/*
* Author: Zorn
* Executes delivery mode handler on server.
* Retrieves delivery mode configuration, sets cooldown, executes delivery code with request and parameters.
*
* Arguments:
* 0: _request - Request hashmap containing crates, destination, delivery_mode, isZeus, etc. <HASHMAP>
*
* Return Value:
* nil
*
* Example:
* [requestHashMap] call mum_csc_fnc_handle_delivery
*
* Public: No
*/

/*
private _request = createHashMapFromArray [
    [ "requester",     _display getVariable "requester" ],
    [ "target",        _display getVariable "target"    ],
    [ "crates",        _crates           ], // Objects
    [ "destination",   _display getVariable QGVAR(destination)   ], // position
    [ "delivery_mode", _display getVariable QGVAR(delivery_mode) ] // Classname
];
*/

params ["_request"];

private _className = _request get "delivery_mode";
private _deliveryMap = [ QGVAR(deliveryModes), _className ] call EFUNC(catalog,getEntry);

// Handle Cooldown
private _cooldown = (_deliveryMap get "cooldown") max 0;
if (_cooldown isNotEqualTo 0) then { [_className, _cooldown] call FUNC(setCooldown); };

// Execute Delivery
ZRN_LOG_MSG_1(Request Recieved - Init Delivery,_className);
private _code = _deliveryMap get "code" call CBA_fnc_convertStringCode;
private _parameters = _deliveryMap get "parameters";
[_request, _parameters] call _code;

nil
