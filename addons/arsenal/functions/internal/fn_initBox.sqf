#include "../../script_component.hpp"

/*
* Author: Zorn
* Adds the CVO Arsenal Interaction to an Object. Effect is local only. Use CBA Global Event QGVAR(EH_initBox) instead.
*
* Arguments:
*   0 - <OBJECT or ARRAY of OBJECTS> - Object(s) that shall function as an CVO Arsenal
*
* Return Value:
* None
*
* Example:
* [box] call mum_arsenal_fnc_addAction
* [[box1,box2,box3]] call mum_arsenal_fnc_addAction
*
* Public: Yes
*/

if !(hasInterface) exitWith {};

private _objects = switch (typeName _this) do {
    case "OBJECT": { [_this] };
    case "ARRAY": { _this };
    default { [] };
};

_objects = flatten _objects select { _x isEqualType objNull }  select { !isNull _x };

if (_objects isEqualTo []) exitWith { ZRN_LOG_MSG(Failed: No Objects Provided); };

private _action = [
    QGVAR(open)                        // ActionName
    ,"Open the Arsenal"                // Name of the Action shown in the menu
    ,"\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa"        // Icon
    ,FUNC(open)                        // Statement (The actual Code)
    ,{true}                            // condition
    ,{}                                // child
    ,[]                                // params
    ,[0,0,0]                        // offset
    ,3                                // range
    ,[false,false,false,false,true]    // line of sight check disabled
] call ace_interact_menu_fnc_createAction;

{

    systemChat "Adding Arsenal"; // TODO

    [
        _x,
        0,
        ["ACE_MainActions"],
        _action
    ] call ace_interact_menu_fnc_addActionToObject;

} forEach _objects;

nil
