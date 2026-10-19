#include "../../script_component.hpp"

/*
* Author: Zorn
* Checks if an entry is disabled. An entry is disabled as soon as any source (CBA Setting, module) has disabled it.
*
* Arguments:
* 0: Kind - "kits", "autoRoles" or "autoTraits" <STRING>
* 1: Name of the entry <STRING>
*
* Return Value:
* Disabled <BOOL>
*
* Example:
* [ "kits", "baseKit_Medical" ] call mum_arsenal_fnc_isDisabled
*
* Public: No
*/

params [
    [ "_kind", "", [""] ],
    [ "_name", "", [""] ]
];

private _entry = GVAR(disabled) getOrDefault [ toLowerANSI _kind, createHashMap ] getOrDefault [ toLowerANSI _name, createHashMap ];

true in values _entry
