#include "../../script_component.hpp"

/*
* Author: Zorn
* Initializes the CSC registries and registers all config entries.
* Order: defaults, configFile, missionConfigFile. Mission entries may overwrite previously registered entries with the same ID.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* Called via preInit
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


// Registration order: defaults, then mod configs, then mission configs.
// Mission entries are allowed to overwrite previously registered entries with the same ID.
private _fnc_register = {
    params ["_config", "_fnc_api", ["_overwrite", false]];
    private _map = _config call EFUNC(common,getCfgDataHashmap);
    _map set ["id", toLowerANSI configName _config];
    [_map, _overwrite] call _fnc_api;
};

// Crates
{ [_x, FUNC(registerCrate)]       call _fnc_register } forEach ( "getNumber (_x >> ""registerDefault"") isEqualTo 1" configClasses (configFile >> QADDON >> "default_crates"));
{ [_x, FUNC(registerCrate)]       call _fnc_register } forEach ( "true" configClasses (configFile        >> QADDON >> "crates"));
{ [_x, FUNC(registerCrate), true] call _fnc_register } forEach ( "true" configClasses (missionConfigFile >> QADDON >> "crates"));

// Deliveries
{ [_x, FUNC(registerDeliveryMode)]       call _fnc_register } forEach ( "getNumber (_x >> ""registerDefault"") isEqualTo 1" configClasses (configFile >> QADDON >> "default_delivery_modes"));
{ [_x, FUNC(registerDeliveryMode)]       call _fnc_register } forEach ( "true" configClasses (configFile        >> QADDON >> "delivery_modes"));
{ [_x, FUNC(registerDeliveryMode), true] call _fnc_register } forEach ( "true" configClasses (missionConfigFile >> QADDON >> "delivery_modes"));

// Destinations
{ [_x, FUNC(registerDestination)]       call _fnc_register } forEach ( "getNumber (_x >> ""registerDefault"") isEqualTo 1" configClasses (configFile >> QADDON >> "default_destinations"));
{ [_x, FUNC(registerDestination)]       call _fnc_register } forEach ( "true" configClasses (configFile        >> QADDON >> "destinations"));
{ [_x, FUNC(registerDestination), true] call _fnc_register } forEach ( "true" configClasses (missionConfigFile >> QADDON >> "destinations"));
