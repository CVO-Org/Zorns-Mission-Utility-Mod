#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to retrieve a catalog (hashmap) and creating it if needed.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [ _catName, _entryName, _orDefault, _setDefault ] call mum_catalog_fnc_getEntry;
*
* Public: No
*/

params [
    [ "_catName",   "", [""] ],
    [ "_entryName", "" ],
    [ "_orDefault", nil ],
    [ "_setDefault", false, [true]]
];

if (_catName isEqualTo "") exitWith { false };
if (_entryName isEqualTo "") exitWith { false };

private _catalog = [_catName] call FUNC(getCatalog);

private _entry = if (_entryName in keys _catalog) then {
    _catalog get _entryName
} else {
    if (_setDefault) then { _catalog set [_entryName, _orDefault] };
    _orDefault
};

_entry
