#include "../../script_component.hpp"

/*
* Author: Zorn
* Opens the MUM Arsenal for the local player.
* On first use, initialises the config kits and autoRoles and creates a hidden local arsenal box (mum_arsenal_local_box).
* On later uses, the existing box is emptied. The box is then refilled with the kits available to the player.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call mum_arsenal_fnc_open
*
* Public: No
*/

if (isNull (missionNamespace getVariable [QGVAR(local_box), objNull])) then {

    ZRN_LOG_MSG(Creating Local Box);

    // Initialises Base Kits from Config
    [] call FUNC(handleConfigKits);
    [] call FUNC(handleConfigAutoRoles);

    // Creates Virtual Arsenal box for the player locally if none has been existing before
    GVAR(local_box) = createVehicleLocal ["B_supplyCrate_F", [0,0,0], [], 0, "CAN_COLLIDE"];
    private _localBox = GVAR(local_box);

    player setVariable [QGVAR(local_box), _localBox, false];

    [_localBox, false]  call ace_dragging_fnc_setDraggable;                 // Disables Dragging
    [_localBox, false]  call ace_dragging_fnc_setCarryable;                 // Disables Carrying
    [_localBox, -1]     call ace_cargo_fnc_setSize;                         // Disables Ace Cargo Loading
    _localBox setVariable ["ace_cargo_noRename", true];                     // Disables Ace Cargo Renaming

    hideObject _localBox;                                                   // Hides the Object

    clearBackpackCargo _localBox;                                           // Empties the ArsenalBox
    clearMagazineCargo _localBox;
    clearWeaponCargo _localBox;
    clearItemCargo _localBox;

    _localBox enableSimulation false;                                       // Disables Simulation

    [_localBox, false, false] call ace_arsenal_fnc_initBox;

} else {

    // Removes current content
    private _localBox = GVAR(local_box);
    [_localBox, true, false] call ace_arsenal_fnc_removeVirtualItems;
    [_localBox, false, false] call ace_arsenal_fnc_initBox;
};


// Opens the Arsenal remotely for the players
[
    GVAR(local_box),
    ACE_player,
    false
] call ace_arsenal_fnc_openBox;

GVAR(local_box) call FUNC(update);

nil
