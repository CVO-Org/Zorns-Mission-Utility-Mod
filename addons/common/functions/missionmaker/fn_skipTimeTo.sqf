#include "..\..\script_component.hpp"

/*
    Author: Zorn

    Skips the mission time to a specified hour and minute.
    Optionally prevents time reversal (skipping backwards in time).

    Arguments:
        0: NUMBER or ARRAY - Desired time to skip to.
            - NUMBER: Hour in decimal format (e.g., 13.5 for 13:30).
            - ARRAY: [hours, minutes] (e.g., [13, 30] for 13:30).
        1: BOOLEAN (Optional) - If true, prevents time reversal. Default: false.

    Return Value:
        None

    Example:
        [13.5] call mum_common_fnc_skipTimeTo;                // Skips to 13:30
        [[13, 30], true] call mum_common_fnc_skipTimeTo;      // Skips to 13:30, never backwards

    Public: No
*/

params [
    ["_desired", 0, [0, []], [1,2]],
    ["_noTimeReverse", false, [false]]
];

private _targetDayTime = switch (typeName _desired) do {
    case "NUMBER": { _desired };
    case "ARRAY": {
        _desired params [["_hours", 0], ["_minutes", 0]];
        _hours + _minutes/60
    };
    default { nil };
};

if (isNil "_targetDayTime") exitWith {};

private _currentDayTime = dayTime;


private _timeToSkip = switch (true) do {
    case ( _targetDayTime > _currentDayTime ):                   {  _targetDayTime  - _currentDayTime        };
    case ( _targetDayTime < _currentDayTime && _noTimeReverse ): {  _targetDayTime  + (24 - _currentDayTime) };
    case ( _targetDayTime < _currentDayTime ):                   { (_currentDayTime - _targetDayTime) * -1   };
    default { 0 };
};

skipTime _timeToSkip;
