#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call MUM_fnc_sth
*
* Public: Yes
*/

params ["", "_player", "_actionParams"];
_actionParams params ["_destination"];

if ( _player isEqualTo objNull || { _destination isEqualTo false } ) exitWith {};

private _target = _destination get "target";
private _min    = _destination get "min";
private _max    = _destination get "max";

// Position array with 2 Values: ATL
// Position array with 3 Values: ASL
private _code = switch (true) do {
    case (_target isEqualType [] ): { { if (count (_this#1) == 2) then { _this#0 setPos _this#1 } else { _this#0 setPosASL _this#1 } } };
    case (_target emptyPositions  "" > 0) : { { _this#0 moveInAny _this#1 } };
    default {
        _target = getPos _target findEmptyPosition [_min,_max, typeOf _player];
        { _this#0 setPos _this#1  }
    };
};


GVAR(isTeleporting) = true;
[ { GVAR(isTeleporting) = nil; } ,nil, 3] call CBA_fnc_waitAndExecute;


[QGVAR(holdAction_TP_blackening), true, 2.85 ] call BIS_fnc_blackOut;
[ _code , [_player, _target], 3] call CBA_fnc_waitAndExecute;
[ BIS_fnc_blackIn , [QGVAR(holdAction_TP_blackening), true, 0.9 ], 3.15 ] call CBA_fnc_waitAndExecute;
