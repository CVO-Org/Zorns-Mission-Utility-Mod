#include "../../script_component.hpp"

/*
* Author: Zorn
* 3DEN attribute save for the "Disable Defaults" module lists.
*
* Arguments:
* 0: Attribute controls group <CONTROL>
*
* Return Value:
* Disabled entries as stringified array <STRING>
*
* Example:
* [ _ctrlGroup ] call mum_arsenal_fnc_disableList_save
*
* Public: No
*/

params [
    [ "_ctrlGroup", controlNull, [controlNull] ]
];

private _disabled = + ( _ctrlGroup getVariable [ QGVAR(unknown), [] ] );

{
    if !( cbChecked _x ) then { _disabled pushBack ( _x getVariable QGVAR(name) ); };
} forEach ( _ctrlGroup getVariable [ QGVAR(checkboxes), [] ] );

str _disabled
