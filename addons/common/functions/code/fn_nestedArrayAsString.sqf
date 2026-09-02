#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function creates a nicely formatted string of a nested array. To be used for 3denAttributes.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [["something", 1], ["else", 123]] call prefix_component_fnc_functionname
*
* Public: No
*/

private _lb = "
";

private _string = format ["[%1    %2", _lb, _this deleteAt 0 call FUNC(arrayAsString)];

{ _string = _string + format [",%1    %2", _lb, _x  call FUNC(arrayAsString)]; } forEach _this;

_string = _string + format ["%1]", _lb];

_string
