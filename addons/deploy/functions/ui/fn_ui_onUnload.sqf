#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to run on UI's Unload.
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

params ["_display", "_exitCode"];


private _handle = _display getVariable [QGVAR(pfh_handle), nil];
if !(isNil "_handle") then { _handle call CBA_fnc_removePerFrameHandler; };

private _drawIcon_handle = _display getVariable [QGVAR(drawIcon_handle), nil];
if !(isNil "_drawIcon_handle") then { _drawIcon_handle call CBA_fnc_removePerFrameHandler; };


// Handle Teleportation
if (_exitCode isEqualTo 1) then {
    private _index = _display getVariable [QGVAR(curSel_index), -1];
    private _network = _display getVariable QGVAR(network);

    if (isNil "_network") exitWith {};
    
    private _destinations = _network get "destinations";
    private _destination = _destinations select _index;

    [nil, ACE_player, [_destination]] call FUNC(teleport);
};
