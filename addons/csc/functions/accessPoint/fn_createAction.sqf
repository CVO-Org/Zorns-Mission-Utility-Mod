#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Create the Ace Action
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

params ["_conditionCode", "_accessPoint"];

[
    QGVAR(AceAction)                                            // * 0: Action name <STRING>
    ,"Request Custom Supply Crates"                             //  * 1: Name of the action shown in the menu <STRING>
    ,"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\box_ca.paa"      //  * 2: Icon <STRING> "\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa"
    ,FUNC(openDialog)                                           //  * 3: Statement <CODE>
    ,_conditionCode                                             //  * 4: Condition <CODE>
    ,{}                                                         //  * 5: Insert children code <CODE> (Optional)
    ,_accessPoint                                               //  * 6: Action parameters <ANY> (Optional)
//    ,[0,0,0]                              //  * 7: Position (Position array, Position code or Selection Name) <ARRAY>, <CODE> or <STRING> (Optional)
//    ,20                                   //  * 8: Distance <NUMBER> (Optional)
//    ,[false,false,false,false,false]      //  * 9: Other parameters [showDisabled,enableInside,canCollapse,runOnHover,doNotCheckLOS] <ARRAY> (Optional)
//    ,{}                                   //  * 10: Modifier function <CODE> (Optional)
] call ace_interact_menu_fnc_createAction // return
