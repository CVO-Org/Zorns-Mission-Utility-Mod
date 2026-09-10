#include "..\script_component.hpp"

/*
* Author: Zorn
* INIT FUnction to establish cba events
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

[QGVAR(EH_setUnitIcon), FUNC(setUnitIcon)] call CBA_fnc_addEventHandler;

[
    "CBA_SettingChanged",
    {
        params ["_setting", "_enabled"];

        if (_setting isNotEqualTo QSET(enabled)) exitWith {};

        if _enabled then {
            if (isServer) then {
                // Forces Icon Style
                ["diwako_dui_icon_style", QGVAR(officer), 10, "server"] call CBA_settings_fnc_set;
                // Forces Leader always first off cause its handled through the sorting method
                ["diwako_dui_radar_sqlFirst", false, 10, "server"] call CBA_settings_fnc_set;
            };

            // private _version = getNumber (configFile >> "CfgPatches" >> "diwako_dui_radar" >> "version"); // ToDo: Remove once
            // if ( _version > 1.12 ) then { diwako_dui_radar_customSort = FUNC(customSortingCode); };

            diwako_dui_radar_customSort = FUNC(customSortingCode);

        } else {
            diwako_dui_radar_customSort = nil;
        };
    }
] call CBA_fnc_addEventHandler;
