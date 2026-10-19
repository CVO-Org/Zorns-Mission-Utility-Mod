#include "../../script_component.hpp"

/*
* Author: Zorn
* Client function to handle a piece of intel that has been shared with the local player:
* notification, diary entry, removal of the action and update of the intel summary.
*
* Arguments:
* 0: Intel ID <STRING>
* 1: Finder <OBJECT>
*
* Return Value:
* None
*
* Example:
* [QGVAR(EH_publishIntel), ["mum_intel_0", _finder], _targets] call CBA_fnc_targetEvent
*
* Public: No
*/

params [ "_id", "_finder"];

// Get Intel Data
private _intelData = missionNamespace getVariable _id;
private _intelTitle = _intelData getVariable "intelTitle";

_intelData setVariable ["found", true, false]; // Local cache, used for the summary

private _finderName = switch (true) do {
    case (_finder isEqualTo player): { LLSTRING(PlayerFoundIntel_You) };
    case (_finder in units group player): { name _finder };
    default { groupId group _finder };
};

// Notify Player
[
    ["\a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa", 1.25],
    [format [localize LSTRING(PlayerFoundIntel), _finderName, _intelTitle] ],
    false
] call CBA_fnc_notify;


// Write Intel Diary Entry
[_id] call FUNC(writeIntelDiary);

// Remove Intel Action if the object is not being deleted
private _object = _intelData getVariable "object";
if !(isNil "_object") then { _object call FUNC(removeintelAction); };

// Update Intel Summary
call FUNC(updateSummary);
