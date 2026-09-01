#include "../../script_component.hpp"

/*
* Author: Zorn
* Executes destination resolver on client.
* Resolves destination and returns position for server delivery reference.
* Handles client-side player input like mapclick or grid input.
*
* Arguments:
* 0: _request - Request hashmap containing delivery_mode, destination info, etc. <HASHMAP>
*
* Return Value:
* nil
*
* Example:
* [requestHashMap] call mum_csc_fnc_handle_destination
*
* Public: No
*/

params ["_request"];

private _destinationData = [QGVAR(destinations), _request get "destination", configNull] call EFUNC(catalog,getEntry);

private _return = [_request, (_destinationData get "parameters")] call (_destinationData get "code" call CBA_fnc_convertStringCode);

// handle return
switch (true) do {

    // return is Nil
    case (isNil "_return"):  {
        ZRN_LOG_MSG_1(Failed: No Return,_request);
    };

    // Valid return
    case (_return isEqualTypeArray [0,0,0]): {
        _request set ["destination", _return];
        [_request] call FUNC(request_client);
    };

    // return is string: handle as gvar name and wait for it to become expected return
    case (_return isEqualType ""): {
        // Run CBA WUAE
        [
            {   // wait until
                params ["_varName"];
                !isNil _varName
            },
            {   // and execute
                params ["_varName", "_request"];
                private _return = + (missionNamespace getVariable _varName);
                // Check if Return is valid or fail
                switch (true) do {
                    case (_return isEqualTypeArray [0,0,0]): {
                        _request set ["destination", _return];

                        [_request] call FUNC(request_client);
                    };
                    case (_return isEqualTo false): {
                        ZRN_LOG_MSG_2(FAILED: aborted,_return,_request);
                    };
                    default {
                        ZRN_LOG_MSG_1(WUAE Invalid Return,_return);
                    };
                };
                missionNamespace setVariable [_varName, nil]; // Cleanup
            },
            [_return, _request],
            180,
            {
                params ["_varName"];
                ZRN_LOG_MSG_1(WUAE Timeout,_varName);
            }
        ] call CBA_fnc_waitUntilAndExecute;
    };

    // Invalid Return
    default {
        ZRN_LOG_MSG_2(FAILED: invalid return,_return,_request);
    };
};

nil
