#include "../../script_component.hpp"

/*
* Author: Zorn
* PreInit function - registers the CBA event handlers of the intel component.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* call mum_intel_fnc_init
*
* Public: No
*/

[ QGVAR(EH_addIntelAction), FUNC(addIntelAction) ] call CBA_fnc_addEventHandler;
[ QGVAR(EH_intelFound),     FUNC(intelFound)     ] call CBA_fnc_addEventHandler;
[ QGVAR(EH_publishIntel),   FUNC(publishIntel)   ] call CBA_fnc_addEventHandler;

