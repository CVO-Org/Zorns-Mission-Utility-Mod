#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to get the Desination's Namestring
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

params [ ["_destination", nil, [createHashMap]] ];

if (isNil "_destination") exitWith {};

private _type = _destination get "type";
private _target = _destination get "target";

// Vehicle Info
private "_vehicleInfo";
if (_type isEqualTo "VIC") then {
    private _name = getText (configOf _target >> "displayName");
    private _occSeats = count fullCrew [_target, "", false];
    private _allSeats = count fullCrew [_target, "", true];
    _vehicleInfo = format ["%1 (%2/%3)", _name, _occSeats, _allSeats];
};

// Grid
private _pos = mapGridPosition _target;
private _grid = format ["[%1-%2]", _pos select [0,2], _pos select [count _pos / 2,2] ];

// Relative
private _loc = nearestLocation [_target, ["NameCity", "NameCityCapital", "NameVillage"]];
private _distance = position _loc distance _target;

_distance = switch (true) do {
    case (_distance > 10000): { format ["%1 km", round (_distance / 1000)] };
    case (_distance > 1000): { format ["%1 km", round (_distance / 100) / 10] };
    case (_distance > 250): { format ["%1 m", round (_distance / 50) * 50] };
    default { "just" };
};

private _cdir = ["N", "NNE","NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW", "N"];
private _direction = _cdir select floor ( (position _loc getDir _target) / (360 / count _cdir));
private _rel = format ["%1 %2 from %3", _distance, _direction, className _loc]; 



private _return = switch (_type) do {
    case "VIC": { format ["%1 %2 - %3", _grid, _rel, _vehicleInfo ] };
    case "POS";
    case "STATIC";
    default { format ["%1 %2", _grid, _rel] };
};

_return
