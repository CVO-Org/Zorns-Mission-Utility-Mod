#include "../../script_component.hpp"

/*
* Author: Zorn
* function to quickly generate a bis_holdAction with the goal to set up a "fast travel" action.
* needs to be executed on each client that shall have the interaction.
*
* Arguments:
* 0 - <Object>   which will have the Action
* 1 - <Object>   which will define the target position and direction (invisible helipad)
* 2 - <String>   Title for the the hold action
*
* Return Value:
* None
*
* Example:
* [this, lz_range, "Go to the Firing Range"] call mum_common_fnc_holdaction_tp;
*
* Public: Yes
*/

#define DURATION 3
#define ICON "\a3\ui_f_orange\Data\CfgOrange\Missions\action_fragment_back_ca.paa"

params [
    ["_door", objNull, [objNull]],
    ["_destination", objNull, [objNull]],
    ["_text", "Fasttravel", [""]]
];

if (isNull _door       ) exitWith {ZRN_LOG_MSG_1(FAILED:,_door)};
if (isNull _destination) exitWith {ZRN_LOG_MSG_1(FAILED:,_destination)};

private _completion = {
    _this#3 params ["_destination"];

    ace_player allowDamage false;

    private _tgtPosASL = getPosASL _destination;
    private _tgtDIR = getDir _destination;

    // elevates the player 10cm above the tgt to avoid falling through the floor
    _tgtPosASL set [2, _tgtPosASL#2 + 0.1];

    ace_player setPosASL _tgtPosASL;
    ace_player setDir _tgtDIR;

    [ { [QGVAR(holdAction_TP_blackening), true, DURATION * 0.35 ] call BIS_fnc_blackIn; } , [], DURATION * 0.2 ] call CBA_fnc_waitAndExecute;
    [ { ace_player allowDamage true; } , [], 2] call CBA_fnc_waitAndExecute;

};

[
    _door,                                                          // Object the action is attached to
    _text,                                                          // Title of the action
    ICON,                                                           // Idle icon shown on screen
    ICON,                                                           // Progress icon shown on screen
    "true",                                                         // Condition for the action to be shown
    "true",                                                         // Condition for the action to progress
    { [QGVAR(holdAction_TP_blackening), true, DURATION * 0.95 ] call BIS_fnc_blackOut; },   // Code executed when action starts
    {},                                                                // Code executed on every progress tick
    _completion,                                                    // Code executed on completion
    { [QGVAR(holdAction_TP_blackening), true, DURATION * 0.3 ] call BIS_fnc_blackIn; },     // Code executed on interrupted
    [_destination],                                                    // Arguments passed to the scripts as _this select 3
    DURATION,                                                                // Action duration in seconds
    0,                                                                // Priority
    false,                                                            // Remove on completion
    false,                                                            // Show in unconscious state
    true                                                            // show on screen; if false action needs to be selected from action menu to appear on screen
] call  BIS_fnc_holdActionAdd;
