#include "../../script_component.hpp"

/*
* Author: Zorn
* Reads autoRoles and autoTraits from configFile and missionConfigFile into mum_arsenal_autoRoles and mum_arsenal_autoTraits.
* Runs only once per client.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call mum_arsenal_fnc_handleConfigAutoRoles
*
* Public: No
*/

if !(hasInterface) exitWith {};

if !( isNil QGVAR(init_autoRoles) ) exitWith {};

// AutoRoles
private _autoRoles = [];
_autoRoles append ( Q(configName _x isNotEqualTo QQ(base)) configClasses (configFile >> QGVAR(autoRoles)) );
_autoRoles append ( Q(configName _x isNotEqualTo QQ(base)) configClasses (missionConfigFile >> QGVAR(autoRoles)) );

private _autoRolesMap = createHashMap;
GVAR(autoRoles) = _autoRolesMap;


{
    private _cfg = _x;

    _autoRolesMap set [
        configName _cfg,
        createHashMapFromArray [
            ["condition", getText (_cfg >> "condition") call CBA_fnc_convertStringCode],
            ["role", (_cfg >> "role") call BIS_fnc_getCfgDataArray select { _x isEqualType "" }],
            ["code", getText (_cfg >> "code") call CBA_fnc_convertStringCode]
        ]
    ];

} forEach _autoRoles;


// AutoTraits
private _autoTraits = [];
_autoTraits append ( Q(configName _x isNotEqualTo QQ(base)) configClasses (configFile >> QGVAR(autoTraits)) );
_autoTraits append ( Q(configName _x isNotEqualTo QQ(base)) configClasses (missionConfigFile >> QGVAR(autoTraits)) );

private _autoTraitsMap = createHashMap;
GVAR(autoTraits) = _autoTraitsMap;


{
    private _cfg = _x;

    _autoTraitsMap set [
        configName _cfg,
        createHashMapFromArray [
            ["role", getText (_cfg >> "role")],
            ["code", getText (_cfg >> "code") call CBA_fnc_convertStringCode]
        ]
    ];

} forEach _autoTraits;

GVAR(init_autoRoles) = true;
