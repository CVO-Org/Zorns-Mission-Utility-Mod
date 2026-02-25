#include "../../script_component.hpp"

/*
* Author: Zorn
* This function will be executed on the server and will handle the delivery of the crates.
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

private _cfg = [ QGVAR(delivery_modes), _className ] call EFUNC(catalog,getEntry);

private _stringCode = getText (_cfg >> "code");

private _code = _stringCode call CBA_fnc_convertStringCode;

private _parameters = (_cfg >> "parameters") call cba_fnc_getCfgDataHashmap;

ZRN_LOG_MSG_1(Request Recieved - Init Delivery,_className);

[_request, _parameters] call _code;

nil
