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


// Get Content
private _intelContent  = "<br/>";
private _intelDesc = _logic getVariable QGVAR(intel_desc);
if (_intelDesc isNotEqualTo "") then { _intelContent = _intelContent + format [Q(<font color=COLOR_GREY face='RobotoCondensedLight'>%1</font><br/><br/>), _intelDesc]; };

_intelContent = _intelContent + ( _logic getVariable QGVAR(intelContent) );

// Apply Intel
{
    [
        _x,
        _logic getVariable QGVAR(intelTitle),
        _intelContent,
        _logic getVariable QGVAR(intelGroup),
        _logic getVariable QGVAR(removeObject),
        _logic getVariable QGVAR(actionTitle),
        _logic getVariable QGVAR(actionDuration),
        _logic getVariable QGVAR(actionSound),
        _logic getVariable QGVAR(shareWith)
    ] call FUNC(createIntel)
} forEach _units;

nil
