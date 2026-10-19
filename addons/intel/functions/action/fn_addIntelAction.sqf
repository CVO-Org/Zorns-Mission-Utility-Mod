#include "../../script_component.hpp"

/*
* Author: Zorn, based on the intel action of Zeus Enhanced by mharis001
* Adds the ACE intel action to the given object.
* The action is hidden for players the intel has already been shared with.
*
* Arguments:
* 0: Intel object <OBJECT>
* 1: Intel ID <STRING>
*
* Return Value:
* None
*
* Example:
* [_object, "mum_intel_0"] call mum_intel_fnc_addIntelAction
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
    {
        params ["", "_player", "_args"];
        !([_player, _args select 0] call FUNC(hasBeenFoundByUnit))
    },
    {},
    [_id, _actionTitle, _actionSound, _actionDuration]
] call ace_interact_menu_fnc_createAction;

[_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
