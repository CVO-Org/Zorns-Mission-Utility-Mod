#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to take a Crate, put it to a certain position and parachute it.
* Most of it is from ACE Cargo Parachuting a Crate
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

params [
    "_object",
    "_vehicle",
    "_parameters"
];


(boundingBoxReal _vehicle) params ["_bb1", "_bb2"];
private _distBehind = ((_bb1 select 1) min (_bb2 select 1)) - 4; // 4 meters behind max bounding box
private _posBehindVehicleAGL = _vehicle modelToWorld [0, _distBehind, -2];


_object setPosASL (AGLToASL _posBehindVehicleAGL);
["ace_common_setVelocity", [_object, (velocity _vehicle) vectorAdd ((vectorNormalized (vectorDir _vehicle)) vectorMultiply -5)], _object] call CBA_fnc_targetEvent;


// Open parachute and IR light effect
[{
    params ["_object", "_params"];

    if (isNull _object || {getPos _object select 2 < 1}) exitWith {};

    private _parachute = createVehicle [_params getOrDefault ["parachute_class", "B_Parachute_02_F"], [0, 0, 0], [], 0, "CAN_COLLIDE"];

    // Prevent collision damage
    ["ace_common_fixCollision", _parachute] call CBA_fnc_localEvent;
    ["ace_common_fixCollision", _object, _object] call CBA_fnc_targetEvent;

    // Cannot use setPos on parachutes without them closing down
    _parachute attachTo [_object, [0, 0, 0]];
    detach _parachute;

    private _velocity = velocity _object;

    // Attach to the middle of the object
    (2 boundingBoxReal _object) params ["_bb1", "_bb2"];

    _object attachTo [_parachute, [0, 0, ((_bb2 select 2) - (_bb1 select 2)) / 2]];
    _parachute setVelocity _velocity;

    // Handle Chemlight on Box
    private _class_chemlight = _params getOrDefault ["parachute_class_chemlight", "Chemlight_yellow"];
    if (! isClass (configFile >> "CfgVehicles" >> _class_chemlight) && { ! isClass (configFile >> "CfgAmmo" >> _class_chemlight) } ) then { _class_chemlight = ""; };
    if (_class_chemlight isNotEqualTo "") then {
        private _light = createVehicle [_class_chemlight, [0, 0, 0]];
        _light attachTo [_object, [0, 0, 0]];
    };

    // Handle Strobe Above Parachute
    private _class_strobe = _params getOrDefault ["parachute_class_strobe", "ACE_IR_Strobe_Effect"];
    if (! isClass (configFile >> "CfgVehicles" >> _class_strobe) && { ! isClass (configFile >> "CfgAmmo" >> _class_strobe) } ) then { _class_strobe = ""; };
    if (_class_strobe isNotEqualTo "") then {
        private _strobe = createVehicle [_class_strobe, [0,0,10], [], 0, "CAN_COLLIDE"];
        _strobe attachTo [attachedTo _object, [0,0,32]];
        [
            { getPos (_this#0) select 2 < 1 },
            { deleteVehicle (_this#1) },
            [_object, _strobe]
        ] call CBA_fnc_waitUntilAndExecute;
    };
}, [_object, _parameters], 0.7] call CBA_fnc_waitAndExecute;


// Handle Smoke once Landed
private _class_smoke = _parameters getOrDefault ["parachute_class_smoke","SmokeShellYellow"];

if (! isClass (configFile >> "CfgVehicles" >> _class_smoke) && { ! isClass (configFile >> "CfgAmmo" >> _class_smoke) } ) then { _class_smoke = ""; };

[
    {
        params ["_args", "_pfhID"];
        _args params [ "_object", ["_class_smoke", "", [""]] ];

        if (isNull _object) exitWith { _pfhID call CBA_fnc_removePerFrameHandler; };

        if (getPos _object select 2 < 1) exitWith {
            _pfhID call CBA_fnc_removePerFrameHandler;
            
            if (_class_smoke isNotEqualTo "") then {
                private _smoke = createVehicle [_class_smoke, [0, 0, 0]];
                _smoke attachTo [_object, [0, 0, 0]];
            };
        };
    },
    1,
    [
        _object,
        _class_smoke
    ]
] call CBA_fnc_addPerFrameHandler;
