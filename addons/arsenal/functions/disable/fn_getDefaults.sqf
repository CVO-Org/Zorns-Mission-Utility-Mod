#include "../../script_component.hpp"

/*
* Author: Zorn
* Returns the names of the mod's default entries of a kind, which can be disabled via CBA Settings or the "Disable Defaults" module.
* Personal kits (with an id64) are never returned, as they can not be disabled.
*
* Arguments:
* 0: Kind - "kits", "autoRoles" or "autoTraits" <STRING>
*
* Return Value:
* Config names <ARRAY of STRINGS>
*
* Example:
* [ "kits" ] call mum_arsenal_fnc_getDefaults
*
* Public: No
*/

params [
    [ "_kind", "", [""] ]
];

switch ( toLowerANSI _kind ) do {
    case "kits": {
        "true" configClasses ( configFile >> QGVAR(kits) ) select {
            configName _x isNotEqualTo "baseKit"
            && { getText ( _x >> "id64" ) isEqualTo "" }
        } apply { configName _x }
    };
    case "autoroles": {
        "true" configClasses ( configFile >> QGVAR(autoRoles) ) select { configName _x isNotEqualTo "base" } apply { configName _x }
    };
    case "autotraits": {
        "true" configClasses ( configFile >> QGVAR(autoTraits) ) select { configName _x isNotEqualTo "base" } apply { configName _x }
    };
    default { [] };
}
