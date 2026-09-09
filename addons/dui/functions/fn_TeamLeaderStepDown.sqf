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


[QGVAR(EH_setUnitIcon), [_unit, "NIL"]] call CBA_fnc_serverEvent;
_unit setVariable [QGVAR(isTeamleader), false, true];

nil
