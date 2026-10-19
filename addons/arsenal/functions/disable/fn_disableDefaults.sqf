#include "../../script_component.hpp"

/*
* Author: Zorn
* Event handler for mum_arsenal_EH_disableDefaults. Marks the given entries as disabled by the module.
*
* Arguments:
* 0: Kits <ARRAY of STRINGS>
* 1: AutoRoles <ARRAY of STRINGS>
* 2: AutoTraits <ARRAY of STRINGS>
*
* Return Value:
* None
*
* Example:
* [ [ "baseKit_Medical" ], [], [ "EWSpecialist" ] ] call mum_arsenal_fnc_disableDefaults
*
* Public: No
*/

params [
    [ "_kits",       [], [[]] ],
    [ "_autoRoles",  [], [[]] ],
    [ "_autoTraits", [], [[]] ]
];

{
    _x params [ "_kind", "_names" ];
    { [ _kind, _x, "module", true ] call FUNC(setDisabled); } forEach _names;
} forEach [
    [ "kits",       _kits       ],
    [ "autoRoles",  _autoRoles  ],
    [ "autoTraits", _autoTraits ]
];

nil
