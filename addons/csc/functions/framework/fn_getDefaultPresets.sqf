#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
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
    [ "_mode", "DEFAULT", [""] ],
    [ "_type", "CRATES", [""] ]
];

private _desiredScope = switch (_mode) do {
    case "DEFAULT": { 2 };
    case "ZEUS": { 1 };
    case "DEBUG": { 0 };
    default { 2 };
};

private _desiredType = switch (_type) do {
    case "CRATES":         { GVAR(crates) };
    case "DESTINATIONS":   { GVAR(destinations) };
    case "DELIVERY_MODES": { GVAR(delivery_modes) };
    default { false };
};

if (_desiredType isEqualTo false) exitWith {  };

private _return = [];
{
    // compare crate scope with desired scope
    if ( getNumber ((_desiredType get _x) >> "scope") >= _desiredScope ) then { _return pushBack _x; };
} forEach (keys _desiredType);

_return
