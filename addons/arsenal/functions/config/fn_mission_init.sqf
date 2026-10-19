#include "../../script_component.hpp"

/*
* Author: Zorn
* Server postInit. Reads editor_layer_name and object_variable_names from the mission's mum_arsenal_kits
* and turns those objects into MUM Arsenals via the JIP event mum_arsenal_EH_initBox.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call mum_arsenal_fnc_mission_init
*
* Public: No
*/


if (!isServer) exitWith {};


private _layerName = getText (missionConfigFile >> QGVAR(kits) >> "editor_layer_name");

private _objects =  getArray (missionConfigFile >> QGVAR(kits) >> "object_variable_names") apply { missionNamespace getVariable [_x, objNull] };

if (_layerName isNotEqualTo "") then { _objects append flatten (getMissionLayerEntities _layerName select 0); };

_objects = flatten _objects select { !isNull _x };

[QGVAR(EH_initBox), _objects, QGVAR(EH_initBox)] call CBA_fnc_globalEventJIP;

nil
