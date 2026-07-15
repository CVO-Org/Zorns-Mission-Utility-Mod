#include "../../script_component.hpp"

/*
* Author: Zorn
* Children Function for AddAction
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


params ["_target", "_player", "_actionParams"];
_actionParams params [["_networkName", nil, [""]]];

private _actions = [];
if (isNil "_networkName") then { _networkName = _target getVariable [QGVAR(NetworkName), nil]; };
if (isNil "_networkName") exitWith {};

private _network = [_networkName] call FUNC(network);

private _destinations = _network get "destinations";



{
    private _destination = _x;

    private _params = [_destination];
    
    private _aceAction = [
        [_networkName,_forEachIndex] joinString "_" // * 0: Action name <STRING>
        ,_destination call FUNC(getName)            //  * 1: Name of the action shown in the menu <STRING>
        ,""                                         //  * 2: Icon <STRING> "\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa"
        ,FUNC(teleport)                             //  * 3: Statement <CODE>
        ,{true}                                     //  * 4: Condition <CODE>
        ,{}                                         //  * 5: Insert children code <CODE> (Optional)
        ,_params                                    //  * 6: Action parameters <ANY> (Optional)
    ] call ace_interact_menu_fnc_createAction;
    

    _actions pushBack [_aceAction, [], _target];

} forEach _destinations;

_actions
