#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to create or return the  Network / Catalog hashmap, based on the Network Name
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

params [
    ["_networkName", "Default", ["acceptedDataTypes"] ]
];

private _network = missionNamespace getVariable [[QADDON,_networkName] joinString "_", "404"];

if (_network isEqualTo "404") then {
    _network = createHashMapFromArray [
        ["departure", []],
        ["destinations", []],
        ["nextDestinationIndex", 0]
    ];
    missionNamespace setVariable [[QADDON,_networkName] joinString "_",_network];
};

_network
