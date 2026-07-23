#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add an ACE Arsenal TAB for GreenMag when loaded
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

if (! isClass (configFile >> "CfgPatches" >> "greenmag_main") ) exitWith {};

// Array of Greenmag Items
private _greenTab = "('greenmag' in configName _x) && !('core' in configName _x)" configClasses (configFile >> "CfgWeapons") apply {configName _x};

// Creates GreenMag Arsenal Tab
ZRN_LOG_MSG(Pre ACE Panel Function);

[ _greenTab, "greenMag", QPATH_TO_ADDON(data\greenMag.paa) ] call ace_arsenal_fnc_addRightPanelButton;

ZRN_LOG_MSG(Green Tab Applied);
