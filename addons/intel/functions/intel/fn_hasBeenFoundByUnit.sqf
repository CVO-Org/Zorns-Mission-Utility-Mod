#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to check if an intel has been found already by the player
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

params [ ["_unit", objNull, [objNull] ], ["_id", "", [""] ] ];

if ( isNull _unit || { _id isEqualTo "" } ) exitWith { false };

private _intelData = missionNamespace getVariable _id;
_intelData getVariable "found"
