#include "../../script_component.hpp"

/*
* Author: Zorn
* Client destination handler: opens map for player to click destination.
* Adds MapSingleClick event handler, returns variable name for server to wait on.
*
* Arguments:
* 0: _request - Request hashmap (not directly used). <HASHMAP>
* 1: _parameters - Destination parameters hashmap (not directly used). <HASHMAP>
*
* Return Value:
* String - Variable name to wait for position, or false on cancel <STRING or BOOL>
*
* Example:
* [requestHashMap, parametersHashMap] call mum_csc_fnc_base_mapClick
*
* Public: No
*/

params ["_request", "_parameters"];




#define MSG_designate ["<t color='#0000ff' size='1'>supplyDrop<br/>Left Click to designate dropzone<br/>Alt + Left Click to abort</t>", -1, 0, 60, 1] spawn BIS_fnc_dynamicText
#define MSG_success   ["<t color='#00ff00' size='1'>supplyDrop<br/>successful</t>", -1, 0, 5, 1] spawn BIS_fnc_dynamicText
#define MSG_aborted   ["<t color='#ff0000' size='1'>supplyDrop<br/>aborted</t>", -1, 0, 5, 1] spawn BIS_fnc_dynamicText


// Opens the Map next frame (in case zeus was open).
[{ openMap [true, true]; MSG_designate; }] call CBA_fnc_execNextFrame;


// adds Eventhandler to recieve Mouse Click Input
private _id_mapClick = addMissionEventHandler [
    "MapSingleClick",
    {
        params ["_units", "_pos", "_alt", "_shift"];
        missionNamespace setVariable [QGVAR(mapClicked), true];

        if (_alt) exitWith { MSG_aborted; missionNamespace setVariable [QGVAR(waitForMapclick), false]; };

        ZRN_LOG_MSG_1(Position Defined,_pos);
        missionNamespace setVariable [QGVAR(waitForMapclick), _pos];

        MSG_success;
    }
];

// Handles Timeout and Cleanup
[
    {
        missionNamespace getVariable [QGVAR(mapClicked), false]
    },
    {
        params ["_id_mapClick"];

        openMap [false, false];
        removeMissionEventHandler ["MapSingleClick", _id_mapClick];
        missionNamespace setVariable [QGVAR(mapClicked), nil];
    },
    [_id_mapClick],
    CHOOSE_DESTINATION_TIMEOUT,
    {
        // timed out
        params ["_id_mapClick"];

        openMap [false, false];
        removeMissionEventHandler ["MapSingleClick", _id_mapClick];
        missionNamespace setVariable [QGVAR(mapClicked), nil];
        missionNamespace setVariable [QGVAR(waitForMapclick), false];

        MSG_aborted
    }
] call CBA_fnc_waitUntilAndExecute;

// return varname as string
QGVAR(waitForMapclick)


