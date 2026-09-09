#include "..\script_component.hpp"

/*
* Author: Zorn
* Init Function to force CBA Settings
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

if (!isServer) exitWith {};

// Forces Icon Style
["diwako_dui_icon_style", "officer", 10, "server"] call CBA_settings_fnc_set;

// Forces Leader always first off cause its handled through the sorting method
["diwako_dui_radar_sqlFirst", false, 10, "server"] call CBA_settings_fnc_set;

