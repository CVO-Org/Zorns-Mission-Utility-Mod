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

if (isNil "_magClass") exitWith { [] };

//check if unit has enough ammo of needed type
private _usedAmmo = if (missionNamespace getVariable ["greenmag_main_cbas_simpleGM", true]) then {
    getText (configFile >> "CfgMagazines" >> _magClass >> "greenmag_basicammo")
} else {
    getText (configFile >> "CfgMagazines" >> _magClass >> "greenmag_ammo")
};

if (_usedAmmo isEqualTo "") exitWith { [] };

// Get CachedData or Create and Publish on first call
private _mapCBA = missionNamespace getVariable QGVAR(greenMagCache);
if (isNil "_mapCBA") then {
    _mapCBA = true call CBA_fnc_createNamespace;
    missionNamespace setVariable [QGVAR(greenMagCache), _mapCBA, true];
};

// Check Cache
if (_usedAmmo in allVariables _mapCBA) exitWith { _mapCBA getVariable _usedAmmo };

// Get Items, Return and Cache
private _items = switch (_usedAmmo splitString "_" select 1) do {
    case "beltlinked": { [ _usedAmmo + "_50", _usedAmmo + "_100", _usedAmmo + "_150", _usedAmmo + "_200" ] };
    case "ammo": {
        private _usedAmmoString = _usedAmmo trim ["_1Rnd",2];
        [ _usedAmmoString + "_30Rnd", _usedAmmoString + "_60Rnd" ]
    };
    default { [] };
};

_mapCBA setVariable [_usedAmmo, _items, true];

_items
