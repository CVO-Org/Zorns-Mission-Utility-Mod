#include "../../script_component.hpp"

/*
* Author: Zorn
* Function for the Statement of the Intel Pickup Action
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

#define MAX_DISTANCE 3
#define MIN_SOUND_DELAY 1
#define MID_SOUND_DELAY 2
#define MAX_SOUND_DELAY 4


params ["_object", "_player", "_args"];
_args params ["_id", "_actionTitle", "_actionSound", "_actionDuration"];

// Prep Sound
private _actionSounds = switch (toUpper _actionSound) do {
    case "BODY": { ["OMIntelGrabBody_01", "OMIntelGrabBody_02", "OMIntelGrabBody_03"] };
    case "KEYBOARD": { ["OMIntelGrabPC_01", "OMIntelGrabPC_02", "OMIntelGrabPC_03", "OMIntelGrabLaptop_01", "OMIntelGrabLaptop_02", "OMIntelGrabLaptop_03"] };
    default { [] };
};

if (_actionSounds isNotEqualTo []) then { _object setVariable [QGVAR(nextTimeForSound), CBA_missionTime]; };


// ACE Progress Bar
[
    // * 0: Total Time (in game "time" seconds) <NUMBER>
    _actionDuration,

    // * 1: Arguments, passed to condition, fail and finish <ARRAY>
    [_object, _player, _id, _actionSounds],

    // * 2: On Finish: Code called or STRING raised as event. <CODE, STRING>
    {
        params ["_args", "", "", ""];
        _args params ["_object", "_player", "_id"];

        diag_log format ['[MUM](debug)(fn_action_statement) _args: %1', _args];

        // Tell Server its been found
        [QGVAR(EH_intelFound), [_id, _player]] call CBA_fnc_serverEvent;

        // Handle SoundFXs
        _object setVariable [QGVAR(nextTimeForSound), nil];
    },

    // * 3: On Failure: Code called or STRING raised as event. <CODE, STRING>
    {
        params ["_args", "", "", ""];
        _args params ["_object"];
        _object setVariable [QGVAR(nextTimeForSound), nil];
    },

    // * 4: Localized Title <STRING> (default: "")
    _actionTitle,

    // * 5: Code to check each frame <CODE> (default: {true})
    {
        params ["_args", "", "", ""];
        _args params ["_object", "_player", "_id", "_actionSounds"];

        if (
            !(lifeState _player in ["HEALTHY", "INJURED"])
            ||
            {
                isNull _object
                ||
                {
                    [_player, _id] call FUNC(hasBeenFoundByUnit)
                }
            }
        ) exitWith { false };

        private _time = CBA_missionTime;
        private _nextTimeForSound = _object getVariable [QGVAR(nextTimeForSound), _time];

        if (_time > _nextTimeForSound) then {

            [_object, selectRandom _actionSounds, 25, true, true, 0.15] call CBA_fnc_globalSay3D;

            private _nextDelay = random [MIN_SOUND_DELAY, MID_SOUND_DELAY, MAX_SOUND_DELAY];
            _object setVariable [QGVAR(nextTimeForSound), _time + _nextDelay];
        };

        // return: Can Continue Progressbar?
        true
    }
] call ace_common_fnc_progressBar;
