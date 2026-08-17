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

#define LOCK_INVENTORY [_this, true] remoteExec ["lockInventory", 0, true]
#define LOCK_VEHICLE _this lock true
#define DISABLE_SIM _this enableSimulationGlobal false
#define REM_ACTIONS removeAllActions _this
#define ACE_CLAIM [_this, _this] call ace_common_fnc_claim
#define DESTROY _this setDamage 1

params [
    ["_obj",        objNull,    [objNull]   ],
    ["_instant",    false,      [true]      ],
    "_code"
];

if (isNull _obj) exitWith {};
if (!isServer) exitWith {};

// Future-Proofing for fine object-type specifics, i.E. weaponholders or alike
// can be used to overwrite "_instant" when needed


if (isNil "_code") then {

    _code = switch (true) do {

        case (_obj isKindOf "AllVehicles"): {
            _instant = true;
            {
                // DESTROY;
                LOCK_VEHICLE;
                LOCK_INVENTORY;
                DISABLE_SIM;
                ACE_CLAIM;
                REM_ACTIONS;
            }
        };

        case (obj isKindOf "WeaponHolder"): {
            {
                DESTROY;
                LOCK_INVENTORY;
                DISABLE_SIM;
                ACE_CLAIM;
                REM_ACTIONS;
            }
        };


        default {
            {
                LOCK_INVENTORY;
                DESTROY;
                DISABLE_SIM;
                ACE_CLAIM;
                REM_ACTIONS;
            }
        };
    };
};

// If execution is needed instantly, just do it.
if (_instant) exitWith { _obj call _code; };

if (isNil QGVAR(cosmeticQueue)) then {
    GVAR(cosmeticQueue) = [];

    // Start the Queue handling
    [
        {
            private _queue = GVAR(cosmeticQueue);

            private _rec = {
                params ["_rec", "_queue"];

                // execute code on individual item
                (_queue deleteAt 0) params ["_obj", "_code"];
                _obj call _code;

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

GVAR(cosmeticQueue) pushBack [_obj, _code];
