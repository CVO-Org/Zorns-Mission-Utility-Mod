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

diag_log text format ['[CVO](debug)(fn_validateTeamLeaders) All Teamleaders: %1', _array];

// Remove validated Teamleaders from the array
{
    diag_log text format ['[CVO](debug)(fn_validateTeamLeaders) Validate: %1 - %2', _x , _y];
    private _index = _array find [_x, _y];
    diag_log text format ['[CVO](debug)(fn_validateTeamLeaders) _index: %1', _index];

    // If expected TL not present, remove from TL Data - If present -> Validated -> Remove from array
    if (_index isEqualTo -1) then { _map deleteAt _x; } else { _array deleteAt _index; };

} forEach _map;

diag_log text format ['[CVO](debug)(fn_validateTeamLeaders) Not Validated TLs: %1', _array];

// Step Down not validated Teamleaders
{ _x#1 call FUNC(TeamLeaderStepDown); } forEach _array;
