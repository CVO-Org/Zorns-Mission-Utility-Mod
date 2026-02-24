#include "../../script_component.hpp"

/*
* Author: Zorn
* Function which will check missionConfigFile to initialize CVO Arsenal Interaction Points
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


if (!isServer) exitWith {};


private _layerName = getText (missionConfigFile >> QGVAR(kits) >> "editor_layer_name");

private _objects =  getArray (missionConfigFile >> QGVAR(kits) >> "object_variable_names") apply { missionNamespace getVariable [_x, objNull] };

if (_layerName isNotEqualTo "") then { _objects append flatten (getMissionLayerEntities _layerName # 0); };

_objects = flatten _objects select { !isNull _x };

[QGVAR(EH_initBox), _objects, QGVAR(EH_initBox)] call CBA_fnc_globalEventJIP;

nil
