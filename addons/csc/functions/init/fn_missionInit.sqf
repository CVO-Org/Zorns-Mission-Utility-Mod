#include "../../script_component.hpp"

/*
* Author: Zorn
* This Mission Init Function will create 3 GVAR Hashmaps which stores the individual presets from both configFile and missionConfigFile with the configName as a key and the configpath as the value.
* MissionConfigFile entries will overwrite configFile entries, overwriting them.
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

//// Establish 

private ["_type", "_configs"];

// crates
_type = QGVAR(crates);
_configs = [];
_configs append ( Q(configName _x isNotEqualTo QQ(baseCrate)) configClasses (       configFile >> _type) );
_configs append ( Q(configName _x isNotEqualTo QQ(baseCrate)) configClasses (missionConfigFile >> _type) );
{ [_type, toLower configName _x, _x] call EFUNC(catalog,setEntry); } forEach _configs;

// Delivery
_type = QGVAR(delivery_modes);
_configs = [];
_configs append ( Q(configName _x isNotEqualTo QQ(baseDelivery)) configClasses (       configFile >> _type) );
_configs append ( Q(configName _x isNotEqualTo QQ(baseDelivery)) configClasses (missionConfigFile >> _type) );
{ [_type, toLower configName _x, _x] call EFUNC(catalog,setEntry); } forEach _configs;

// Destination
_type = QGVAR(destinations);
_configs = [];
_configs append ( Q(configName _x isNotEqualTo QQ(baseDestination)) configClasses (       configFile >> _type) );
_configs append ( Q(configName _x isNotEqualTo QQ(baseDestination)) configClasses (missionConfigFile >> _type) );
{ [_type, toLower configName _x, _x] call EFUNC(catalog,setEntry); } forEach _configs;
