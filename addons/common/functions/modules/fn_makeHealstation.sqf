#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to turn objects locally into a heal station
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

params [ "_objects", ["_dur", 30, [0] ], ["_chance", 1, [0] ] ];


private _action = [
    QGVAR(fullHeal),                                // Action Name
    "Get full health Check",                        // Name for the ACE Interaction Menu
    QPATHTOF(data\redCrystal.paa),                  // custom Icon
     {
        params ["_target", "_player", "_params"];
        _params params [ "_dur", "_chance" ];

        if (round random 100 < _chance) then { playSound3D [QPATHTOF(data\medical_healsound.ogg), _target]; };
        [
            _dur,                                   // Total Time (in game "time" seconds) <NUMBER>
            [],                                     // Arguments, passed to condition, fail and finish <ARRAY>
            {
                systemChat "Finish Start";
                [_player] call ace_medical_treatment_fnc_fullHealLocal;
                hint "You have been treated!";
            },                                      // On Finish:  Code called or STRING raised as event. <CODE, STRING>
            {hint "You have been interrupted!"},    // On Failure: Code called or STRING raised as event. <CODE, STRING>
            "Get Treated..."                        // (Optional) Localized Title <STRING>
        ] call ace_common_fnc_progressBar;
    },                                              // Statement - the code you're executing
    {true},                                         // Condition
    {},                                             // Insert Children
    [_dur,_chance]                                  // action parameters

] call ace_interact_menu_fnc_createAction;

{ [ _x, 0, ["ACE_MainActions"],  _action ] call ace_interact_menu_fnc_addActionToObject; } forEach _objects;
