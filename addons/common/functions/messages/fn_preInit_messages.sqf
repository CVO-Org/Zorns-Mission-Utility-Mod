#include "../../script_component.hpp"

/*
* Author: Zorn
* Pre Init Function
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


[QGVAR(EH_zeusMessage), FUNC(zeusMessage)] call CBA_fnc_addEventHandler;
[QGVAR(EH_chatMessage), FUNC(chatMessage_remote)] call CBA_fnc_addEventHandler;

[QGVAR(EH_setName), { _this#0 setName _this#1 }] call CBA_fnc_addEventHandler;
[QGVAR(EH_hideUnit), { _this#0 hideObjectGlobal _this#1 }] call CBA_fnc_addEventHandler;
[QGVAR(EH_removeFromCurators), { { _x removeCuratorEditableObjects [flatten [_this], true] } forEach allCurators; }] call CBA_fnc_addEventHandler;
