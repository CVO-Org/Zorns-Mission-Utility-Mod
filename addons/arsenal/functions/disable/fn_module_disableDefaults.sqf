#include "../../script_component.hpp"

/*
* Author: Zorn
* Module function: sends the entries disabled in the "Disable Defaults" module to all clients, including JIP.
* Multiple modules add up.
*
* Arguments:
* 0: _logic - Module logic <OBJECT>
* 1: _units - Synced objects <ARRAY>
* 2: _activated - Module activated <BOOL>
*
* Return Value:
* None
*
* Example:
* Called by the module
*
* Public: No
*/

params [
    [ "_logic", objNull, [objNull] ]
];

if ( !isServer || { isNull _logic } ) exitWith {};

private _kits       = parseSimpleArray ( _logic getVariable [ QGVAR(disabledKits),       "[]" ] );
private _autoRoles  = parseSimpleArray ( _logic getVariable [ QGVAR(disabledAutoRoles),  "[]" ] );
private _autoTraits = parseSimpleArray ( _logic getVariable [ QGVAR(disabledAutoTraits), "[]" ] );

[
    QGVAR(EH_disableDefaults),
    [ _kits, _autoRoles, _autoTraits ],
    [ QGVAR(EH_disableDefaults), netId _logic ] joinString "_"
] call CBA_fnc_globalEventJIP;

nil
