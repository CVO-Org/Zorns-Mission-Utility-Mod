#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to remove the Intel Action from a Unit.
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

params [ ["_object", objNull, [objNull]] ];

if (isNull _object) exitWith {};

[_object, 0, ["ACE_MainActions", QGVAR(intelAction)]] call ace_interact_menu_fnc_removeActionFromObject;
