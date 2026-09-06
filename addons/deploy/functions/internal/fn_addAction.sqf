#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add an ACE Action to an Object which the player can use to deploy from.
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
    ["_object",      objNull, [objNull] ],
    ["_networkName", nil,     [""]      ],
    ["_offset",      [0,0,0], [[]], [3] ]
];

if (_object isEqualTo objNull) exitWith {};

// Get Cat Name
if (isNil "_networkName") then {
    _networkName = _object getVariable [QGVAR(NetworkName), "Default"];
    if (isNil "_networkName") exitWith {};
};

private _network = [_networkName] call FUNC(network);
if (_network isEqualTo false) exitWith {ZRN_LOG_MSG_1(exit:,_network);};

// Ace Interaction
private _params = [_networkName];

private _aceAction = [
    _networkName splitString " " joinString "_"                                         // * 0: Action name <STRING>
    ,_network getOrDefault ["displayName", LLSTRING(displayName)]                                      //  * 1: Name of the action shown in the menu <STRING>
    ,_network getOrDefault ["icon", QPATHTOEF(main,data\Raven_Voron_256.paa)]    //  * 2: Icon <STRING> "\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa"
    ,FUNC(openDialog)                       //  * 3: Statement <CODE>
    ,{ isNil QGVAR(isTeleporting) }         //  * 4: Condition <CODE>
    ,FUNC(addAction_children)               //  * 5: Insert children code <CODE> (Optional)
    ,_params                                //  * 6: Action parameters <ANY> (Optional)
//    ,_offset
] call ace_interact_menu_fnc_createAction;

[
    _object                            // * 0: Object the action should be assigned to <OBJECT>
    ,0                                     // * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ,["ACE_MainActions"]                 // * 2: Parent path of the new action <ARRAY> (Example: ["ACE_SelfActions", "ACE_Equipment"])
    ,_aceAction                             // * 3: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;
