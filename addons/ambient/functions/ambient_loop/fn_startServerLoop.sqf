#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to start the Serverside Framework to play random sounds in the distance but only for specified targets.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [ "ALL", 0.1, 0.1 ] call MUM_ambient_fnc_startServerLoop;
*
* Public: No
*/

if !(isServer) exitWith {};

params [
    [ "_ambients",      "ALL",  ["", []]    ],
    [ "_interval",      3,      [0]         ],
    [ "_coolDown",      10,     [0]         ],
    [ "_desiredRatio",  0.3,    [0]         ]
];

GVAR(cooldown) = _coolDown * 60;
GVAR(desiredRatio) = 0 max _desiredRatio min 1;

_ambients = switch (true) do {
    case (_ambients isEqualTo "ALL"): { "true" configClasses (configFile >> QADDON) apply { configName _x } };
    case (_ambients isEqualType "" ): { [ _ambients ] };
    default { _ambients };
};

private _soundsPool = [];
{
    private _ambient = _x;
    _soundsPool append ("true" configClasses (configFile >> QADDON >> _ambient) apply { configName _x });
} forEach _ambients;

private _interval = _interval * 60;

GVAR(sounds_main_pool) = + _soundsPool;
GVAR(sounds_curr_pool) = + _soundsPool;

if (! isNil QGVAR(loop_id) ) exitWith { GVAR(loop_id) };

GVAR(loop_id) = [
    {
        if (GVAR(sounds_curr_pool) isEqualTo []) then { GVAR(sounds_curr_pool) = + GVAR(sounds_main_pool); };

        private _players = [] call CBA_fnc_players;
        private _playersTotal = count _players;

        private _validTargets = _players select { ( (_x getVariable [QGVAR(lastPlayed), 0]) + (missionNamespace getVariable [QGVAR(cooldown), 600]) ) < CBA_missionTime };
        private _validTargetsAmount = count _validTargets;
        if (_validTargetsAmount isEqualTo 0) exitWith {};

        // Whatever is smaller, the amount of valid targets or desiredRatio%
        private _desiredTargetsAmount = ceil (_playersTotal * GVAR(desiredRatio)) min _validTargetsAmount;



        private _selectedTargets = [];
        for "_i" from 1 to _desiredTargetsAmount do { _selectedTargets pushBack ( _validTargets deleteAt (floor random count _validTargets) ); };


        private _sounds = GVAR(sounds_curr_pool);
        private _sound = _sounds deleteAt (floor random count _sounds);
        diag_log format ['[MUM](debug)(fn_startServerLoop) _sound: %1', _sound];
        diag_log format ['[MUM](debug)(fn_startServerLoop) _selectedTargets: %1', _selectedTargets];
       [QGVAR(EH_localEffects), [ _sound, 300, ceil random 360 ], _selectedTargets] call CBA_fnc_targetEvent;

    },
    _interval
] call CBA_fnc_addPerFrameHandler;

GVAR(loop_id)
