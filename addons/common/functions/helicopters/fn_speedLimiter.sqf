#include "../../script_component.hpp"

/*
* Author: Zorn
* Limits the Speed based on distance between vehicle and an object. Mainly used for helicopters.
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
    ["_heli", objNull, [objNull]],
    ["_tgt",  objNull, [objNull]]
];

if (isNull _heli || isNull _tgt) exitWith { systemChat "heli or tgt is null" };


if (!local _heli) exitWith { [QGVAR(EH_remote), [_this, QFUNC(speedLimiter)], _heli] call CBA_fnc_targetEvent; };


private _parameters = [_heli, _tgt];
private _delay = 0;

private _condition = {
    isNil QGVAR(API_disableSpeedLimiter)
    &&
    {
        alive (_this#0) && { (getPos (_this#0) select 2) > 5 };
    }
};

private _codeToRun = {
    params ["_heli", "_tgt"];
    private _limit = linearConversion [3000, 500, _heli distance2D _tgt, 200, 50, true];
    _heli limitSpeed _limit;
    if ( is3DENPreview && { ace_player in _heli } ) then { systemChat format ["Speed: %1/%2",floor speed _heli, floor _limit] };
};

private _exitCode = {};

[{
    params ["_args", "_handle"];
    _args params ["_codeToRun", "_parameters", "_exitCode", "_condition"];

    if (_parameters call _condition) then {
        _parameters call _codeToRun;
    } else {
        _handle call CBA_fnc_removePerFrameHandler;
        _parameters call _exitCode;
    };
}, _delay, [_codeToRun, _parameters, _exitCode, _condition]] call CBA_fnc_addPerFrameHandler;
