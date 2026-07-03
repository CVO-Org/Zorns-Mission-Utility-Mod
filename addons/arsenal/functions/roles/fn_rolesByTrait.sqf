#include "../../script_component.hpp"

/*
* Author: Zorn
* Handles autoRoles and autoTraits upon opening the arsenal.
*
* Arguments:
*
* Return Value:
* _roles - array of roles.
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

ZRN_LOG_1(_this);

params [
    [ "_unit",  ACE_player, [objNull] ],
    [ "_roles", [],         [[]]      ]
];

if (isNil "_unit") exitWith { [] };

// #### Handle autoRoles ####
{

    private _autoRoleName = _x;
    private _autoRoleMap = _y;


    // Check CBA Setting
    private _settingName = [QGVAR(autoRoles), _autoRoleName] joinString "_";
    if (!isNil _settingName && { !(missionNamespace getVariable _settingName) } ) then { continue };


    // Condition
    private _conditionCode = _autoRoleMap get "condition";
    private _conditionResult = _unit call _conditionCode;


    // validate Return
    if (isNil "_conditionResult" || { typeName _conditionResult isNotEqualTo "BOOL" }) then {
        ERROR_1("Bad condition return for Kit: %1",_autoRoleName);
        _conditionResult = false;
    };

    diag_log format ['(Checking AutoRole) %1 - %2', _autoRoleName, _conditionResult];

    // Check Condition
    if (!_conditionResult) then { continue };
    _roles append (_autoRoleMap get "role");

    // Code
    private _codeCode = _autoRoleMap get "code";
    if (_codeCode isNotEqualTo {}) then { _unit call _codeCode; };

} forEach GVAR(autoRoles);


// #### Handle autoTraits ####
{

    private _autoTraitName = _x;
    private _autoTraitMap = _y;

    // Check CBA Setting
    private _settingName = [QGVAR(autoTraits), _autoTraitName] joinString "_";
    if (!isNil _settingName && { !(missionNamespace getVariable _settingName) } ) then { continue };


    // Check roles
    private _checkResult = _autoTraitMap get "role" in _roles;

    diag_log format ['(Checking AutoTrait) %1 - %2', _autoTraitName, _checkResult];

    if !(_checkResult) then { continue };

    // Code
    private _codeCode = _autoTraitMap get "code";
    if (_codeCode isNotEqualTo {}) then { _unit call _codeCode; };

} forEach GVAR(autoTraits);


diag_log format ['[CVO](debug)(fn_rolesByTrait) _roles: %1', _roles];
// return
_roles apply { toLowerANSI _x }
