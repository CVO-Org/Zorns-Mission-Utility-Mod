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
* [] call CVO_Arsenal_fnc_savePlayerLoadout;
*
* Public: No
*/

if !(hasInterface) exitWith {};


private _code = {

    if !(SET(save_missionStart)) exitWith {};

    private _saveLoadout = {
        player setVariable [QGVAR(Loadout), [player] call CBA_fnc_getLoadout];
        diag_log "[CVO][Arsenal] player's CVO_Loadout saved";
    };

    private _delay = SET(save_missionStart_delay);
    if (_delay == 0) then _saveLoadout else { [ _saveLoadout , [], _delay] call CBA_fnc_waitAndExecute;    };

};

if ( missionNamespace getVariable ["cba_settings_ready",false] ) then _code else { ["CBA_settingsInitialized",_code,[]] call CBA_fnc_addEventHandler; };
