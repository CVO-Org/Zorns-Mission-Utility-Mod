#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to return the full item inventory of an vehicle.
*
* Arguments:
*
* Return Value:
* Nested Array  of Items as [className, amount] pair including backpacks
*
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
    [ "_object",         objNull, [objNull] ],
    [ "_seperateOutput", false,   [true]    ]
];

if (!alive  _object ) exitWith { [] };

private _items = [];

{
    _x params ["_classes", "_amounts"];
    { _items pushBack [_x, _amounts#_forEachIndex]; } forEach _classes;

} forEach [
    getMagazineCargo _object,
    getItemCargo _object,
    getWeaponCargo _object
];

private _backpacks = everyBackpack _object apply { typeOf _x } call EFUNC(common,countOccurrences);

switch (_SeperateOutput) do {
    case true:  { [_items,  _backpacks] };
    case false: {  _items + _backpacks  };
} // return
