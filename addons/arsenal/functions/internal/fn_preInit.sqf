#include "../../script_component.hpp"

/*
* Author: Zorn
* Detects GreenMag and registers the mum_arsenal_EH_initBox and mum_arsenal_EH_disableDefaults events.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call mum_arsenal_fnc_preInit
*
* Public: No
*/

GVAR(loaded_greenMag) = isClass (configFile >> "CfgPatches" >> "greenmag_main");

[QGVAR(EH_initBox), FUNC(initBox)] call CBA_fnc_addEventHandler;
[ QGVAR(EH_disableDefaults), FUNC(disableDefaults) ] call CBA_fnc_addEventHandler;

