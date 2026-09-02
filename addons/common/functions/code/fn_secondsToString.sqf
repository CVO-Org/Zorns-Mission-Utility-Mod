#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function which will convert a duration in seconds into a beutified string.
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

params ["_duration"];

_duration = _duration max 1;

private _h = floor (_duration / 3600);
private _m = floor ((_duration - (_h*3600)) / 60);
private _s = floor (_duration - (_h*3600) - (_m*60));

switch (true) do {
    case ( _h  > 1 ): { format ["%1 hours and %2 minutes",_h, _m]; };
    case ( _h == 1 ): { format ["%1 hour and %2 minutes",_h, _m]; };
    case ( _m  > 3 ): { format ["%1 minutes", _m]; };
    case ( _m  > 0 ): { format ["%1 minutes and %2 seconds", _m, _s]; };
    case ( _m == 1 ): { "1 minute" };
    case ( _s == 1 ): { "1 second" };
    default { format ["%1 seconds", _s] };
} // return
