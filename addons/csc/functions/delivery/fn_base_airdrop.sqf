#include "../../script_component.hpp"

/*
* Author: Zorn
* DELIVERY - Function to handle the
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

// Starting Position
private _startPos = _parameters getOrDefault ["pos_start", [0,0,1000]];
_startPos set [2, 250 max (ATLToASL _startPos # 2)];

// Target Position
private _targetPos = _request getOrDefault ["destination", [0,0,0]];

// Create Aircraft
private _aircraft = createVehicle [(_parameters getOrDefault ["airframe_class", "C_Heli_Light_01_civil_F"]), [0,0,0], [], 0, "FLY"];

_aircraft flyInHeight [_parameters getOrDefault ["airdrop_alt",150], _parameters getOrDefault ["airdrop_alt_forced", true]];
_aircraft flyInHeightASL (_parameters getOrDefault ["airdrop_flyInHeightASL", [50,50,50]]);

[{ _this setVelocityModelSpace [0, 66, 66]; }, _aircraft] call CBA_fnc_execNextFrame;


private _side = switch (_parameters getOrDefault ["airframe_side", "CIV"]) do {
    case "WEST": { west };
    case "EAST": { east };
    case "GUER": { independent };
    case "CIV":  { civilian };
    default { civilian };
};

private _grp = _side createVehicleCrew _aircraft;
_grp addVehicle _aircraft;
_grp setCombatBehaviour "CARELESS";
_grp deleteGroupWhenEmpty true;

// Add vic to curator
{ _x addCuratorEditableObjects [[_aircraft], true] } forEach allCurators;

//  Manage ACE HC Blacklist
[[_aircraft] + units _grp, true] call ace_headless_fnc_blacklist;

// Place and Rotate Plane
_aircraft setPos _startPos;
private _dir = (_startPos getDir _targetPos);
_aircraft setDir _dir;

// _aircraft

// If enabled, make Asset Invincible
if (_parameters getOrDefault ["airframe_protected", true]) then {
    { _x allowDamage false; } forEach [_aircraft] + crew _aircraft;
};

// Provide Waypoints

// Pre-Target Waypoint
private _preWP = _grp addWaypoint [vectorLinearConversion [0, 1, 0.66, _startPos, _targetPos, true], 25];


// Target Waypoint
private _tgtWP = _grp addWaypoint [_targetPos, 25];

private _speedMode = _request getOrDefault ["airdrop_speedLimit", "LIMITED"];
switch (_speedMode) do {
    case "FULL":    { _tgtWP setWaypointSpeed "FULL"; };
    case "NORMAL":  { _tgtWP setWaypointSpeed "NORMAL"; };
    case "LIMITED";
    default { _tgtWP setWaypointSpeed "LIMITED"; };
};



// Post-Target Waypoint
private _postWP = _grp addWaypoint [_targetPos getPos [500, _dir], 25];
_postWP setWaypointSpeed "FULL";


// Return Waypoint
private _endWP_Pos = _parameters getOrDefault ["pos_end", [0,0,0]];
_endWP_Pos = switch true do {
    case (_endWP_Pos isEqualTo "RETURN"):   { _startPos };
    case (_endWP_Pos isEqualTo "CONTINUE"): { _targetPos getPos [10000, _dir] };
    case (_endWP_Pos isEqualType []):       { _endWP_Pos };
    default { [0,0,0] };
};

private _endWP = _grp addWaypoint [_endWP_Pos, 100];
_endWP setWaypointStatements ["true", "{deleteVehicle _x} forEach ([vehicle this] + thisList)"];

[
    {
        params ["_request", "_aircraft", "_parameters"];
        (_request get "destination" distance2D _aircraft) < (speed _aircraft)
    },
    {
        params ["_request", "_aircraft", "_parameters"];
        private _crates = _request get "crates";

        private _recursive = {
            params ["_crates", "_aircraft", "_parameters", "_recursive"];

            private _crate = _crates deleteAt 0;
            [_crate, _aircraft, _parameters] call FUNC(parachuteCrate);

            if (_crates isEqualTo []) exitWith {};
            [ _recursive, [_crates, _aircraft, _parameters, _recursive], 1.0 ] call CBA_fnc_waitAndExecute;
        };

        [_crates, _aircraft, _parameters, _recursive] call _recursive;
    },
    [
        _request,
        _aircraft,
        _parameters
    ],
    _parameters getOrDefault ["timeout", 900],
    {
        params ["_request", "_aircraft", "_parameters"];
        deleteVehicleCrew _aircraft;
        deleteVehicle _aircraft;
        { deleteVehicle _x } forEach (_request get "crates");
    }
] call CBA_fnc_waitUntilAndExecute;



// Declare the mode as isBusy if not requested by Zeus
if !(_request getOrDefault ["isZeus", false]) exitWith {};
private _isBusyVarName = format ["%1_isBusy", _request get "delivery_mode"];

missionNamespace setVariable [_isBusyVarName, true, true];

// Revert isBusy once the aircraft is deleted
_aircraft setVariable [QGVAR(isBusyVarName), _isBusyVarName, true];
_aircraft addEventHandler ["Deleted", {
    params ["_aircraft"];
    private _isBusyVarName = _aircraft getVariable QGVAR(isBusyVarName);
    missionNamespace setVariable [_isBusyVarName, nil, true];
}];
