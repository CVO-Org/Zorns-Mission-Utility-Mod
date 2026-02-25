#include "../../script_component.hpp"

/*
* Author: Zorn
* DELIVERY Function - Will spawn a drone, then fly
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


params [ "_request", "_parameters" ];

ZRN_LOG_1(_this);

private _targetPos = _request getOrDefault ["destination", [0,0,0]];
private _startPos = _parameters getOrDefault ["pos_start", [0,0,0]];


// Create Aircraft
private _drone = if (_startPos#2 isEqualTo 0) then {
    createVehicle [(_parameters getOrDefault ["drone_class", "B_UAV_06_F"]), [0,0,0]];
} else {
    createVehicle [(_parameters getOrDefault ["drone_class", "B_UAV_06_F"]), [0,0,0], [], 0, "FLY"];
};

private _alt_journey = _parameters getOrDefault ["alt_journey", 50];

_drone flyInHeightASL [2,2,2];
_drone flyInHeight [_alt_journey, true];

private _side = switch (_parameters getOrDefault ["drone_side", "CIV"]) do {
    case "WEST": { west };
    case "EAST": { east };
    case "GUER": { independent };
    case "CIV":  { civilian };
    default { civilian };
};

// Create Crew
private _grp = _side createVehicleCrew _drone;
_grp deleteGroupWhenEmpty true;

// Add vic to curator
{ _x addCuratorEditableObjects [[_drone], true] } forEach allCurators;

// Protect Drone
if (_parameters getOrDefault ["drone_protected", true]) then {  { _x allowDamage false; } forEach [_drone] + crew _drone; };

//  Manage ACE HC Blacklist
[[_drone] + units _grp, true] call ace_headless_fnc_blacklist;

// Attach crates
private _crates = _request get "crates";

private _totalOffset = 0 boundingBoxReal _drone select 0 select 2; // offset from center of drone to bottom

{
    private _crate = _x;
    _crate disableCollisionWith _drone;

    private _bb = 0 boundingBoxReal _crate;
    private _bb_1 = (_bb#0#2 * -1) max (_bb#0#2);
    private _bb_2 = (_bb#1#2 * -1) max (_bb#1#2);
    private _height = _bb_1 + _bb_2;

    _totalOffset = _totalOffset - _height;
    _crate attachTo [_drone, [ 0, 0, _totalOffset ]];
} forEach _crates;

_startPos set [2, (_startPos select 2) + -1 * _totalOffset + 1 ];

// Place and Rotate Plane
_drone setPos _startPos;
private _dir = (_startPos getDir _targetPos);
_drone setDir _dir;

// Handle waypoints

// Pre-Target Waypoint
private _preWP = _grp addWaypoint [vectorLinearConversion [0, 1, 0.8, _startPos, _targetPos, true], 25];
_preWP setWaypointStatements [
    "true",
    format ["vehicle this flyInHeight [ %1, true];", _parameters getOrDefault ["alt_final", 35] ]
];

// Target Waypoint

private _biggest = selectMax (_crates apply { sizeOf typeOf _x });
private _targetPos_empty = [];
private _i = 0;
while { _targetPos_empty isEqualTo [] } do {
    _i = _i + 1;
    _targetPos_empty = _targetPos findEmptyPosition [_biggest, _biggest * _i];
};

private _tgtWP = _grp addWaypoint [_targetPos_empty, 0];

_tgtWP setWaypointTimeout [2, 3.5, 5];


private _alt_drop = 0 max ( (_totalOffset * -1 max _totalOffset) + (_parameters getOrDefault ["alt_drop", 9]) ) min 9.9;
_tgtWP setWaypointStatements [
    "true",
    format ["private _drone = vehicle this; _drone flyInHeight [ %1, true]; _drone setVariable [""decending"", true];", _alt_drop ]
];

// Return Waypoint
private _endWP_Pos = _parameters getOrDefault ["pos_end", [0,0,0]];
_endWP_Pos = switch true do {
    case (_endWP_Pos isEqualTo "RETURN"):   { _startPos };
    case (_endWP_Pos isEqualTo "CONTINUE"): { _targetPos getPos [10000, _dir] };
    case (_endWP_Pos isEqualType []):       { _endWP_Pos };
    default { [0,0,0] };
};

// Handles the Detaching of the cargo
[
    {
        !(_this#0 isNil "decending")
    },
    {
        // Wait until Drone is below a certain ATL
        private _statement = {
            params ["_drone"];
            [ CBA_fnc_globalSay3D, [_drone, "beep",          100, true, false, true],  7.0] call CBA_fnc_waitAndExecute;
            [ CBA_fnc_globalSay3D, [_drone, "beep",          100, true, false, true],  8.0] call CBA_fnc_waitAndExecute;
            [ CBA_fnc_globalSay3D, [_drone, "beep",          100, true, false, true],  9.0] call CBA_fnc_waitAndExecute;
            [ CBA_fnc_globalSay3D, [_drone, "beep",          100, true, false, true], 10.0] call CBA_fnc_waitAndExecute;
            [ CBA_fnc_globalSay3D, [_drone, "beep",          100, true, false, true], 11.0] call CBA_fnc_waitAndExecute;
            [ CBA_fnc_globalSay3D, [_drone, "beep",          100, true, false, true], 12.1] call CBA_fnc_waitAndExecute;
            [ CBA_fnc_globalSay3D, [_drone, "beep",          100, true, false, true], 12.2] call CBA_fnc_waitAndExecute;
            [ CBA_fnc_globalSay3D, [_drone, "beep",          100, true, false, true], 12.3] call CBA_fnc_waitAndExecute;
            [ CBA_fnc_globalSay3D, [_drone, "mum_ula_broke", 100, true, true,  true], 12.5] call CBA_fnc_waitAndExecute;
            [ { { detach _x } forEach attachedObjects _this }, _drone, 12.55] call CBA_fnc_waitAndExecute;
            [ { (_this#0) flyInHeight (_this#3); }, _this, 13.0 ] call CBA_fnc_waitAndExecute;
            [
                {
                    (_this#1) addWaypoint [(_this#2), 100] setWaypointStatements ["true", "{deleteVehicle _x} forEach ([vehicle this] + thisList)"];
                },
                _this,
                15.0
            ] call CBA_fnc_waitAndExecute;
        };
        private _condition = { getPos (_this#0) select 2 < 12 };
        [_condition, _statement, _this, 5,_statement] call CBA_fnc_waitUntilAndExecute;
    },
    [_drone, _grp, _endWP_Pos, _alt_journey]
] call CBA_fnc_waitUntilAndExecute;


// Declare the mode as isBusy if not requested by Zeus
if !(_request getOrDefault ["isZeus", false]) exitWith {};
private _isBusyVarName = format ["%1_isBusy", _request get "delivery_mode"];

missionNamespace setVariable [_isBusyVarName, true, true];

// Revert isBusy once the aircraft is deleted
_drone setVariable [QGVAR(isBusyVarName), _isBusyVarName, true];
_drone addEventHandler ["Deleted", {
    params ["_drone"];
    private _isBusyVarName = _drone getVariable QGVAR(isBusyVarName);
    missionNamespace setVariable [_isBusyVarName, nil, true];
}];
