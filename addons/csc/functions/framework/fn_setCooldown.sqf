#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Server Function to handle cooldown of deliveries.
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

params [ "_deliveryClassName", "_duration"];

private _startPFH = false;
private _map = if (isNil QGVAR(cooldowns)) then { _startPFH = true; createHashMap } else { GVAR(cooldowns) };

private _endTime = CBA_missionTime + _duration;
_map set [_deliveryClassName, _endTime];

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
