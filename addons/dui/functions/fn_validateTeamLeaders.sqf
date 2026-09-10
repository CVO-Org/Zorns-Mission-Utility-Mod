#include "..\script_component.hpp"

/*
* Author: Zorn
* Function to validate the Teamleaders of a group.
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

params [ ["_grp", grpNull, [grpNull] ] ];

if (isNull _grp) exitWith {};

private _units = units _grp;
private _map = _grp getVariable QGVAR(TeamLeaders);
private _array = _units select { _x getVariable [QGVAR(isTeamLeader), false] } apply { [assignedTeam _x, _x] };

// Remove validated Teamleaders from the array
{
    // If expected TL not present, remove from TL Data - If present -> Validated -> Remove from array
    private _index = _array find [_x, _y];
    if (_index isEqualTo -1) then { _map deleteAt _x; } else { _array deleteAt _index; };
} forEach _map;

// Step Down not validated Teamleaders
{ _x#1 call FUNC(TeamLeaderStepDown); } forEach _array;
