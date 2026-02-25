#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to secure a Vehicle and its crew for/against players. Locks Pilot and Gunner Seats.
* To be Executed where the vehicle is local.
*
* Arguments:
*
* Return Value:
* See Params
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
    [ "_vic",           objNull,    [objNull] ],
    [ "_disableDamage", true,       [true]    ],
    [ "_lockDriver",    true,       [true]    ],
    [ "_lockTurrets",   true,       [true]    ],
    [ "_claimCrew",     true,       [true]    ]
];

if (!local _vic) exitWith {};

private _crew = crew _vic;

if (_disableDamage) then { { _x allowDamage false } forEach (units _crew + [_vic]);  };
if (_lockDriver)    then { _vic lockDriver true; };
if (_lockTurrets)   then { { _vic lockTurret [_x, true] } forEach allTurrets [_vic, false]; };
if (_claimCrew)     then { { [_x, _x] call ace_common_fnc_claim; } forEach _crew; };
