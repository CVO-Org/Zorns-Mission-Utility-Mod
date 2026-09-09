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
