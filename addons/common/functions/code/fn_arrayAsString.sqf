#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to return a nicely formatted Array as a string
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

diag_log format ['[CVO](debug)(fn_arrayAsString) _this: %1', _this];

if !(_this isEqualType []) exitWith { str _this };
if (_this isEqualTo []) exitWith { str _this };


private _str = format ["[ %1", str (_this deleteAt 0)];

{ _str = _str + format [", %1", str _x]; } forEach _this;

_str = _str + " ]";

diag_log format ['[CVO](debug)(fn_arrayAsString) _str: %1', _str];

_str
