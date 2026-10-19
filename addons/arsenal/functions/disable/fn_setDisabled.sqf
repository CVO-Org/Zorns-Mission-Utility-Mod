#include "../../script_component.hpp"

/*
* Author: Zorn
* Sets the disabled state of an entry for one source in mum_arsenal_disabled.
* Each source is stored separately, so one source can not re-enable what another source has disabled.
*
* Arguments:
* 0: Kind - "kits", "autoRoles" or "autoTraits" <STRING>
* 1: Name of the entry <STRING>
* 2: Source - for example "setting" or "module" <STRING>
* 3: Disabled <BOOL>
*
* Return Value:
* None
*
* Example:
* [ "kits", "baseKit_Medical", "module", true ] call mum_arsenal_fnc_setDisabled
*
* Public: No
*/

params [
    [ "_kind",     "",    [""]   ],
    [ "_name",     "",    [""]   ],
    [ "_source",   "",    [""]   ],
    [ "_disabled", false, [true] ]
];

private _kindMap = GVAR(disabled) get toLowerANSI _kind;
if ( isNil "_kindMap" ) exitWith { ERROR_1("Unknown kind: %1",_kind); };

private _entry = _kindMap getOrDefaultCall [ toLowerANSI _name, { createHashMap }, true ];
_entry set [ toLowerANSI _source, _disabled ];

nil
