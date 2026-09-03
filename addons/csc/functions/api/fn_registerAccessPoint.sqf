#include "../../script_component.hpp"

/*
* Author: Zorn
* Creates ACE interact menu action on object for CSC access.
* Validates crate/destination/delivery mode lists, creates condition code, registers with ACE.
*
* Arguments:
* 0: _targetObject - Object to add interaction to <OBJECT>
* 1: _crates - Array of crate IDs or single ID <ARRAY or STRING>
* 2: _deliveryModes - Array of delivery mode IDs <ARRAY>
* 3: _destinations - Array of destination IDs <ARRAY>
* 4: _addParams - Optional additional parameters hashmap <HASHMAP> (default: createHashMapFromArray [])
*
* Return Value:
* nil
*
* Example:
* [targetObj, ["crate1", "crate2"], ["airdrop_heli"], ["pos_fixed"]] call mum_csc_fnc_createAccessPoint
*
* Public: Yes
*/

if !(isServer) exitWith {};

params [
    [ "_targetObject",  objNull,       [objNull]       ],
    [ "_crates",        "#ALL",        [[], ""]        ],
    [ "_deliveryModes", [],            [[], ""]        ],
    [ "_destinations",  [],            [[], ""]        ],
    [ "_addParams",     createHashMap, [createHashMap] ]
];


if (isNull _targetObject) exitWith {};

_crates =        [ _crates,        "CRATES"        ] call FUNC(validateFrameworkIDs);
_destinations =  [ _destinations,  "DESTINATIONS"  ] call FUNC(validateFrameworkIDs);
_deliveryModes = [ _deliveryModes, "DELIVERYMODES" ] call FUNC(validateFrameworkIDs);


[
    QGVAR(EH_createAccessPoint),
    [
        _targetObject,
        _crates,
        _deliveryModes,
        _destinations,
        _addParams
    ],
    _targetObject
] call CBA_fnc_globalEventJIP;
