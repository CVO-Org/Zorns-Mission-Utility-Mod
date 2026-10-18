#include "../../script_component.hpp"

/*
* Author: Zorn
* Registers an access point: adds the ACE interaction to open the CSC request dialog to an object on all clients (JIP compatible).
* Server only.
*
* Arguments:
* 0: _targetObject - Object to add the interaction to <OBJECT>
* 1: _accessPointID - Unique ID, auto-generated when empty <STRING> (default: "")
* 2: _crates - Crate IDs or "#ALL" <ARRAY or STRING> (default: "#ALL")
* 3: _deliveryModes - Delivery mode IDs or "#ALL" <ARRAY or STRING> (default: [])
* 4: _destinations - Destination IDs or "#ALL" <ARRAY or STRING> (default: [])
* 5: _addParams - Additional parameters: "conditionType" ("ALWAYS" or "CUSTOM"), "conditionCodeCustom" <HASHMAP> (default: createHashMap)
*
* Return Value:
* true <BOOL>
*
* Example:
* [laptop_1, "hq", "#ALL", ["default_spawn", "default_drone"], "#ALL"] call mum_csc_fnc_registerAccessPoint
*
* Public: Yes
*/

if !(isServer) exitWith {};

params [
    [ "_targetObject",  objNull,       [objNull]       ],
    [ "_accessPointID", "",            [""]            ],
    [ "_crates",        "#ALL",        [[], ""]        ],
    [ "_deliveryModes", [],            [[], ""]        ],
    [ "_destinations",  [],            [[], ""]        ],
    [ "_addParams",     createHashMap, [createHashMap] ]
];

if (isNull _targetObject) exitWith {};

if (_accessPointID isEqualTo "") then {
    _accessPointID = [ QADDON, "accessPoint", "#", GVAR(accessPointCounter) ] joinString "_";
    GVAR(accessPointCounter) = GVAR(accessPointCounter) + 1;
};

_targetObject setVariable [QGVAR(accessPointID), _accessPointID, true];

[
    QGVAR(EH_createAccessPoint),
    [
        _targetObject,
        _accessPointID,
        _crates,
        _deliveryModes,
        _destinations,
        _addParams
    ],
    _targetObject
] call CBA_fnc_globalEventJIP;

true
