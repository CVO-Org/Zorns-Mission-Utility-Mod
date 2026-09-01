#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Sets cooldown timer for a delivery mode on server.
* Stores expiration time, starts cleanup PFH if first cooldown, removes expired cooldowns.
*
* Arguments:
* 0: _deliveryClassName - Delivery mode classname/ID <STRING>
* 1: _duration - Cooldown duration in seconds <NUMBER>
*
* Return Value:
* nil
*
* Example:
* ["airdrop_heli", 900] call mum_csc_fnc_setCooldown
*
* Public: No
*/

params [ "_deliveryClassName", "_duration"];

private _startPFH = false;
private _map = if (isNil QGVAR(cooldowns)) then { _startPFH = true; createHashMap } else { GVAR(cooldowns) };

_map set [_deliveryClassName, CBA_missionTime + _duration];

missionNamespace setVariable [QGVAR(cooldowns), _map, true];

// Start PFH to clear coolsdowns once done.
if (_startPFH) then {
    [
        {
            private _now = CBA_missionTime;
            private _map = GVAR(cooldowns);
            private _update = false;
            { if (_y < _now) then { _map deleteAt _x; _update = true }; } forEach _map;

            if (_update) then {
                if (_map isEqualTo createHashMap) exitWith {
                    missionNamespace setVariable [QGVAR(cooldowns), nil, true];
                    _this#1 call CBA_fnc_removePerFrameHandler;
                };
                missionNamespace setVariable [QGVAR(cooldowns), _map, true];
            };
        },
        1
    ] call CBA_fnc_addPerFrameHandler;
};

nil
