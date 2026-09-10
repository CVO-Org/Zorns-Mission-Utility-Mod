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
private _teamLeaders = _grp getVariable [QGVAR(TeamLeaders), createHashMap]; // Hashmap

private _assignedTeam = assignedTeam _unit;

if (_teamLeaders get _assignedTeam isEqualTo _unit) then {
    _teamLeaders deleteAt _assignedTeam;
} else {
    toArray _teamLeaders params ["_keys", "_values"];
    private _index = _values find _unit;
    if (_index isNotEqualTo -1) then { _teamLeaders deleteAt (_keys select _index); };
};

_grp setVariable [QGVAR(TeamLeaders), _teamLeaders, true];

// Handle Icon
[QGVAR(EH_setUnitIcon), [_unit, "NIL"]] call CBA_fnc_serverEvent;
_unit setVariable [QGVAR(isTeamleader), false, true];

// Display message
if ( _unit isEqualTo ACE_player ) then {
    private _message = format [LLSTRING(TL_steppedDown), localize format ["str_team_%1", _assignedTeam] ];
    [_message] call ace_common_fnc_displayTextStructured;
};

nil
