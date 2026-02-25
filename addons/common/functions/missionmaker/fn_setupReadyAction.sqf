#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to establish the Ready Action
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
    [ "_actionObject",      objNull, [objNull] ],
    [ "_codeAllReady",      {},      [{}]      ],
    [ "_codeJIPReady",      {},      [{}]      ],
    [ "_setTexture",      true,      [true]    ]
];

if (_setTexture) then { _actionObject setObjectTexture [0, '#(rgb,512,512,3)text(1,1,"EraserRegular",0.1,"#ffffffff","#ff0000","Ready Up !")']  };


// REGISTER SERVER EVENT
if (isServer) then {
    [
        "mission_report_ready",
        {
            private _players = [] call CBA_fnc_players;
            private _players = _players select { ! (_x getVariable ["mission_isReady", false]) };
            if (_players isEqualTo []) then {

                missionNamespace setVariable ["mission_start", true, true];

                [ QGVAR(ReadyAction_notify), "Mission begins shortly..." ] call CBA_fnc_globalEvent;

                [CBA_fnc_globalEvent, [QGVAR(ReadyAction_onAllReady), _this], 5] call CBA_fnc_waitAndExecute;

            } else {

                private _notifyArray = [ ["Waiting for players:"] ];
                { _notifyArray pushBack [ name _x ] } forEach _players;
                _notifyArray pushBack true;
                [ QGVAR(ReadyAction_notify), _notifyArray ] call CBA_fnc_globalEvent;

            }
        }
    ] call CBA_fnc_addEventHandler;
};

if (!hasInterface) exitWith {};

// REGISTER NOTIFY EVENT
[ QGVAR(ReadyAction_notify), cba_fnc_notify ] call CBA_fnc_addEventHandler;
[ QGVAR(ReadyAction_onAllReady), _codeAllReady ] call CBA_fnc_addEventHandler;
[ QGVAR(ReadyAction_onJIPReady), _codeJIPReady ] call CBA_fnc_addEventHandler;


// ESTABLISH ACE ACTION
private _state = {
    params ["_target", "_player", "_actionParams"];
    _actionParams params [""];

    if (missionNamespace getVariable ["mission_start", false]) then {

        [QGVAR(ReadyAction_onJIPReady), _this] call CBA_fnc_localEvent;

    } else {
        // what happens when the mission hasnt started yet?
        
        _player setVariable ["mission_isReady", true, true];
        [["You have reported yourself as ready!"], ["Mission will start once everyone is ready"]] call cba_fnc_notify;
        
        ["mission_report_ready", _this] call CBA_fnc_serverEvent;
    };
};

private _cond = {
    params ["", "_player", ""];
    !(_player getVariable ["mission_isReady", false])
};

private _aceAction = [
    "ACE_MainActions"                               // * 0: Action name <STRING>
    ,"Report Ready for the mission to start"        //  * 1: Name of the action shown in the menu <STRING>
    ,""                                             //  * 2: Icon <STRING> "\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa"
    ,_state                                         //  * 3: Statement <CODE>
    ,_cond                                          //  * 4: Condition <CODE>
    ,{}                                             //  * 5: Insert children code <CODE> (Optional)
    ,[]                                             //  * 6: Action parameters <ANY> (Optional)
    ,[0,0,0]                                        //  * 7: Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
    ,5                                              //  * 8: Distance <NUMBER> (Optional)
    ,[false,false,false,false,true]                 //  * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
//    ,{}                                           //  * 10: Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction;

[
    _actionObject                           // * 0: Object the action should be assigned to <OBJECT>
    ,0                                      // * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ,[]                                     // * 2: Parent path of the new action <ARRAY> (Example: ["ACE_SelfActions", "ACE_Equipment"])
    ,_aceAction                             // * 3: Action <ARRAY>    
] call ace_interact_menu_fnc_addActionToObject;
