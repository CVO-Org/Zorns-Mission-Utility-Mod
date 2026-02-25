#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to get Unit which will send the message.
* Will create unit when not already defined.
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

params ["_identity", "_side"];


private _namespace = missionNamespace getVariable QGVAR(messageSenders);

if (isNil "_namespace") then {
    _namespace = true call CBA_fnc_createNamespace;
    missionNamespace setVariable [QGVAR(messageSenders), _namespace, true];
};

private _id = _identity splitString " " joinString "_";
private _entry = _namespace getVariable _id;

private _unit = if ( isNil "_entry" || { isNull (_entry#0) || { ! alive (_entry#0) } } ) then {

    private _grp = createGroup [_side, true];
    private _createdUnit = _grp createUnit ["B_RangeMaster_F", [0,0,0], [], 10, "NONE" ];
   
    _grp setGroupIdGlobal [_identity];
    [QGVAR(EH_setName),  [_createdUnit, _identity], _createdUnit] call CBA_fnc_globalEventJIP;
    [QGVAR(EH_hideUnit), [_createdUnit, true],      _createdUnit] call CBA_fnc_globalEventJIP;
    [QGVAR(EH_removeFromCurators),                  _createdUnit] call CBA_fnc_serverEvent;
    _createdUnit allowDamage false;

    // Init Cleanup
    [
        CBA_fnc_waitUntilAndExecute,
        [
                {
                    params ["_namespace", "_id"];
                    _namespace getVariable _id select 1 < CBA_missionTime
                },
                {
                    params ["_namespace", "_id"];
                    
                    deleteVehicle (_namespace getVariable _this select 0);
                    _namespace setVariable [_id, nil, true];
                },
                [_namespace, _id]
        ]
    ] call CBA_fnc_execNextFrame;

    _createdUnit

} else {

    _entry # 0

};

_namespace setVariable [ _id, [_unit, CBA_missionTime + 120], true ];

_unit // return
