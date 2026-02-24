#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to get the data from a config entry.
*
* Arguments:
*
* Return Value:
* HashMap
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
    [ "_cfg",   configNull, [configNull] ]
];


// Check Addon Dependency
private _dependency = getText (_cfg >> "addon_dependency");
if ( _dependency isNotEqualTo "" && {! isClass ( configFile >> "CfgPatches" >> _dependency ) } ) exitWith  { nil };

//// Convert Condition code
private _conditionCode = getText (_cfg >> "condition") call CBA_fnc_convertStringCode;

//// Convert Code code
private _codeCode = getText (_cfg >> "code") call CBA_fnc_convertStringCode;

//// Retrieve Items
private _items = "true" configClasses (_cfg >> "items") apply { configName _x };
_items = _items select { _x call CBA_fnc_getItemConfig isNotEqualTo configNull }; // rm entries that does not exist


// Create entry-hashmap to be returned
createHashMapFromArray [
    ["id64",  getText (_cfg >> "id64")],
    ["role",  toLowerANSI getText (_cfg >> "role")],
    ["items", _items],
    ["condition", _conditionCode],
    ["code", _codeCode]
]
