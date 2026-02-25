#include "..\script_component.hpp"


/*
* Author: Zorn
* checks for or creates layerhashmap and establishes global Variable
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call MUM_fnc_sth
*
* Public: Yes
*/
diag_log "[MUM](debug)(fn_init_layer) init";

params [ "_obj", "_layerName", "_distance", "_time"];



private _gMap = missionNamespace getVariable [QGVAR(HM), "404"];

if (_gMap isEqualTo "404") then { _gMap = createHashMap; };

if (_layerName in _gMap) exitWith { diag_log format ['[MUM](debug)(fn_init_layer) EXIT - _layerName: %1 already in _gMap: %2',_layerName, _gMap]; };

private _varName = ["MUM", "ula","remaining", _layerName] joinString "_";

private _objects = getMissionLayerEntities _layerName select 0;

private _algorithm = {
    getPosASL _x params [ "_xPos","_yPos",["_zPos", 0]];
    private _score = 0;
    _score = _score + ceil _zPos * 100000;
    _score = _score + ceil _yPos * 1;
    _score
};

// Sorts objects based of their ASL, from lowest to highest
_objects = [_objects, [], _algorithm, "ASCEND"] call BIS_fnc_sortBy;


{
    _x hideObjectGlobal true;
    _x setVariable [QGVAR(simEnabled), simulationEnabled _x];
    _x enableSimulationGlobal false;

    _x setVariable [QGVAR(inflamed), inflamed _x];
    _x inflame false;

} forEach _objects;

missionNamespace setVariable [_varName, count _objects, true];

// create Hashmap with all the information about
private _layerMap = createHashMapFromArray [
    ["layername", _layerName],
    ["visibleObjects", []],
    ["hiddenObjects", _objects],
    ["pubVarName", _varName],
    ["medianPosASL", [_objects] call EFUNC(common,getMedianPosASL)]
];


_gMap set [_layerName, _layerMap];

missionNamespace setVariable [QGVAR(HM), _gMap, true];

diag_log "[MUM](debug)(fn_init_layer) Done";
true

