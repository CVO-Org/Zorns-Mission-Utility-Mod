#include "../script_component.hpp"

// Disabled default entries - name : [ source : disabled ] - see mum_arsenal_fnc_isDisabled
GVAR(disabled) = createHashMapFromArray [
    [ "kits",       createHashMap ],
    [ "autoroles",  createHashMap ],
    [ "autotraits", createHashMap ]
];

#include "initSettings_defaultKits.inc.sqf"

#include "initSettings_autoRoles.inc.sqf"
#include "initSettings_autoTraits.inc.sqf"

#include "initSettings_misc.inc.sqf"
