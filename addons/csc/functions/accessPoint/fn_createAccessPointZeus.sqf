#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to handle the Zeus Interace Self Action
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

private _crates = ["ZEUS", "CRATES"] call FUNC(getDefaultPresets);
private _delivery_modes = ["ZEUS", "DELIVERY_MODES"] call FUNC(getDefaultPresets);
private _destinations = ["ZEUS", "DESTINATIONS"] call FUNC(getDefaultPresets);

private _accessPoint = createHashMapFromArray [
    [QGVAR(crates),         _crates        ],
    [QGVAR(destinations),   _destinations  ],
    [QGVAR(delivery_modes), _delivery_modes],
    ["isZeus",              true           ]
];

private _conditionCode = { true };

private _aceAction = [_conditionCode, _accessPoint] call FUNC(createAction);

[
    ["ACE_ZeusActions"]                      // * 0: Parent path of the new action (e.g. ["ACE_ZeusActions"]) <ARRAY>
    ,_aceAction                                 // * 1: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToZeus;
