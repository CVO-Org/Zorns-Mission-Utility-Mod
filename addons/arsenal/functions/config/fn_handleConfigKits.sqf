#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call mum_arsenal_fnc_handleConfigKits
*
* Public: No
*/

if !(hasInterface) exitWith {};


private _configKit_mod = Q(configName _x isNotEqualTo QQ(baseKit)) configClasses (configFile >> QGVAR(kits));
private _configKit_mis = Q(configName _x isNotEqualTo QQ(baseKit)) configClasses (missionConfigFile >> QGVAR(kits));

// Filter out BaseKit / BaseRoleKit
if ( getNumber (missionConfigFile >> QGVAR(ignoreBaseKits))     isEqualTo 1 ) then { _configKit_mod = _configKit_mod select { !(toLowerANSI "baseKit"     in toLowerANSI _x) }; };
if ( getNumber (missionConfigFile >> QGVAR(ignoreBaseRoleKits)) isEqualTo 1 ) then { _configKit_mod = _configKit_mod select { !(toLowerANSI "baseRoleKit" in toLowerANSI _x) }; };

// Sort by Name
_configKit_mod = [_configKit_mod, [], { configName _x }, "ASCEND"] call BIS_fnc_sortBy;
_configKit_mis = [_configKit_mis, [], { configName _x }, "ASCEND"] call BIS_fnc_sortBy;

// Apply
private _configs = [];
_configs append _configKit_mod;
_configs append _configKit_mis;

{
    [
        [_x] call FUNC(getKitFromCfg),
        configName _x
    ] call FUNC(addKit);
} forEach _configs;
