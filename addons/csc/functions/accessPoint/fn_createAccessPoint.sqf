#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to create an accesspoint on an Object
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
    ["_targetObject",     objNull,       [objNull]      ],
    ["_crates",           "ALL",         [[], ""]       ],
    ["_delivery_modes",   [],            [[], ""]       ],
    ["_destinations",     [],            [[], ""]       ],
    ["_addParams",        createHashMap, [createHashMap]]
];

if (isNull _targetObject) exitWith {};

switch (true) do {
    case (_crates isEqualTo "ALL"): { _crates = ["ALL", "CRATES"] call FUNC(getIDsFromNetwork); };
    case (_crates isEqualType ""): { _crates = [_crates]; };
};



// Verifying Input
private _keys_crates         = keys GVAR(crates);
private _keys_destinations   = keys GVAR(destinations);
private _keys_delivery_modes = keys GVAR(deliveryModes);
_crates         = _crates         select { _x isEqualType "" } apply { toLower _x } select { _x in _keys_crates };
_destinations   = _destinations   select { _x isEqualType "" } apply { toLower _x } select { _x in _keys_destinations };
_delivery_modes = _delivery_modes select { _x isEqualType "" } apply { toLower _x } select { _x in _keys_delivery_modes };


if ( _crates isEqualTo [] )         exitWith { ERROR("Cannot create AccessPoint - No Crates defined")};
if ( _destinations isEqualTo [] )   exitWith { ERROR("Cannot create AccessPoint - No Destinations defined")};
if ( _delivery_modes isEqualTo [] ) exitWith { ERROR("Cannot create AccessPoint - No Delivery Modes defined")};

// Create DataPackage
private _accessPoint = createHashMapFromArray [
    [QGVAR(crates),         _crates        ],
    [QGVAR(destinations),   _destinations  ],
    [QGVAR(deliveryModes), _delivery_modes]
];

_accessPoint merge _addParams; // does not overwrite existing entries.


//// Condition for Action Availability
/*
// Examlpe for later Condition Types
{
    // params ["_target", "_player", "_accessPoint"];
    true
};
*/

private _conditionCode = switch (_accessPoint getOrDefault ["conditionType", "ALWAYS"]) do {
    case "ALWAYS": { { true } };
    case "CUSTOM": { _accessPoint getOrDefault ["conditionCodeCustom", { true } ] };
    default { { true } };
};

private _aceAction = [_conditionCode, _accessPoint] call FUNC(createAction);

[
    _targetObject                        // * 0: Object the action should be assigned to <OBJECT>
    ,0                                     // * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ,["ACE_MainActions"]                 // * 2: Parent path of the new action <ARRAY> (Example: ["ACE_SelfActions", "ACE_Equipment"])
    ,_aceAction                             // * 3: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;

ZRN_LOG_MSG_1(AccessPoint Established on,_targetObject);
