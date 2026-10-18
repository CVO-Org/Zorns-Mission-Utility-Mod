#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the full cargo inventory (items, magazines, weapons, backpacks) of an object.
*
* Arguments:
* 0: _object - Object <OBJECT> (default: objNull)
* 1: _seperateBackpacks - Return items and backpacks separately <BOOL> (default: false)
*
* Return Value:
* [[className, amount], ...] or [items, backpacks] when separated <ARRAY>
*
* Example:
* [cursorObject, true] call mum_csc_fnc_getVehicleInventory
*
* Public: No
*/

params [
    [ "_object",            objNull, [objNull] ],
    [ "_seperateBackpacks", false,   [true]    ]
];

if (!alive  _object ) exitWith { [] };

private _items = [];
private _backpacks = [];

{
    _x params ["_classes", "_amounts"];
    { _items pushBack [_x, _amounts#_forEachIndex]; } forEach _classes;

} forEach [
    getMagazineCargo _object,
    getItemCargo _object,
    getWeaponCargo _object
];

{
    _x params ["_classes", "_amounts"];
    { _backpacks pushBack [_x, _amounts#_forEachIndex]; } forEach _classes;
} forEach [ getBackpackCargo _object ];

switch (_seperateBackpacks) do {
    case true:  { [_items,  _backpacks] };
    case false: {  _items + _backpacks  };
} // return
