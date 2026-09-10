#include "../../script_component.hpp"

/*
* Author: Zorn
* PreInit Function
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

GVAR(loaded_greenMag) = isClass (configFile >> "CfgPatches" >> "greenmag_main");

[QGVAR(EH_initBox), FUNC(initBox)] call CBA_fnc_addEventHandler;

