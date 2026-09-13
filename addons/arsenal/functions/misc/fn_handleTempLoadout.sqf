#include "..\..\script_component.hpp"

/*
* Author: Zorn
* CBA Settings - Script Function. Adds / Removes Eventhandler to temporary store current loadout on arsenal close.
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

params [ "_setting" ];

switch (true) do {
    // Register Event when enabled and not yet registered
    case ( _setting isEqualTo true && { isNil QGVAR(EH_ID_autoSaveLoadout) } ): {
        GVAR(EH_ID_autoSaveLoadout) = [
            "ace_arsenal_displayClosed",
            {
                [
                    "## Last Loadout",
                    [ACE_player] call CBA_fnc_getLoadout,
                    true
                ] call ace_arsenal_fnc_saveLoadout;
            }
        ] call CBA_fnc_addEventHandler;
    };
    // Remove Event when turned off and event is registered.
    case ( _setting isEqualTo false && { ! isNil QGVAR(EH_ID_autoSaveLoadout) } ): {
        ["ace_arsenal_displayClosed", GVAR(EH_ID_autoSaveLoadout)] call CBA_fnc_removeEventHandler;
        GVAR(EH_ID_autoSaveLoadout) = nil;
    };
};

nil
