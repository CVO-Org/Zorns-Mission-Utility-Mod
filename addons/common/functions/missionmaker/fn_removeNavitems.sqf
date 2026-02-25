/*
* Author: Zorn
* Function to remove Navigational Items (and radio) from units.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
*   [
*       allUnits - allPlayers,      // unit(s)
*       true,                       // remove Map
*       true,                       // Remove GPS
*       false,                      // Remove Compass
*       false,                      // Remove Radio
*       false                       // Remove Watch
*   ] call mum_common_fnc_removeNavItems;
*
* Public: No
*/

params [
    ["_units",   [],    [objNull,[]] ],
    ["_map",     true,  [true]       ],
    ["_gps",     true,  [true]       ],
    ["_compass", true,  [true]       ],
    ["_radio",   false, [true]       ],
    ["_watch",   false, [true]       ]
];


if ( _units isEqualType objNull ) then { _units = [ _units ] };

private _unit = _units deleteAt 0;

if (isNull _unit) exitWith {};

_unit setUnitLoadout [
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    [
        [ nil, "" ] select _map,
        [ nil, "" ] select _gps,
        [ nil, "" ] select _radio,
        [ nil, "" ] select _compass,
        [ nil, "" ] select _watch,
        nil // NVG
    ]
];

if (_units isNotEqualTo []) then {
    _statement = {};
    _parameters = [];
    [zrn_fnc_removeNavItems, _this, 5] call cba_fnc_execAfterNFrames;
};


/*
// EXAMLPE HOW TO USE
// RUN postInit
// RUN Once on Mission Start to remove Items from existing Units
[{
    diag_log "[CVO](debug)(fn_init) inital remove";
    [
        allUnits - allPlayers,      // unit(s)
        true,                       // remove Map
        true,                       // Remove GPS
        false,                      // Remove Compass
        false,                      // Remove Radio
        false                       // Remove Watch
    ] call mum_common_fnc_removeNavItems;

} , [], 1] call CBA_fnc_waitAndExecute;

// ADD EH for all units created during the mission
addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    if (_entity isKindOf "CAManBase") then {
        [
            {
                [
                    _this,      // unit(s)
                    true,       // remove Map
                    true,       // Remove GPS
                    false,      // Remove Compass
                    false,      // Remove Radio
                    false       // Remove Watch
                ] call mum_common_fnc_removeNavItems;
            },
            _entity,
            1
        ] call CBA_fnc_waitAndExecute;
    };
}];
*/
