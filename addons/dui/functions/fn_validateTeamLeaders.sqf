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

private _teamLeadersMap = _grp getVariable QGVAR(TeamLeaders);
_teamLeadersMap toArray params ["_keys", "_values"];

private _units = units _grp;
private _teamLeadersArray = _units select { _x getVariable [QGVAR(isTeamLeader), false] };

// Validate _teamLeadersArray
{
    if (_x in _values) then { continue };
    _x call FUNC(TeamLeaderStepDown);
    _teamLeadersArray set [_forEachIndex, objNull];
} forEach _teamLeadersArray;

// Validate _teamLeadersMap
{
    if (_y in _units) then { continue };
    _teamLeadersMap deleteAt _x;
} forEach _teamLeadersMap;

// ToDo - Actually test this
