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
* Public: No
*/

if (!hasInterface) exitWith {};

params [
    [ "_targetObject",  objNull,       [objNull]       ],
    [ "_accessPointID", "",            [""]            ],
    [ "_crates",        "#ALL",        [[], ""]        ],
    [ "_deliveryModes", [],            [[], ""]        ],
    [ "_destinations",  [],            [[], ""]        ],
    [ "_addParams",     createHashMap, [createHashMap] ]
];

if (isNull _targetObject) exitWith {};

// Create DataPackage
private _accessPointData = createHashMapFromArray [
    [ "crates",        _crates        ],
    [ "destinations",  _destinations  ],
    [ "deliveryModes", _deliveryModes ]
];

_accessPointData merge _addParams;

[QGVAR(EH_setData), [QGVAR(accessPoints), _accessPointID, _accessPointData ], _accessPointID] call CBA_fnc_localEvent;

private _conditionCode = switch (_accessPointData getOrDefault ["conditionType", "ALWAYS"]) do {
    case "CUSTOM": { _accessPointData getOrDefault ["conditionCodeCustom", { true } ] };
    case "ALWAYS";
    default { { true } };
};

private _aceAction = [_accessPointID, _conditionCode] call FUNC(createAction);

[
    _targetObject                        // * 0: Object the action should be assigned to <OBJECT>
    ,0                                     // * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ,["ACE_MainActions"]                 // * 2: Parent path of the new action <ARRAY> (Example: ["ACE_SelfActions", "ACE_Equipment"])
    ,_aceAction                             // * 3: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;
