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
* [QGVAR(somethign), "Key", "value"] call mum_catalog_fnc_setEntry;
*
* Public: No
*/

params [
    [ "_catName",   "", [""] ],
    [ "_entryName", "" ],
    [ "_value", nil ],
    [ "_blockOverwrite", false, [true]]
];

if (_catName isEqualTo "") exitWith { false };
if (_entryName isEqualTo "") exitWith { false };

private _catalog = [_catName] call FUNC(getCatalog);

if (_blockOverwrite && { _entryname in keys _catalog }) exitWith { false };

_catalog set [_entryName, _value];

true
