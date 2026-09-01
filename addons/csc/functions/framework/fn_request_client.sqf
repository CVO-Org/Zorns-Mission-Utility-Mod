#include "../../script_component.hpp"

/*
* Author: Zorn
* Client-side request handler.
* Sends delivery request to server via CBA server event after destination resolution.
*
* Arguments:
* 0: _request - Request hashmap containing crates, destination, delivery_mode info. <HASHMAP>
*
* Return Value:
* nil
*
* Example:
* [requestHashMap] call mum_csc_fnc_request_client
*
* Public: No
*/


params [ ["_request", nil, [createHashMap]] ];

if (isNil "_request") exitWith { ZRN_LOG_MSG(something is fucky!); };

// INFO_1(CLIENT - Request Recieved - Sending to Server: %1,_request);

[QGVAR(EH_request), [_request]] call CBA_fnc_serverEvent;
