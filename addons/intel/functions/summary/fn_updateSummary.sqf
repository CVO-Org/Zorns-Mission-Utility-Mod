#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to be executed locally - will update/create the Intel Summary Record
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

privateAll;

if (SET(disableIntelSummary)) exitWith {
    if (player diarySubjectExists QGVAR(intel_summary)) then { player removeDiarySubject QGVAR(intel_summary); };
};

private _groups = [] call FUNC(getGroups);
if (_groups isEqualTo []) exitWith {};

// Create Diary Subject
if !(player diarySubjectExists QGVAR(intel_summary)) then {
    player createDiarySubject [QGVAR(intel_summary), "Intel Summary", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa"];
    player createDiaryRecord [QGVAR(intel_summary), ["Intel Summary", ""], taskNull, "NONE", false];
};

// Get Summary Text
private _stringArray = ["<font face='EtelkaMonospacePro' color='#0099ff' size='14'>Intel Found:</font>"];
{
    _x params ["_groupName", "_found", "_total"];

    if (_found == 0) then { continue };

    private _text = [
        format ["<font size=10 face='EtelkaMonospacePro'>%1 / %2 - %3</font>",_found, _total, _groupName],
        format ["<font size=10 face='EtelkaMonospacePro'>%1 / %2 - %3 - Complete!</font>",_found, _total, _groupName]
    ] select (_found == _total);
    _stringArray pushBack _text;
} forEach _groups;

private _text = _stringArray joinString "<br />";

// Update Diary Entry
player setDiaryRecordText [
    [
        QGVAR(intel_summary),
        player allDiaryRecords QGVAR(intel_summary) select 0 select -1
    ],
    [
        "Intel Summary",
        _text,
        "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa"
    ]
];
