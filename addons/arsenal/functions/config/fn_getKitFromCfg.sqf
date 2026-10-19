#include "../../script_component.hpp"

/*
* Author: Zorn
* Reads a kit config entry and converts it into a kit hashmap.
*
* Arguments:
* 0: Kit config <CONFIG>
*
* Return Value:
* Kit <HASHMAP> - nil when the addon dependency is not loaded
*
* Example:
* [configFile >> "mum_arsenal_kits" >> "baseKit_Medical"] call mum_arsenal_fnc_getKitFromCfg
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

//// Retrieve and sanitize Sides
private _sides = (_cfg >> "sides" ) call BIS_fnc_getCfgDataArray;
_sides = _sides  apply { toUpperANSI _x } select { _x in ["WEST", "EAST", "GUER", "CIV"] };

// Create entry-hashmap to be returned
createHashMapFromArray [
    [ "id64",       getText (_cfg >> "id64" ) ],
    [ "sides",      _sides ],
    [ "role",       toLowerANSI getText (_cfg >> "role") ],
    [ "items",      _items ],
    [ "condition",  _conditionCode ],
    [ "code",       _codeCode ]
]
