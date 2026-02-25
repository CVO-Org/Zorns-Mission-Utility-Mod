#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Handle JIP Clients
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

params ["", "_didJIP"];

if (_didJIP) then {

    private _cat = missionNamespace getVariable QGVAR(catalog);
    if (isNil "_cat") exitWith {};

    private _hasAnyIntel = false;

    {
        private _id = _x;
        private _namespace = _y;

        private _hasIntel = switch (true) do {
            case (_namespace getVariable "foundByAll"): { true };
            case ( side player in (_namespace getVariable "foundBySide") ): { true };
            case ( group player in (_namespace getVariable "foundByGroup") ): { true };
            case ( player in (_namespace getVariable "foundByUnit") ): { true };
            default { false };
        };

        if (_hasIntel) then {
            _hasAnyIntel = true;

            // Write Intel Diary Entry
            [_id] call FUNC(writeIntelDiary);            
            
            //Remove Intel Action
            _namespace getVariable "object" call FUNC(removeintelAction);
        };

    } forEach _cat;

    if (_hasAnyIntel) then { [] call FUNC(updateSummary); };

};
