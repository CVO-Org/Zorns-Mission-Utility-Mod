#include "../../script_component.hpp"

/*
* Author: Zorn
* Stores a kit in the "arsenal_kits" catalog.
*
* Arguments:
* 0: Kit <HASHMAP>
* 1: Key - unique kit name, overwrites an existing kit with the same key <STRING> (default: "" - auto generated)
*
* Return Value:
* Kit added <BOOL>
*
* Example:
* [_kit, "myKit"] call mum_arsenal_fnc_addKit
*
* Public: No
*/

params [
    ["_entry", nil, [createHashMap] ],
    [ "_key", "", [""] ]
];

if (isNil "_entry") exitWith { false };

if (_key isEqualTo "") then {
    private _index = missionNamespace getVariable [QGVAR(kit_index), 0];
    GVAR(kit_index) = _index + 1;
    _key = [QADDON, "Kit", _index] joinString "_";
};

["arsenal_kits", _key, _entry] call EFUNC(catalog,setEntry);

true
