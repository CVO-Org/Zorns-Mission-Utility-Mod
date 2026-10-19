#include "../../script_component.hpp"

/*
* Author: Zorn
* "Enable all" / "Disable all" buttons of the "Disable Defaults" module lists.
*
* Arguments:
* 0: Button <CONTROL>
* 1: Enabled <BOOL>
*
* Return Value:
* None
*
* Example:
* [ _ctrlButton, true ] call mum_arsenal_fnc_disableList_setAll
*
* Public: No
*/

params [
    [ "_ctrlButton", controlNull, [controlNull] ],
    [ "_enabled",    true,        [true]        ]
];

{ _x cbSetChecked _enabled; } forEach ( ctrlParentControlsGroup _ctrlButton getVariable [ QGVAR(checkboxes), [] ] );

nil
