#include "../../script_component.hpp"

/*
* Author: Zorn
* Applies autoRoles (adds roles based on traits) and autoTraits (runs code based on roles) when opening the arsenal.
*
* Arguments:
* 0: Unit <OBJECT> (default: ACE_player)
* 1: Current roles of the unit <ARRAY of STRINGS> (default: [])
*
* Return Value:
* Roles including the autoRoles, lowercase <ARRAY of STRINGS>
*
* Example:
* [ACE_player, ["medic"]] call mum_arsenal_fnc_rolesByTrait
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


    // Check if disabled (CBA Setting or Module)
    if ( [ "autoRoles", _autoRoleName ] call FUNC(isDisabled) ) then { continue };


    // Condition
    private _conditionCode = _autoRoleMap get "condition";
    private _conditionResult = _unit call _conditionCode;


    // validate Return
    if (isNil "_conditionResult" || { typeName _conditionResult isNotEqualTo "BOOL" }) then {
        ERROR_1("Bad condition return for Kit: %1",_autoRoleName);
        _conditionResult = false;
    };



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

    // Check if disabled (CBA Setting or Module)
    if ( [ "autoTraits", _autoTraitName ] call FUNC(isDisabled) ) then { continue };


    // Check roles
    private _checkResult = _autoTraitMap get "role" in _roles;



    if !(_checkResult) then { continue };

    // Code
    private _codeCode = _autoTraitMap get "code";
    if (_codeCode isNotEqualTo {}) then { _unit call _codeCode; };

} forEach GVAR(autoTraits);



// return
_roles apply { toLowerANSI _x }
