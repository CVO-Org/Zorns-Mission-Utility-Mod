#include "../../script_component.hpp"
/*
    Author: Mr. Zorn

    Description:
         Adds an Ace Interaction to a vehicle class so players can perform a fullheal with a progressbar (30s) on said vehicle.

     Dependency: ACE, CBA

    Parameter(s):
        0: <_target> can be one of:
                        <Object>                                             - Individual Object to add the Full Heal ACE Action
                        <String of classname>                               - Entire Class to add the Full Heal ACE Action

        1:  <_duration>    <Number in secounds>    <Optional> <Default: 30>    - Duration of the Healing Process
        2:     <_chance>     <Number 0..100>         <Optional> <Default: 5>        - Defines the chance for the Easeregg sound - 0 disables the Easteregg

    Returns:
        Returns False when <_target> is not defined.

    Examples:
        [ourMedicalVehicleObject]                call mum_common_fnc_fullHeal;    // Adds Full Health Check on a single object
        ["mod_vehicle_medical_classname", 30, 0] call mum_common_fnc_fullHeal;    // Adds Full Health Check on all objects of this classname and disables the easteregg
*/




params [
    ["_target",        "",     ["",objNull]],
    ["_duration",     30,     [0]            ],
    ["_chance",     1,         [0]            ]
];
if (_target isEqualTo "") exitWith {false};

// Here you define the code you want to execute, in this case, via a progress bar

 private _code = {

    params ["_target", "_player", "_parameter"];
    private _dur = _parameter # 0;
    private _egg = _parameter # 1;

    if (round random 100 < _egg) then {
        playSound3D ["zrn\mum\addons\common\data\medical_healsound.ogg", _target];
    };
    [
        _dur,                                  // Total Time (in game "time" seconds) <NUMBER>
        [],                                     // Arguments, passed to condition, fail and finish <ARRAY>
        {
            systemChat "Finish Start";
            [_player] call ace_medical_treatment_fnc_fullHealLocal;
            hint "You have been treated!";
        },                                      // On Finish:  Code called or STRING raised as event. <CODE, STRING>
        {hint "You have been interrupted!"},    // On Failure: Code called or STRING raised as event. <CODE, STRING>
        "Get Treated..."                       // (Optional) Localized Title <STRING>
    ] call ace_common_fnc_progressBar;
};

// Here we create the action which we later attach to something
private _action = [
    QGVAR(fullHeal),                                    // Action Name
    "Get full health Check",                        // Name for the ACE Interaction Menu
    "zrn\mum\addons\common\data\redCrystal.paa",        // custom Icon
    _code,                                            // Statement - the code you're executing
    {true},                                            // Condition
    {},                                                // Insert Children
    [_duration, _chance]                            // action parameters

] call ace_interact_menu_fnc_createAction;


switch (typeName _target) do {

    case "STRING": {
        [
            _target,                                        // Class the action should be assigned to
            0,                                                // Type of action, 0 for action, 1 for self-actionIDs
            ["ACE_MainActions"],                            // Parent path of the new action <Array>
            _action
        ] call ace_interact_menu_fnc_addActionToClass;        // Alternative: ace_interact_menu_fnc_addActionToObject
    };

    case "OBJECT": {
        [
            _target,                                        // Class the action should be assigned to
            0,                                                // Type of action, 0 for action, 1 for self-actionIDs
            ["ACE_MainActions"],                            // Parent path of the new action <Array>
            _action
        ] call ace_interact_menu_fnc_addActionToObject;        // Alternative: ace_interact_menu_fnc_addActionToObject
    };

};


// Here we define where we want this action that we created to be attached to



