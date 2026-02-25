#include "../../script_component.hpp"

/*
* Author: Zorn
* This function will be executed on the client and will resolve the destination and return a position. This position will then be taken as a reference point on the server to "deliver" the crates.
* This runs on the clients so player input like like "mapclick" or "input grids" can be handled by the requester.
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

params ["_request"];

private _cfg = [QGVAR(destinations), _request get "destination", configNull] call EFUNC(catalog,getEntry);

ZRN_LOG_1(_cfg);

private _codeString = getText (_cfg >> "code");

ZRN_LOG_1(_codeString);

private _code = _codeString call CBA_fnc_convertStringCode;

private _return = [_request, (_cfg >> "parameters") call cba_fnc_getCfgDataHashmap] call _code;

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
