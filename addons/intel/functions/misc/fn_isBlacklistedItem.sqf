#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to check if a linked Item is blacklisted. For Example, if the linked object is an ACE Intel Item.
*
* Arguments:
* 0: _target <STRING> or <OBJECT> or <CONFIG>
*
* Return Value:
* isBlacklisted <BOOL>
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
    ["_target", objNull, ["", objNull, configNull] ]
];

private _cfg = switch (typeName _target) do {
    case "OBJECT": { configOf _target };
    case "STRING": { _target call CBA_fnc_getItemConfig };
    case "CONFIG": { _target };
    default { configNull };
};

// Return: Is Blacklisted?
switch (true) do {
    // Check if item is ACE Intel Object
    case ( getText (_cfg >> "ace_intelitems_magazine") isNotEqualTo "" ): {
        ERROR_1("MUM Intel cannot be Ace Intel ITEM: %1",configName _cfg);
        true
    };

    // Check if is Weaponsholder / inventory Item
    case ( configName _cfg isKindOf "WeaponHolder" ): {
        ERROR_1("MUM Intel cannot be Inventory Item: %1",configName _cfg);
        true
    };

    default { false };
}
