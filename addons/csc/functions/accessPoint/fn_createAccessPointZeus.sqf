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

private _crates =         ["#ALL", "CRATES"]        call FUNC(getIDsFromNetwork);
private _deliveryModes = ["#ALL", "DELIVERYMODES"] call FUNC(getIDsFromNetwork);
private _destinations =   ["#ALL", "DESTINATIONS"]  call FUNC(getIDsFromNetwork);

private _accessPoint = createHashMapFromArray [
    [QGVAR(crates),        _crates         ],
    [QGVAR(destinations),  _destinations   ],
    [QGVAR(deliveryModes), _deliveryModes ],
    ["isZeus",              true           ]
];

private _conditionCode = { true };

private _aceAction = [_conditionCode, _accessPoint] call FUNC(createAction);

[
    ["ACE_ZeusActions"]                      // * 0: Parent path of the new action (e.g. ["ACE_ZeusActions"]) <ARRAY>
    ,_aceAction                                 // * 1: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToZeus;
