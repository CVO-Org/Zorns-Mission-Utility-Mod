#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to orderly dismount all units from a vehicle.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* 
*
* Public: No
*/

params [
    [ "_vehicle", objNull, [objNull] ],
    [ "_offset",  "",      ["", []], [2] ],
    [ "_delay",   0.9,     [0]       ]
];

ZRN_LOG_1(_this);

private _units = [];

_units append (fullCrew [_vehicle, "turret"] select { _x # 4 });
_units append (fullCrew [_vehicle, "cargo"]);

_units = _units apply { _x#0 };

if (_offset isNotEqualTo "") then {
    _offset params ["_dis", "_dir"];
    _offset = _vehicle getRelPos [_dis, _dir];
};



// ZRN_LOG_MSG_3(INIT,_vehicle,_units,_offset);


private _recCode = {
    params ["_units", "_recCode", "_delay", "_offset"];

    private _unit = _units deleteAt 0;
    
    [
        QGVAR(EH_remote),
        [
            [_unit, _offset], // Params for the remote EH code
            {
                params ["_unit", "_offset"];
                
                _unit allowDamage false;
                
                moveOut _unit;
                unassignVehicle _unit;
                [_unit] allowGetIn false;

                if !(_offset isEqualType "") then {
                    _unit setVehiclePosition [_offset, [], 3];
                };

                [{ _this allowDamage true; }, _unit, 2] call CBA_fnc_waitAndExecute;
            }   // remote EH Code
        ], // Params for the Event
        _unit   // Target
    ] call CBA_fnc_targetEvent;

    if (_units isEqualTo []) exitWith {};

    [_recCode, [_units, _recCode, _delay, _offset], _delay] call CBA_fnc_waitAndExecute;
};

[_units, _recCode, _delay, _offset] call _recCode;
