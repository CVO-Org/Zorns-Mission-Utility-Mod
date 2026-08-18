#include "..\..\script_component.hpp"

/*
* Author: Zorn
* 3den Module Function to
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

// Module specific behavior. Function can extract arguments from logic and use them.
if (_activated) then
{
	// Attribute values are saved in module's object space under their class names
	private _bombYield = _logic getVariable ["Yield", -1]; // (as per the previous example, but you can define your own)
	hint format ["Bomb yield is: %1", _bombYield]; // will display the bomb yield, once the game is started
};
// Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
true;
