#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to brute force a smooth and nice landing on a target LZ
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
    [ "_heli",       objNull, [objNull]      ],
    [ "_lz",         objNull, [objNull]      ],
    [ "_duration",   15,      [0]            ],
    [ "_forceDur",   120,     [0]            ],
    [ "_forceDis",   true,    [true]         ],
    [ "_offset",     "",      ["", []], [2]  ],
    [ "_engineOff",  true,   [0, false]      ]
];

if (isNull _heli || isNull _lz) exitWith { systemChat "Object not provided"; };

if !(local _heli) exitWith { ZRN_LOG_MSG(Not Local); };

driver _heli action ["LandGear", _heli];

private _startPos = getPosASL _heli;
private _endPos = getPosASL _lz;

private _intermediary = + _endPos;
_intermediary set [2, _startPos select 2];

private _positions = [_startPos, _intermediary, _endPos];

private _startVectorUp = vectorUp _heli;
private _startVectorDir = vectorDir _heli;
private _endVectorDir = (getPosASL _heli vectorMultiply [1,1,0]) vectorFromTo (getPosASL _lz vectorMultiply [1,1,0]);

if (_engineOff isEqualTo true) then { _engineOff = 0 };
if (_engineOff isEqualType 0) then { _heli setVariable ["landOnRails_engineOff", _engineOff, true]};


/*
_codeToRun  - <CODE> code to Run stated between {}
_parameters - <ANY> OPTIONAL parameters, will be passed to  code to run, exit code and condition
_exitCode   - <CODE> OPTIONAL exit code between {} code that will be executed upon ending PFEH default is {}
_condition  - <CODE THAT RETURNS BOOLEAN> - OPTIONAL conditions during which PFEH will run default {true}
_delay      - <NUMBER> (optional) delay between each execution in seconds, PFEH executes at most once per frame
*/

private _startTime = CBA_missionTime;
private _endTime = CBA_missionTime + _duration;
private _releaseTime = _endTime + _forceDur;
    
private _codeArgs = [_heli, _positions, _lz, _startVectorUp, _startVectorDir, _endVectorDir];
private _parameters = [_startTime, _endTime, _codeArgs, _releaseTime, _duration];

private _condition = { _this#3 > CBA_missionTime };

private _codeToRun = {
    params ["_startTime", "_endTime", "_codeArgs", "_releaseTime", "_duration"];
    _codeArgs params ["_heli", "_positions", "_lz", "_startVectorUp", "_startVectorDir", "_endVectorDir"];
    
    private _progress = linearConversion [_startTime, _endTime, CBA_missionTime, 0, 1, true];

    private _newPos = _progress bezierInterpolation _positions;

    _heli setPosASL _newPos;
    
    _heli setVectorDirAndUp [
        vectorLinearConversion [ 0, 0.5, _progress, _startVectorDir, _endVectorDir, true ],
        vectorLinearConversion [ 0, 0.5, _progress, _startVectorUp,  [0,0,1],       true ]
    ];

    if ( _progress > 0.5 ) then { driver _heli action ["LandGear", _heli]; };
};
 
private _exitCode = {
    _this#2 params ["_heli", "","", "_lz"];

    [QGVAR(forcedLandingDone), [_heli, _lz]] call CBA_fnc_localEvent;

    private _engineOffDelay = _heli getVariable ["landOnRails_engineOff", nil];
    if !(isNil "_engineOffDelay") then {
        if (_engineOffDelay > 0) then {
            [ { _this engineOn false; } , _heli, _engineOffDelay] call CBA_fnc_waitAndExecute;
        } else {
            [{ _this engineOn false; } , _heli] call CBA_fnc_execNextFrame;
        };
    };
};

private _delay = 0;

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



// handle forced dismount

if (_forceDis) then {
    [
        {
            getPos (_this#0) # 2 < 3
        },
        {
            [FUNC(orderlyDismount), _this, 2] call CBA_fnc_waitAndExecute;
        },
        [_heli, _offset]
    ] call CBA_fnc_waitUntilAndExecute;
};
