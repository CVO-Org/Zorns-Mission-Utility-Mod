#include "..\script_component.hpp"

/*
* Author: Zorn
* Function to become teamleader
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

params [ ["_unit", ACE_Player, [objNull] ] ];


private _grp = group _unit;
private _assignedTeam = assignedTeam _unit;

private _teamLeaders = _grp getVariable [QGVAR(TeamLeaders), createHashMap];
private _currentTeamLeader = _teamLeaders getOrDefault [_assignedTeam, objNull];

// Demote Current Teamleader
if !(isNull _currentTeamLeader) then { _currentTeamLeader call FUNC(stepDown); };

// Elevate _unit to Teamleader
_teamLeaders set [_assignedTeam, _unit];
_grp setVariable [QGVAR(TeamLeaders), _teamLeaders, true];
[QGVAR(EH_setUnitIcon), [_unit, "TL"]] call CBA_fnc_serverEvent;
_unit setVariable [QGVAR(isTeamleader), true, true];

nil
