#include "..\script_component.hpp"

/*
* Author: Zorn
* Loop Function to regulary check all groups for valid teamleaders.
*
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

private _allGroups = [];
{ _allGroups pushBackUnique group _x } forEach allPlayers;

_allGroups = _allGroups select { !(_x isNil QGVAR(TeamLeaders)) };

private _recursive = {
    params [ "_recursive", "_allGroups"];
    if (_allGroups isEqualTo []) exitWith {};
    _allGroups deleteAt 0 call FUNC(validateTeamleaders);
    [_recursive, [_recursive, _allGroups]] call CBA_fnc_execNextFrame;
};
[_recursive, [_recursive, _allGroups]] call CBA_fnc_execNextFrame;
