#include "../../script_component.hpp"

/*
Script Runs when the players open the arsenal.
1.
If the player opens the arsenal for the first time,
it creates the cvo_arsenal_local_box box and updates the content of said arsenal.
If the player opened it before and the cvo_arsenal_local_box exists already, it will 
*/

if (isNull GVAR(local_box)) then { GVAR(local_box) = nil;};

if (isNil QGVAR(local_box)) then {

    ZRN_LOG_MSG(Creating Local Box);

    // Initialises Base Kits from Config
    [] call FUNC(handleConfigKits);

    // Creates Virtual Arsenal box for the player locally if none has been existing before
    GVAR(local_box) = createVehicleLocal ["B_supplyCrate_F", [0,0,0], [], 0, "CAN_COLLIDE"];
    private _localBox = GVAR(local_box);

    player setVariable [QGVAR(local_box), _localBox, false];

    [_localBox, false]                 call ace_dragging_fnc_setDraggable;                // Disables Dragging
    [_localBox, false]                 call ace_dragging_fnc_setCarryable;                // Disables Carrying
    [_localBox, -1]                     call ace_cargo_fnc_setSize;                    // Disables Ace Cargo Loading
    _localBox setVariable ["ace_cargo_noRename", true];                                // Disables Ace Cargo Renaming

    hideObject _localBox;                                                            // Hides the Object

    clearBackpackCargo _localBox;                                                    // Empties the ArsenalBox
    clearMagazineCargo _localBox;
    clearWeaponCargo _localBox;
    clearItemCargo _localBox;

    _localBox enableSimulation false;                                                // Disables Simulation

    [_localBox, false, false] call ace_arsenal_fnc_initBox;

} else {

    // Removes current content    
    [GVAR(local_box), false, false] call ace_arsenal_fnc_initBox;

};


// Opens the Arsenal remotely for the players
[
    GVAR(local_box),
    ACE_player,
    false
] call ace_arsenal_fnc_openBox;

GVAR(local_box) call FUNC(update);

nil
