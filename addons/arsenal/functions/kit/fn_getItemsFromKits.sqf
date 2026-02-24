#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to get an Array of Classnames based units Roles. Will check the condition and execute the code.
*
* Arguments:
*
* Return Value:
* Array - Classnames of Kit Items
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
    ["_unit", ACE_player, [objNull] ]
];

if (isNull _unit) exitWith {[]};

// ############ Handle Role Kit ############
private _roles = [_unit] call FUNC(getUnitRoles);

// Detectes ACE MEDIC and ACE Engineer
_roles = [_unit, _roles] call FUNC(rolesByTrait);

INFO_1("Player Roles: %1", _roles);
systemChat format ['[%1](%2) Player Roles: %3', PREFIX, COMPONENT, _roles];

private _returnArray = [];

private _kits = ["arsenal_kits"] call EFUNC(catalog,getCatalog);

private _playerUID = getPlayerUID _unit;

{

    private _kitName = _x;
    private _kit = _y;

    ZRN_LOG_1(_kitName);

    // #### Check if Setting for Default Kits
    private _settingName = [QADDON, _kitName] joinString "_";
    if (!isNil _settingName && { !(missionNamespace getVariable _settingName) } ) then { continue };


    // #### Check Roles ####
    private _role = _kit get "role";
    if (_role isNotEqualTo "" && { !( _role in _roles) }) then { continue };


    // #### Check ID64 ####
    private _id64 = _kit get "id64";
    if (_id64 isNotEqualTo "" && { _playerUID isNotEqualTo _id64 }) then { continue };


    private _items = _kit get "items";


    // #### Condition ####
    private _conditionCode = _kit get "condition";
    private _conditionResult = [_unit, _items] call _conditionCode;

    // validate Return
    if (isNil "_conditionResult" || { typeName _conditionResult isNotEqualTo "BOOL" }) then {
        ERROR_1("Bad condition return for Kit: %1",_kitName);
        _conditionResult = false;
    };

    if (!_conditionResult) then { continue };
    _returnArray append _items;


    // #### Code ####
    private _codeCode = _kit get "code";
    private _codeResult = if (_codeCode isNotEqualTo {}) then {
        [_unit, _items] call _codeCode;
    } else {[]};

    // Validate Return
    switch (true) do {
       case ( isNil "_codeResult" ):      { _codeResult = []; };
       case (_codeResult isEqualType ""): { _codeResult = [_codeResult]; };
    };
    _codeResult = _codeResult select { _x call CBA_fnc_getItemConfig isNotEqualTo configNull };

    _returnArray append _codeResult;

    ZRN_LOG_MSG_1(Added:,_kitName);

} forEach _kits;

_returnArray arrayIntersect _returnArray // remove duplicates and return
