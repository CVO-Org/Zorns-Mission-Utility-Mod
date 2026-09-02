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

        // Closes Zeus Interface and Stores that state
        if ( !isNull (findDisplay 312) ) then {
            findDisplay 312 closeDisplay 2;
            missionNamespace setVariable [QGVAR(curatorWasOpen), true];
        };


        // Run CBA WUAE
        [
            {   // wait until
                params ["_varName"];
                !isNil _varName
            },
            {   // and execute
                params ["_varName", "_request"];

                diag_log text format ['[CVO](debug)(fn_handle_destination) Return Detected: _varName: %1 - _request: %2', _varName , _request];

                private _return = + (missionNamespace getVariable _varName);
                diag_log text format ['[CVO](debug)(fn_handle_destination) _return: %1', _return];
                systemChat format ['[CVO](debug)(fn_handle_destination) _return: %1', _return];

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

                // Re-Open Curator when needed
                if (missionNamespace getVariable [QGVAR(curatorWasOpen), false]) then { GVAR(curatorWasOpen) = nil; openCuratorInterface};
            },
            [_return, _request],
            CHOOSE_DESTINATION_TIMEOUT + 1,
            {
                params ["_varName", "_request"];
                ZRN_LOG_MSG_1(WUAE Timeout,_varName);

                // Re-Open Curator when needed
                if (missionNamespace getVariable [QGVAR(curatorWasOpen), false]) then { GVAR(curatorWasOpen) = nil; openCuratorInterface};
            }
        ] call CBA_fnc_waitUntilAndExecute;
    };

    // Invalid Return
    default {
        ZRN_LOG_MSG_2(FAILED: invalid return,_return,_request);
    };
};

nil
