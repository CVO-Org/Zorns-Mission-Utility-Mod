#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to store the kit for a role.
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
