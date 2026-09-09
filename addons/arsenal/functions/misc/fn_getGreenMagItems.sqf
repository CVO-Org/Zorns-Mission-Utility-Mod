#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to retrieve all greenmag Items based from a magazine Classname
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

params [ ["_magClass", nil, [""] ] ];

if (isNil "_magClass") exitWith {};

//check if unit has enough ammo of needed type
private _usedAmmo = if (greenmag_CBAS_simpleGM) then {
    getText (configFile >> "CfgMagazines" >> _magClass >> "greenmag_basicammo")
} else {
    getText (configFile >> "CfgMagazines" >> _magClass >> "greenmag_ammo")
};

if (_usedAmmo isEqualTo "") exitWith {};

private _map = missionNamespace getVariable [GVAR(greenMagCache), createHashMap];

// Get and Return Cached when Available
if (_usedAmmo in _map) exitWith { _map get _usedAmmo };

// Get Items, Return and Cache
private _kind = _usedAmmo splitString "_" select 1;
private _items = switch (_kind) do {
    case "beltlinked": { [ _usedAmmo + "_50",    _usedAmmo + "_100", _usedAmmo + "_150", _usedAmmo + "_200" ] };
    case "ammo":       { [ _usedAmmo + "_30Rnd", _usedAmmo + "_60Rnd" ] };
    default { [] };
};

_map set [_usedAmmo, _items];
missionNamespace setVariable [QGVAR(greenMagCache), _map, true];

_items
