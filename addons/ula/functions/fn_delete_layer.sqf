#include "../script_component.hpp"

/*
* Author: Zorn
* [Description]
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call MUM_ula_fnc_delete_layer;
*
* Public: Yes
*/

if !(isServer) exitWith {};

params [
    ["_revealLayer", "404", [""]  ]
];

if (_revealLayer isEqualTo "404") exitWith {};

private _hashMap = missionNamespace getVariable [QGVAR(HM_Delete), "404"];
if (_hashMap isEqualTo "404") exitWith {};

private _deleteLayer = _hashMap getOrDefault [_revealLayer, "404"];
if (_deleteLayer isEqualTo "404") exitWith {};

private _objects = getMissionLayerEntities _deleteLayer select 0;
ZRN_LOG_2(_deleteLayer,count _objects);
{ deleteVehicle _x } forEach _objects;

// Add cleanup: delete Entry from HMO

_hashMap deleteAt _revealLayer;

// Delete HMO when empty

if (count _hashMap > 0) exitWith {};

missionNamespace getVariable [QGVAR(HM_Delete), nil];
[QGVAR(EH_completed), GVAR(EHID_deleteLayer)] call CBA_fnc_removeEventHandler;
