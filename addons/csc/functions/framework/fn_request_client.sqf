#include "../../script_component.hpp"

/*
* Author: Zorn
* Funciton to handle the request the client to be sent to the server.
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


params [ ["_request", nil, [createHashMap]] ];

if (isNil "_request") exitWith { ZRN_LOG_MSG(something is fucky!); };

ZRN_LOG_MSG_1(Request Recieved - Sending to Server,_request);

[QGVAR(EH_request), [_request]] call CBA_fnc_serverEvent;
