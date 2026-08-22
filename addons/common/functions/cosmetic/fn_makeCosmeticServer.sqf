#include "../../script_component.hpp"

/*
* Author: Zorn
* Function which makes the provided object fully static. no actions, no scrollwheel, no nothin'
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [this] call mum_common_fnc_makeCosmetic;
*
* Public: No
*/

#define INITIAL_DELAY 1

if (!isServer) exitWith {};


params [ ["_obj", objNull, [objNull] ] ];

if (isNull _obj) exitWith {};

private _instant = false;

private _effects = switch (true) do {

    case (obj isKindOf "WeaponHolder"): {
        [ "DESTROY",                   "LOCK_INVENTORY", "DISABLE_SIM", "ACE_CLAIM", "REM_ACTIONS" ]
    };
    case (_obj isKindOf "AllVehicles"): {
        _instant = true;
        [              "LOCK_VEHICLE", "LOCK_INVENTORY", "DISABLE_SIM", "ACE_CLAIM", "REM_ACTIONS" ]
    };
    default {
        [                              "LOCK_INVENTORY", "DISABLE_SIM", "ACE_CLAIM", "REM_ACTIONS" ]
    };
};




// If execution is needed instantly, just do it.
if (_instant) exitWith { [QGVAR(EH_makeCosmeticApply), [_obj, _effects]] call CBA_fnc_globalEventJIP; };

if (isNil QGVAR(cosmeticQueue)) then {
    GVAR(cosmeticQueue) = [];

    // Start the Queue handling
    [
        {
            private _queue = GVAR(cosmeticQueue);

            private _rec = {
                params ["_rec", "_queue"];

                // execute code on individual item
                (_queue deleteAt 0) params ["_obj", "_effects"];
                [QGVAR(EH_makeCosmeticApply), [_obj, _effects]] call CBA_fnc_globalEventJIP;

                // once queue is empty, nil GVAR
                if (_queue isEqualTo []) exitWith { GVAR(cosmeticQueue) = nil; };

                // if not empty, continue next frame
                [_rec, _this] call CBA_fnc_execNextFrame;
            };

            [_rec, _queue] call _rec;
        },
        nil,
        INITIAL_DELAY
    ] call CBA_fnc_waitAndExecute;
};

GVAR(cosmeticQueue) pushBack [_obj, _effects];
