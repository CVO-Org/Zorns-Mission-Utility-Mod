#include "../../script_component.hpp"

/*
* Author: Zorn
* DESTINATION - Function to return a position based of the players mapclick in put.
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

params ["_request", "_parameters"];

#define MSG_designate ["<t color='#0000ff' size='1'>supplyDrop<br/>Left Click to designate dropzone<br/>Alt + Left Click to abort</t>", -1, 0, 60, 1] spawn BIS_fnc_dynamicText
#define MSG_success   ["<t color='#00ff00' size='1'>supplyDrop<br/>successful</t>", -1, 0, 5, 1] spawn BIS_fnc_dynamicText
#define MSG_aborted   ["<t color='#ff0000' size='1'>supplyDrop<br/>aborted</t>", -1, 0, 5, 1] spawn BIS_fnc_dynamicText


// Closes Zeus Interface and Opens the Map the frame after.
if ( !isNull (findDisplay 312) ) then {
    findDisplay 312 closeDisplay 2;
    missionNamespace setVariable [QGVAR(mapClick_curatorWasOpen), true];
};
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
        if (missionNamespace getVariable [QGVAR(curatorWasOpen), false]) then {openCuratorInterface};

    },
    [_id_mapClick],
    60,
    {
        // timed out
        params ["_id_mapClick"];

        openMap [false, false];
        removeMissionEventHandler ["MapSingleClick", _id_mapClick];
        missionNamespace setVariable [QGVAR(mapClicked), nil];
        missionNamespace setVariable [QGVAR(waitForMapclick), false];

        if (missionNamespace getVariable [QGVAR(curatorWasOpen), false]) then {openCuratorInterface};
        
        MSG_aborted
    }
] call CBA_fnc_waitUntilAndExecute;

// return varname as string
QGVAR(waitForMapclick)  
 
