#include "..\script_component.hpp"


params ["_objSource", "_player", "_actionParams"];
_actionParams params ["_layerName", "_distance", "_time"];

_gMap = missionNamespace getVariable [QGVAR(HM), "404"];
if (_gMap isEqualTo "404") exitWith {false};

private _lMap = _gMap getOrDefault [_layerName, "404"];
if (_lMap isEqualTo "404") exitWith {false};

private _cond1 = missionNamespace getVariable [["mum", "ula","remaining", _layerName] joinString "_", 0] > 0;
private _cond2 = ( (getPosASL _objSource) distance2D (_lMap get "medianPosASL") ) <= _distance;

// Return
_cond1 && _cond2
