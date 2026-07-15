#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to open the Deploy Dialog and attach neccessary Data
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

params ["_target", "_player", "_params"];
_params params  ["_networkName"];

private _display = createDialog [QGVAR(dialog), true];

private _network = [_networkName] call FUNC(network);

_display setVariable [QGVAR(network), _network];
_display setVariable [QGVAR(departure), _target];
