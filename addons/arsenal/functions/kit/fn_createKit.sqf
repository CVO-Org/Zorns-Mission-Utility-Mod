#include "../../script_component.hpp"

/*
* Author: Zorn
* API Function for mission makers to add a kit to the MUM Arsenal.
* Kits are stored locally - call it on every client (e.g. initPlayerLocal.sqf).
*
* Arguments:
* 0: Items - classnames to add <ARRAY of STRINGS> (default: [])
* 1: Condition - params ["_unit", "_items"], needs to return BOOL <CODE> (default: {true})
* 2: Sides - "WEST", "EAST", "GUER", "CIV" - empty for all <ARRAY of STRINGS> (default: [])
* 3: Role - empty for all <STRING> (default: "")
* 4: Steam64 ID - empty for all <STRING> (default: "")
* 5: Addon dependency - CfgPatches class that needs to be loaded <STRING> (default: "")
* 6: Code - params ["_unit", "_items"], returns additional classnames <CODE> (default: {})
* 7: Key - unique kit name, overwrites an existing kit with the same key <STRING> (default: "" - auto generated)
*
* Return Value:
* Kit added <BOOL>
*
* Example:
* [["ACE_EarPlugs"]] call mum_arsenal_fnc_createKit
* [["ACE_M26_Clacker"], {true}, ["WEST"], "explosiveSpecialist"] call mum_arsenal_fnc_createKit
*
* Public: Yes
*/
params [
    ["_items", [], [[]] ],
    ["_cond",  {true}, [{}] ],
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
