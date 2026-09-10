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

if (_unit isEqualTo leader _unit) exitWith {};

private _grp = group _unit;

private _assignedTeam = assignedTeam _unit;

private _teamLeaders = _grp getVariable [QGVAR(TeamLeaders), createHashMap];

diag_log text format ['[CVO](debug)(fn_TeamLeaderStepUp) _teamLeaders: %1', _teamLeaders];

private _currentTeamLeader = _teamLeaders getOrDefault [_assignedTeam, objNull];

diag_log text format ['[CVO](debug)(fn_TeamLeaderStepUp) _currentTeamLeader: %1', _currentTeamLeader];

// Demote Current Teamleader
if !(isNull _currentTeamLeader) then { _currentTeamLeader call FUNC(teamLeaderStepDown); };

// Elevate _unit to Teamleader
_teamLeaders set [_assignedTeam, _unit];
_grp setVariable [QGVAR(TeamLeaders), _teamLeaders, true];
[QGVAR(EH_setUnitIcon), [_unit, "TL"]] call CBA_fnc_serverEvent;
_unit setVariable [QGVAR(isTeamleader), true, true];

// Display message
if ( _unit isEqualTo ACE_player ) then {
    private _message = format [LLSTRING(TL_steppedUp), localize format ["str_team_%1", _assignedTeam] ];
    [_message] call ace_common_fnc_displayTextStructured;
};


nil
