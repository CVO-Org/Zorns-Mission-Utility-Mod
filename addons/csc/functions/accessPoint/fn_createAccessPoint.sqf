#include "../../script_component.hpp"

/*
* Author: Zorn
* Local part of registerAccessPoint: stores the access point data and adds the ACE action on this client.
* Executed via CBA JIP event on every machine, exits without interface.
*
* Arguments:
* 0: _targetObject - Object to add the interaction to <OBJECT>
* 1: _accessPointID - Access point ID <STRING>
* 2: _crates - Crate IDs or "#ALL" <ARRAY or STRING> (default: "#ALL")
* 3: _deliveryModes - Delivery mode IDs or "#ALL" <ARRAY or STRING> (default: [])
* 4: _destinations - Destination IDs or "#ALL" <ARRAY or STRING> (default: [])
* 5: _addParams - Additional parameters <HASHMAP> (default: createHashMap)
*
* Return Value:
* None
*
* Example:
* [laptop_1, "hq", "#ALL", "#ALL", "#ALL"] call mum_csc_fnc_createAccessPoint
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

[QGVAR(EH_setData), [QGVAR(accessPoints), _accessPointID, _accessPointData ]] call CBA_fnc_localEvent;

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
