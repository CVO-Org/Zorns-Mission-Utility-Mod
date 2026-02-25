#include "../../script_component.hpp"

/*
* Author: Zorn
*
* Function to Enable/Disable AI features of all units inside a specific layer.
* Details to be found here
* https://community.bistudio.com/wiki/disableAI
*
* - Only Executable on Server: getMissionLayerEntities needs to be executed on the server.
* - Only applies to alive units, ignores dead units and other objects.
* - Recursive function: adjusts 1 unit per frame.
* - Applies setting where unit is currently local.
*
*
* Arguments:
*     0:     _layerName        <STRING>             Name of the Editor Layer
*    1:    _mode            <BOOL>                Controls mode: true: Enable - false: Disable
*    2:    _feature        <STRING or ARRAY>    What ai feature to toggle. see link above for more details.
*
* Return Value:
* None
*
* Note: Must be executed on the server!
*
* Example:
* ["ambush1", true, "all"] call mum_common_fnc_toggleLayerAI; // enable units of the layer
* ["ambush1", false, "all"] call mum_common_fnc_toggleLayerAI; // disables units of the layer
* ["ambush1", false, ["path", "fireweapon"]] call mum_common_fnc_toggleLayerAI; // disables pathing and firingweapon
*
* Public: yes
*/

if !(isServer) exitWith {};

params [
    [ "_layerName",    "",     [""]    ],
    [ "_mode",         true,     [true]  ],
    [ "_features",  "all",     ["",[]] ]
];


if (_features isEqualType "") then { _features = [_features] };

// Get Units from Layer
private _units = (getMissionLayerEntities _layerName) select 0 select { _x isKindOf "CAManBase" } select { alive _x };


// Validate Features
private _isValid = { toLower _x in ["all", "aimingerror", "anim", "autocombat", "autotarget", "checkvisible", "cover", "fsm", "lights", "minedetection", "move", "nvg", "path", "radioprotocol", "suppression", "target", "teamswitch", "weaponaim", "fireweapon"] };
_features = _features select _isValid apply { toUpper _x };


// Filter Units by Owner
private _catalog = createHashMap;
{
    private _unit = _x;
    private _owner = owner _unit;

    private _array = _catalog getOrDefault [_owner, []];
    _array pushBack _unit;
    _catalog set [_owner, _array];
} forEach _units;


// Recursive Function:
// Send Filtered Units to Owner, one owner per frame
private _recursiveCodeCatalog = {
    params ["_catalog", "_mode", "_features", "_recursiveCodeCatalog"];

    private _keys = keys _catalog call BIS_fnc_sortNum;
    private _units = _catalog deleteAt _keys#0;

    // diag_log format ['[CVO](debug)(fn_toggleLayerAI) Sending Package: %1 to owner: %2', [count _units, _mode, _features], owner (_units#0)];
    [QGVAR(eh_toggleAIfeature), [_units, _mode, _features], _units#0] call CBA_fnc_targetEvent;

    if (count _catalog == 0) exitWith {};

    [_recursiveCodeCatalog, [_catalog, _mode, _features, _recursiveCodeCatalog]] call CBA_fnc_execNextFrame;
};

[_catalog, _mode, _features, _recursiveCodeCatalog] call _recursiveCodeCatalog;
