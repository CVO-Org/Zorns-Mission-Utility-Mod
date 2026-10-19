#include "..\script_component.hpp"

/*
* Author: Zorn
* INIT Function to establish DUI related cba events
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

[
    "CBA_SettingChanged",
    {
        params ["_setting", "_enabled"];

        if ( _setting isNotEqualTo QSET(enabled) ) exitWith {};

        // Forced settings: [setting, forced value]
        private _forcedSettings = createHashMapFromArray [
            [ "diwako_dui_icon_style", QGVAR(officer) ],  // Forces Icon Style
            [ "diwako_dui_radar_sqlFirst", false ],       // Forces Leader always first off cause its handled through the sorting method
            [ "diwako_dui_radar_sortType", "custom" ]     // Forces DUI to use diwako_dui_radar_customSort
        ];

        if _enabled then {
            // Server source with priority 2 ("overwrite mission") beats any client or mission value, gets synced to all clients incl. JIP and is not stored - only lasts for this mission
            if ( isServer && { isNil QGVAR(originalSettings) } ) then {

                GVAR(originalSettings) = createHashMap;
                {
                    GVAR(originalSettings) set [
                        _x,
                        [
                            [ _x, "server" ] call CBA_settings_fnc_get,
                            [ _x, "server" ] call CBA_settings_fnc_priority
                        ]
                    ];

                    [ _x, _y, 2, "server" ] call CBA_settings_fnc_set;
                } forEach _forcedSettings;
            };

            diwako_dui_radar_customSort = FUNC(customSortingCode);

        } else {
            // Restores the previous server values
            if ( isServer && { !isNil QGVAR(originalSettings) } ) then {
                { [ _x, _y#0, _y#1, "server" ] call CBA_settings_fnc_set; } forEach GVAR(originalSettings);
                GVAR(originalSettings) = nil;
            };

            diwako_dui_radar_customSort = nil;
        };
    }
] call CBA_fnc_addEventHandler;
