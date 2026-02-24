#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to delete a certain entry.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [ _catName, _entryName ] call mum_catalog_fnc_delEntry;
*
* Public: No
*/

params [
    [ "_catName",   "", [""] ],
    [ "_entryName", "" ]
];

if (_catName isEqualTo "") exitWith { false };
if (_entryName isEqualTo "") exitWith { false };

private _catalog = [_catName] call FUNC(getCatalog);

if !(_entryname in keys _catalog ) exitWith { false };

_catalog deleteAt _entryName;

true
