#include "../../script_component.hpp"

/*
* Author: Zorn
* Checks if an intel item has been shared with the given unit - either globally, with its side, with its group or with the unit directly.
* Based on the public foundBy* data of the intel, so it gives the same result on every machine.
*
* Arguments:
* 0: Unit <OBJECT>
* 1: Intel ID <STRING>
*
* Return Value:
* Has the unit access to the intel? <BOOL>
*
* Example:
* [player, "mum_intel_0"] call mum_intel_fnc_hasBeenFoundByUnit
*
* Public: No
*/

params [ ["_unit", objNull, [objNull] ], ["_id", "", [""] ] ];

if ( isNull _unit || { _id isEqualTo "" } ) exitWith { false };

private _intelData = missionNamespace getVariable [_id, objNull];
if (isNull _intelData) exitWith { false };

_intelData getVariable ["foundByAll", false]
|| { side group _unit in (_intelData getVariable ["foundBySide", []]) }
|| { group _unit in (_intelData getVariable ["foundByGroup", []]) }
|| { _unit in (_intelData getVariable ["foundByUnit", []]) }
