#include "../../script_component.hpp"

/*
* Author: Zorn
* Removes the ACE intel action from the given object on the local machine.
*
* Arguments:
* 0: Intel object <OBJECT>
*
* Return Value:
* None
*
* Example:
* [_object] call mum_intel_fnc_removeintelAction
*
* Public: No
*/

params [ ["_object", objNull, [objNull]] ];

if (isNull _object) exitWith {};

[_object, 0, ["ACE_MainActions", QGVAR(intelAction)]] call ace_interact_menu_fnc_removeActionFromObject;
