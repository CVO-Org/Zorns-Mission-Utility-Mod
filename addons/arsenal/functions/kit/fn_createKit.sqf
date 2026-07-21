#include "../../script_component.hpp"

/*
* Author: Zorn
* API Function for Mission Makers or Similar to add a roleKit to the catalog.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: Yes
*/
params [
    ["_items", [], [[]] ],
    ["_cond",  {}, [{}] ],
    ["_sides", [], [[]] ],
    ["_role",  "", [""] ],
    ["_id64",  "", [""] ],
    ["_addon", "", [""] ],
    ["_code",  {}, [{}] ],
    ["_key",   "", [""] ]
];

// Check Addon Dependency
if ( _addon isNotEqualTo "" && {! isClass ( configFile >> "CfgPatches" >> _addon ) } ) exitWith { false };

// Santize Sides
_sides = _sides  apply { toUpperANSI _x } select { _x in ["WEST", "EAST", "GUER", "CIV"] };

private _entry = createHashMapFromArray [
    [ "items",     _items ],
    [ "sides",     _sides ],
    [ "role",      toLowerANSI _role ],
    [ "id64",      _id64 ],
    [ "condition", _cond ],
    [ "code",      _code ]
];

[_entry, _key] call FUNC(addKit);

true
