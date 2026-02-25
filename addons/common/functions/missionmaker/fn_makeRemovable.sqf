#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add a "remove this object" Ace Action to an object. Required Item is Case Sensitive
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [this, 30, "ACE_wirecutter"] call mum_common_fnc_m makeRemovable;
*
* Public: No
*/

params [
    ["_object",         objNull,        [objNull]   ],
    ["_duration",       30,             [0]         ],
    ["_requiredItems",  "",             ["", []]    ],
    ["_additionalReq",  {true},         [{}]        ]
];

if (_requiredItems isEqualType "") then { _requiredItems = [_requiredItems] };

private _params = [_duration, _requiredItems, _additionalReq];
private _state = {
    params ["_target", "_player", "_actionParams"];
    _actionParams params ["_duration", "_requiredItems", "_additionalReq"];
    [
        [_duration, 1] select is3DENPreview                       // * 0: Total Time (in game "time" seconds) <NUMBER>
        ,[_target]                     // * 1: Arguments, passed to condition, fail and finish <ARRAY>
        // * 2: On Finish: Code called or STRING raised as event. <CODE, STRING>
        ,{
            params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
            _args params ["_target"];
            deleteVehicle _target;
        }
        // * 3: On Failure: Code called or STRING raised as event. <CODE, STRING>
        ,{}
        ,"Removing..."          // * 4: Localized Title <STRING> (default: "")
        ,{true}                 // * 5: Code to check each frame <CODE> (default: {true})
        ,[]                     // * 6: Exceptions for checking ace_common_fnc_canInteractWith <ARRAY> (default: [])
        ,true                   // * 7: Create progress bar as dialog, this blocks user input <BOOL> (default: true)

    ] call ace_common_fnc_progressBar;
};
private _cond = {
    params ["_target", "_player", "_actionParams"];
    _actionParams params ["_duration", "_requiredItems", "_additionalReq"];

    if ( _requiredItems findIf { !([_player, _x] call ace_common_fnc_hasItem) } > -1 ) exitWith { false };
    call _additionalReq
};

private _aceAction = [
    QGVAR(remove_action)                    // * 0: Action name <STRING>
    ,"Remove"                               //  * 1: Name of the action shown in the menu <STRING>
    ,""                                     //  * 2: Icon <STRING> "\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa"
    ,_state                                 //  * 3: Statement <CODE>
    ,_cond                                  //  * 4: Condition <CODE>
    ,{}                                     //  * 5: Insert children code <CODE> (Optional)
    ,_params                                //  * 6: Action parameters <ANY> (Optional)
    //,[0,0,0]                              //  * 7: Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    //,20                                   //  * 8: Distance <NUMBER> (Optional)
    //,[false,false,false,false,false]      //  * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
    //,{}                                   //  * 10: Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;



[
    _object                             // * 0: Object the action should be assigned to <OBJECT>
    ,0                                     // * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ,["ACE_MainActions"]                 // * 2: Parent path of the new action <ARRAY> (Example: ["ACE_SelfActions", "ACE_Equipment"])
    ,_aceAction                             // * 3: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;
