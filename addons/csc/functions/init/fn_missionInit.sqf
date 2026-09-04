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

// INIT GVARs
GVAR(accessPointCounter) = 0;
GVAR(accessPoints) = createHashMapFromArray [
    [
        "#ZEUS",
        createHashMapFromArray [
            [ "crates",        "#ALL" ],
            [ "deliveryModes", "#ALL" ],
            [ "destinations",  "#ALL" ]
        ]
    ]
];


GVAR(crates)        = createHashMap;
GVAR(deliveryModes) = createHashMap;
GVAR(destinations)  = createHashMap;

// Cache Base Classes
GVAR(base_crate)        = (configFile >> QADDON >> "base_crate")        call EFUNC(common,getCfgDataHashmap);
GVAR(base_deliveryMode) = (configFile >> QADDON >> "base_deliveryMode") call EFUNC(common,getCfgDataHashmap);
GVAR(base_destination)  = (configFile >> QADDON >> "base_destination")  call EFUNC(common,getCfgDataHashmap);


// Crates
_configs = [];
_configs append ( "true" configClasses (configFile >> QADDON >> "crates"));
_configs append ( "true" configClasses (missionConfigFile >> QADDON >> "crates"));
_configs append ( "getNumber (_x >> ""registerDefault"") isEqualTo 1" configClasses (configFile >> QADDON >> "default_crates"));

{
    private _map = _x call EFUNC(common,getCfgDataHashmap);
    private _id = toLowerANSI configName _x;
    _map set ["id", _id];
    [_map] call FUNC(registerCrate);
} forEach _configs;

// Deliveries
_configs = [];
_configs append ( "true" configClasses (configFile >> QADDON >> "delivery_modes"));
_configs append ( "true" configClasses (missionConfigFile >> QADDON >> "delivery_modes"));
_configs append ( "getNumber (_x >> ""registerDefault"") isEqualTo 1" configClasses (configFile >> QADDON >> "default_delivery_modes"));

{
    private _map = _x call EFUNC(common,getCfgDataHashmap);
    private _id = toLower configName _x;
    _map set ["id", _id];
    [_map] call FUNC(registerDeliveryMode);
} forEach _configs;


// Destination
_configs = [];
_configs append ( "true" configClasses (configFile >> QADDON >> "destinations"));
_configs append ( "true" configClasses (missionConfigFile >> QADDON >> "destinations"));
_configs append ( "getNumber (_x >> ""registerDefault"") isEqualTo 1" configClasses (configFile >> QADDON >> "default_destinations"));

{
    private _map = _x call EFUNC(common,getCfgDataHashmap);
    private _id = toLower configName _x;
    _map set ["id", _id];
    [_map] call FUNC(registerDestination);
} forEach _configs;
