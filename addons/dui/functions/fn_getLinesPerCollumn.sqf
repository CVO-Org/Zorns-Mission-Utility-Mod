#include "..\script_component.hpp"

/*
* Author: Zorn
* Function to figure out how many lines are there per collumn.
*
* Arguments:
*
* Return Value:
* Number of Entries per Collumn
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

private _display = uiNamespace getVariable ["diwako_dui_RscNameBox", displayNull];
private _grpCtrl = _display displayCtrl 1337005;
ctrlPosition _grpCtrl params ["", "", "", "_height"];

private _curNameListHeight = (_height / pixelH) - ((15 * diwako_dui_hudScaling) max 15);
private _itemHeight = (128 / 5) * diwako_dui_namelist_size * diwako_dui_radar_namelist_vertical_spacing;

ceil (_curNameListHeight/ _itemHeight)
