#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to store players starting kit as the variable on the player object - intended to be exeucted at the beginning of the mission.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call mum_arsenal_fnc_savePlayerLoadout;
*
* Public: No
*/

if !(hasInterface) exitWith {};


private _code = {

    if (SET(save_missionStart) isEqualTo -1) exitWith {};

    private _saveLoadout = {
        player setVariable [QGVAR(Loadout), [player] call CBA_fnc_getLoadout];
    };

    // Run initial Loadout saving
    call _saveLoadout;

    // run additional Loadout saving with delay
    private _delay = SET(save_missionStart);
    if (_delay isNotEqualTo 0) then { [ _saveLoadout , [], _delay] call CBA_fnc_waitAndExecute; };

};

if ( missionNamespace getVariable ["cba_settings_ready",false] ) then _code else { ["CBA_settingsInitialized",_code,[]] call CBA_fnc_addEventHandler; };
