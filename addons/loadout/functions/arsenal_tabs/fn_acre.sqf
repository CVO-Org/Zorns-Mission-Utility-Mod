#include "../../script_component.hpp"

/*
* Author: Andx, Diwako, Zorn
* Function to add an ACE Arsenal TAB for ACRE when loaded
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

if (! isClass (configFile >> "CfgPatches" >> "acre_main") ) exitWith {};

/*
// Diwako Version
private _radios = [];
{
    _radios pushBack _x;
    for "_i" from 1 to 512 do {
        _radios pushBack (format ["%1_ID_%2", _x, _i]);
    };
} forEach [
    "ACRE_BF888S",
    "ACRE_PRC117F",
    "ACRE_PRC148",
    "ACRE_PRC152",
    "ACRE_PRC343",
    "ACRE_PRC77",
    "ACRE_SEM52SL",
    "ACRE_SEM70"
];
[
    _radios,
    "Radios",
    "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Radio_ca.paa"
] call ace_arsenal_fnc_addRightPanelButton;
*/

// andx version
private _addons = ["acre_sys_bf888s", "acre_sys_gsa", "acre_sys_prc117f", "acre_sys_prc148", "acre_sys_prc152", "acre_sys_prc343", "acre_sys_prc77", "acre_sys_sem52sl", "acre_sys_sem70"];
private _all = [];
{
    private _classes = [_x] call FUNC(getAllItems);
    _all append _classes;
} forEach _addons;

[
    _all,
    "ACRE",
    "a3\modules_f_curator\data\portraitradio_ca.paa"
] call ace_arsenal_fnc_addRightPanelButton;

ZRN_LOG_MSG(ACRE Tab Applied);
