#include "../../script_component.hpp"

/*
* Author: Zorn
* PostInit function to restore all intel a JIP player has access to: diary entries, intel summary and local "found" cache.
* No notifications are shown.
*
* Arguments:
* 0: Unused
* 1: Did JIP <BOOL>
*
* Return Value:
* None
*
* Example:
* ["postInit", true] call mum_intel_fnc_handleJIP
*
* Public: No
*/

params ["", "_didJIP"];

if (!_didJIP) exitWith {};

private _cat = missionNamespace getVariable QGVAR(catalog);
if (isNil "_cat") exitWith {};

private _hasAnyIntel = false;

{
    private _id = _x;
    private _namespace = _y;

    if !([player, _id] call FUNC(hasBeenFoundByUnit)) then { continue };

    _hasAnyIntel = true;

    _namespace setVariable ["found", true, false]; // Local cache, used for the summary

    // Write Intel Diary Entry
    [_id] call FUNC(writeIntelDiary);

    //Remove Intel Action
    _namespace getVariable "object" call FUNC(removeintelAction);

} forEach _cat;

if (_hasAnyIntel) then { [] call FUNC(updateSummary); };
