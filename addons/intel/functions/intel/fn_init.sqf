#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
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

[ QGVAR(EH_addIntelAction), FUNC(addIntelAction) ] call CBA_fnc_addEventHandler;
[ QGVAR(EH_intelFound),     FUNC(intelFound)     ] call CBA_fnc_addEventHandler;
[ QGVAR(EH_publishIntel),   FUNC(publishIntel)   ] call CBA_fnc_addEventHandler;

