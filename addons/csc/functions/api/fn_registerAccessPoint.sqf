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


if ( _crates        isEqualTo [] ) exitWith { ERROR("Cannot create AccessPoint - No Crates defined") };
if ( _destinations  isEqualTo [] ) exitWith { ERROR("Cannot create AccessPoint - No Destinations defined") };
if ( _deliveryModes isEqualTo [] ) exitWith { ERROR("Cannot create AccessPoint - No Delivery Modes defined") };

// Create DataPackage
private _accessPoint = createHashMapFromArray [
    [ QGVAR(crates),        _crates        ],
    [ QGVAR(destinations),  _destinations  ],
    [ QGVAR(deliveryModes), _deliveryModes ]
];

_accessPoint merge _addParams; // does not overwrite existing entries.

private _conditionCode = switch (_accessPoint getOrDefault ["conditionType", "ALWAYS"]) do {
    case "CUSTOM": { _accessPoint getOrDefault ["conditionCodeCustom", { true } ] };
    case "ALWAYS";
    default { { true } };
};

private _aceAction = [_accessPoint, _conditionCode] call FUNC(createAction);

[
    _targetObject                        // * 0: Object the action should be assigned to <OBJECT>
    ,0                                     // * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ,["ACE_MainActions"]                 // * 2: Parent path of the new action <ARRAY> (Example: ["ACE_SelfActions", "ACE_Equipment"])
    ,_aceAction                             // * 3: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;
