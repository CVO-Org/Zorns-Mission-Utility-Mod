#include "..\script_component.hpp"


if (!hasInterface) exitWith {};

params ["_obj", "_layerName", "_distance", "_time"];

diag_log "[MUM](debug)(fn_addAction) INIT";

if (isNull _obj) exitWith {
    diag_log format ['[MUM](debug)(fn_addAction) Failed: _obj: %1',_obj];
};

diag_log format ['[MUM](debug)(fn_addAction) _this: %1', _this];

private _aceAction = [
    ["MUM","ula",_layerName] joinString "_",                        // * 0: Action name <STRING>
    format ["Start Building %1", _layerName],                       //  * 1: Name of the action shown in the menu <STRING>
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",       //  * 2: Icon <STRING> "\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa"
    FUNC(action_statement),                                   //  * 3: Statement <CODE>
    FUNC(action_condition),                                   //  * 4: Condition <CODE>
    {},                                                             //  * 5: Insert children code <CODE> (Optional)
    [_layerName, _distance, _time]                                  //  * 6: Action parameters <ANY> (Optional)
] call ace_interact_menu_fnc_createAction;

[
    _obj,                              // * 0: Object the action should be assigned to <OBJECT>
    0,                                 // * 1: Type of action, 0 for actions, 1 for self-actions <NUMBER>
    ["ACE_MainActions"],            // * 2: Parent path of the new action <ARRAY> (Example: `["ACE_SelfActions", "ACE_Equipment"]`)
    _aceAction                         // * 3: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToObject;

diag_log "[MUM](debug)(fn_addAction) DONE";
