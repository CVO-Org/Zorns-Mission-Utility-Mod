#include "..\..\script_component.hpp"

/*
* Author: Zorn
* CBA setting script. Adds or removes the event handler that saves the current loadout as "## Last Loadout" when an ACE Arsenal is closed.
*
* Arguments:
* 0: Setting value <BOOL>
*
* Return Value:
* None
*
* Example:
* [true] call mum_arsenal_fnc_handleTempLoadout
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
