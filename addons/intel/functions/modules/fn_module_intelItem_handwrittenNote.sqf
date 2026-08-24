#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module Function to turn an object into a an MUM Intel item.
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

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

if (_units isEqualTo []) exitWith {};

private _intelGroup =           _logic getVariable [QGVAR(intelGroup), "General"];
private _intelTitle =           _logic getVariable [QGVAR(intelTitle), "A piece of Intel"];

private _intelContent_header =    _logic getVariable [QGVAR(intelContent_header), "body"];
private _intelContent_body =    _logic getVariable [QGVAR(intelContent_body), "body"];

private _removeObject =     _logic getVariable [QGVAR(removeObject), true];

private _actionTitle =      _logic getVariable [QGVAR(actionTitle), "Gathering Intel..."];
private _actionDuration =   _logic getVariable [QGVAR(actionDuration), 15];
private _actionSound =      _logic getVariable [QGVAR(actionSound), "AUTO"];

private _shareWith =        _logic getVariable [QGVAR(shareWith), "DEFAULT"];

private _intelContent = "<br/>";
_intelContent = _intelContent + format ["<font face='RobotoCondensedLight'>%1</font><br/>", _intelContent_header ];
_intelContent = _intelContent + format [ "<br/><font face='Caveat' size='25'>%1</font>",    _intelContent_body   ];

{ [_x, _intelTitle, _intelContent, _intelGroup, _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith] call FUNC(createIntel) } forEach _units;

nil
