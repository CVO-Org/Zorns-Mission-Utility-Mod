#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to point one object directly (vectorDirAndUp) at another object.
* Intended for stuff like Lightsources.
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
    ["_object", nil, [objNull]],
    ["_target", nil, [objNull, []], [3]]
];


// get positions in ASL
private _posASL_target = switch (typeName _target) do {
    case "ARRAY": { _target };
    case "OBJECT": { getPosASL _target };
    default { nil };
};

if (isNil "_object" || { isNil "_target" }) exitWith {};

// get positions in ASL
private _posASL_object = getPosASL _object;

// direction vector (normalized)
private _dir = _posASL_object vectorFromTo _posASL_target;

// define "up" vector (so the object is properly oriented in 3D)
private _up = [0,0,1]; // world up reference
_up = _up vectorCrossProduct _dir; // perpendicular vector
_up = _dir vectorCrossProduct _up; // ensure correct orientation
_up = vectorNormalized _up;

// apply to object
_object setVectorDirAndUp [_dir, _up];
