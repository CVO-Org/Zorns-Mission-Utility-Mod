#include "../../script_component.hpp"

/*
* Author: Zorn
* This Mission init Function will create 3 GVAR Hashmaps which stores the individual presets from both configFile and missionConfigFile with the configName as a key and the configpath as the value.
* missionConfigFile entries will overwrite configFile entries, overwriting them.
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

// // Crates

// Cache Base Classes in dedicated GVAR
GVAR(base_crate)        = (configFile >> QADDON >> "base_crate")        call EFUNC(common,getCfgDataHashmap);
GVAR(base_deliveryMode) = (configFile >> QADDON >> "base_deliveryMode") call EFUNC(common,getCfgDataHashmap);
GVAR(base_destination)  = (configFile >> QADDON >> "base_destination")  call EFUNC(common,getCfgDataHashmap);


// crates
_configs = [];
_configs append ( "_x isNotEqualTo 'base'" configClasses (configFile >> QADDON >> "crates"));
_configs append ( "_x isNotEqualTo 'base'" configClasses (missionConfigFile >> QADDON >> "crates"));

{
    private _map = _x call EFUNC(common,getCfgDataHashmap);
    private _id = toLower configName _x;
    _map set ["id", _id];
    [ QGVAR(crates), _id, _map ] call EFUNC(catalog,setEntry);
} forEach _configs;

// Delivery
_configs = [];
_configs append ( "_x isNotEqualTo 'base'" configClasses (configFile >> QADDON >> "delivery_modes"));
_configs append ( "_x isNotEqualTo 'base'" configClasses (missionConfigFile >> QADDON >> "delivery_modes"));

{
    private _map = _x call EFUNC(common,getCfgDataHashmap);
    private _id = toLower configName _x;
    _map set ["id", _id];
    [ QGVAR(delivery_modes), _id, _map ] call EFUNC(catalog,setEntry);
} forEach _configs;


// Destination
_configs = [];
_configs append ( "_x isNotEqualTo 'base'" configClasses (configFile >> QADDON >> "destinations"));
_configs append ( "_x isNotEqualTo 'base'" configClasses (missionConfigFile >> QADDON >> "destinations"));

{
    private _map = _x call EFUNC(common,getCfgDataHashmap);
    private _id = toLower configName _x;
    _map set ["id", _id];
    [ QGVAR(destinations), _id, _map ] call EFUNC(catalog,setEntry);
} forEach _configs;
