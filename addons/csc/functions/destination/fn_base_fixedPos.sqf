#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to return a fixed position from the cfg parameters
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

params [ "_request", "_parameters" ];

diag_log format ['[CVO](debug)(fn_base_relativeTo) _request: %1', _request];
diag_log format ['[CVO](debug)(fn_base_relativeTo) _parameters: %1', _parameters];

private _position = _parameters getOrDefault ["position", [0,0,0]];

private _radius = _parameters getOrDefault ["radius", 0];

if (_radius isNotEqualTo 0) then { _position = _position getPos [ random _radius, random 360 ]; };

_position
