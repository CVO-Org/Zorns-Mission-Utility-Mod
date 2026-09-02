#include "..\script_component.hpp"

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
* ['something', player] call MUM_fnc_sth
*
* Public: Yes
*/

if (!isServer) exitWith {};

params [
    ["_layerName",      "",         [""]        ],
    ["_objSource",      objNull,    [objNull]   ]
];




if (isNil QGVAR(HM)) exitWith {ZRN_LOG_MSG(Failed: GVAR(HM) not defined);};

private _layerMap = GVAR(HM) getOrDefault [_layerName, "404"];


if (_layerMap isEqualTo "404") exitWith {
    ZRN_LOG_MSG(Failed: _layerMap == 404);
};

private _playSound = _objSource getVariable [QGVAR(playSound), false];

private _hiddenObjects = _layerMap get "hiddenObjects";
private _visibleObjects = _layerMap get "visibleObjects";

private _obj = _hiddenObjects deleteAt 0;

_obj hideObjectGlobal false;
_obj enableSimulationGlobal (_obj getVariable [QGVAR(simEnabled), false]);
_obj inflame (_obj getVariable [QGVAR(inflamed), false]);


_visibleObjects pushBack _obj;
private _count = count _hiddenObjects;

if (_playSound) then { [QGVAR(EH_playSound), [_obj, "PLACE"]] call CBA_fnc_globalEvent; };


missionNamespace setVariable [_layerMap get "pubVarName", _count, true];



if (_count > 0 ) exitWith {};

if (_playSound) then { [QGVAR(EH_playSound), [_objSource, "BREAK"]] call CBA_fnc_globalEvent; };

deleteVehicle _objSource;

GVAR(HM) deleteAt _layerName;


if (count GVAR(HM) > 0) exitWith {};
GVAR(HM) = nil;

if (_playSound) then { [QGVAR(EH_playSound), GVAR(EHID_playSound)] call CBA_fnc_removeEventHandler; };
[QGVAR(EH_revealObject), GVAR(EHID_revealObject)] call CBA_fnc_removeEventHandler;
[QGVAR(EH_addAction), GVAR(EHID_addAction)] call CBA_fnc_removeEventHandler;

missionNamespace setVariable [QGVAR(EHID_playSound), nil, true];
missionNamespace setVariable [QGVAR(EHID_revealObject), nil, true];
missionNamespace setVariable [QGVAR(EHID_addAction), nil, true];

[QGVAR(EH_completed), [_layerName]] call CBA_fnc_serverEvent;
