#include "../../script_component.hpp"

/*
* Author: Zorn
* Funciton that handles everything needed on the client side when a piece of intel has been found.
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

params [ "_id", "_finder"];

// Get Intel Data
private _intelData = missionNamespace getVariable _id;
private _intelTitle = _intelData getVariable "intelTitle";

_intelData setVariable ["found", true, false]; // Caches 

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
