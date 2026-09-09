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

// Remove from Group Array
private _grp = group _unit;
private _teamLeaders = _grp getVariable [QGVAR(TeamLeaders), []];
_teamLeaders = _teamLeaders - [_unit];
_grp setVariable [QGVAR(TeamLeaders), _teamLeaders, true];

// Handle Icon
[QGVAR(EH_setUnitIcon), [_unit, "NIL"]] call CBA_fnc_serverEvent;
_unit setVariable [QGVAR(isTeamleader), false, true];

nil
