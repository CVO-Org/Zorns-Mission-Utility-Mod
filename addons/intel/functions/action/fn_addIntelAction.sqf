#include "../../script_component.hpp"

/*
 * Author: mharis001
 * Add an intel action to the given object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Share With (0 - Side, 1 - Group, 2 - Nobody) <NUMBER>
 * 2: Delete On Completion <BOOL>
 * 3: Action Type (0 - Hold Action, 1 - ACE Interaction Menu) <NUMBER>
 * 4: Action Text <STRING>
 * 5: Action Sounds <ARRAY>
 * 6: Action Duration <NUMBER>
 * 7: Intel Title <STRING>
 * 8: Intel Text <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, _id] call zen_modules_fnc_addIntelAction
 *
 * Public: No
 */


params ["_object", "_id"];

private _intelData = missionNamespace getVariable _id;

private _actionTitle    = _intelData getVariable "actionTitle";
private _actionSound    = _intelData getVariable "actionSound";
private _actionDuration = _intelData getVariable "actionDuration";

private _action = [
    QGVAR(intelAction),
    _actionTitle,
    "\a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa",
    FUNC(action_statement),
    {true},
    {},
    [_id, _actionTitle, _actionSound, _actionDuration]
] call ace_interact_menu_fnc_createAction;

[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
