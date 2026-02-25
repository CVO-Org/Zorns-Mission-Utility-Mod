#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to establish the Request-Action as a ACE Self Interaction with the option for custom Conditions for the action to be available.
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
    [ "_crates",           "DEFAULT",     [[], ""]        ],
    [ "_delivery_modes",   [],            [[], ""]        ],
    [ "_destinations",     [],            [[], ""]        ],
    [ "_addParams",        createHashMap, [createHashMap] ]
];

switch (true) do {
    case (_crates isEqualTo "DEFAULT"): { _crates = ["DEFAULT", "CRATES"] call FUNC(getDefaultPresets); };
    case (_crates isEqualType ""): { _crates = [_crates]; };
};


// Verifying Input
private _keys_crates         = keys GVAR(crates);
private _keys_destinations   = keys GVAR(destinations);
private _keys_delivery_modes = keys GVAR(delivery_modes);
_crates         = _crates         select { _x isEqualType "" } apply { toLower _x } select { _x in _keys_crates };
_destinations   = _destinations   select { _x isEqualType "" } apply { toLower _x } select { _x in _keys_destinations };
_delivery_modes = _delivery_modes select { _x isEqualType "" } apply { toLower _x } select { _x in _keys_delivery_modes };


// Create DataPackage
private _accessPoint = createHashMapFromArray [
    [QGVAR(crates),         _crates        ],
    [QGVAR(destinations),   _destinations  ],
    [QGVAR(delivery_modes), _delivery_modes]
];

_accessPoint merge _addParams; // does not overwrite existing entries.

private _conditionCode = switch (_accessPoint getOrDefault ["conditionType", "ALWAYS"]) do {
    case "ALWAYS": { { true } };
    case "CUSTOM": { _accessPoint getOrDefault ["conditionCodeCustom", { true } ] };
    default { { true } };
};

private _aceAction = [_conditionCode, _accessPoint] call FUNC(createAction);

[
    "CAManBase"                         // * 0: Object the action should be assigned to <OBJECT>
    ,1                                     // * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ,["ACE_SelfActions"]                 // * 2: Parent path of the new action <ARRAY> (Example: ["ACE_SelfActions", "ACE_Equipment"])
    ,_aceAction                             // * 3: Action <ARRAY>    
    ,true
] call ace_interact_menu_fnc_addActionToClass;

ZRN_LOG_MSG_1(Self Action AccessPoint Established on,"CAManBase");
