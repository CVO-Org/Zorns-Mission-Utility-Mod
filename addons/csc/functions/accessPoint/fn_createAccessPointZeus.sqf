#include "../../script_component.hpp"

/*
* Author: Zorn
* PostInit - Creates ACE Zeus self-action for CSC access.
* Retrieves all registered crates/destinations/deliveryModes, registers Zeus action.
*
* Arguments:
* None
*
* Return Value:
* nil
*
* Example:
* [] call mum_csc_fnc_createAccessPointZeus
*
* Public: Yes
*/

private _crates =        ["#ALL", "CRATES"       ] call FUNC(validateFrameworkIDs);
private _destinations =  ["#ALL", "DESTINATIONS" ] call FUNC(validateFrameworkIDs);
private _deliveryModes = ["#ALL", "DELIVERYMODES"] call FUNC(validateFrameworkIDs);

private _accessPoint = createHashMapFromArray [
    [ QGVAR(crates),        _crates        ],
    [ QGVAR(destinations),  _destinations  ],
    [ QGVAR(deliveryModes), _deliveryModes ],
    [ "isZeus",              true          ]
];

private _conditionCode = { true };

private _aceAction = [_accessPoint, _conditionCode] call FUNC(createAction);

[
    ["ACE_ZeusActions"]                      // * 0: Parent path of the new action (e.g. ["ACE_ZeusActions"]) <ARRAY>
    ,_aceAction                                 // * 1: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToZeus;
