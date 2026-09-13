#include "../../script_component.hpp"

/*
* Author: Zorn
* Executes airdrop delivery on server.
* Creates aircraft with crew, sets waypoints, protects vehicle, handles crate parachuting via external handler.
*
* Arguments:
* 0: _request - Request hashmap with destination, crates, etc. <HASHMAP>
* 1: _parameters - Delivery parameters hashmap with airframe config, altitudes, parachute settings. <HASHMAP>
*
* Return Value:
* nil
*
* Example:
* [requestHashMap, parametersHashMap] call mum_csc_fnc_base_airdrop
*
* Public: No
*/


params [ "_request", "_parameters" ];

{ _x allowDamage false } forEach (_request get "crates");

// Get Positions
private _pos_startPos = _parameters getOrDefault ["pos_start", [0,0,0]];
private _pos_dropZone = _request getOrDefault ["destination", [0,0,0]];

_pos_startPos = switch (_parameters getOrDefault ["mode", "EDGE_NEAR"] ) do {
    case "EDGE_NEAR": { [_pos_startPos, false] call FUNC(getPosEdge) };
    case "EDGE_FAR":  { [_pos_startPos, true]  call FUNC(getPosEdge) };
    case "STARTPOS";
    default { _pos_startPos };
};

private _ATL_dropZone = _parameters getOrDefault ["airdrop_alt", 50];

// ASL of Position at Groundlevel
private _ASL_start    = getTerrainHeightASL _pos_startPos;
private _ASL_dropZone = getTerrainHeightASL _pos_dropZone;

diag_log text format ['[CVO](debug)(fn_base_airdrop) _ATL_dropZone: %1', _ATL_dropZone];
diag_log text format ['[CVO](debug)(fn_base_airdrop) _ASL_start: %1', _ASL_start];
diag_log text format ['[CVO](debug)(fn_base_airdrop) _ASL_dropZone: %1', _ASL_dropZone];

// These are the ASL's
private _ASL_release  = _ASL_dropZone + _ATL_dropZone;
private _ASL_spawn    = (_ASL_start + _ATL_dropZone) max _ASL_release; // Spawn the airframe at ether Dropzone ASL altude or, when Spawn ASL is higher, use that.

diag_log text format ['[CVO](debug)(fn_base_airdrop) _ASL_release: %1', _ASL_release];
diag_log text format ['[CVO](debug)(fn_base_airdrop) _ASL_spawn: %1', _ASL_spawn];

_pos_startPos set [2, _ASL_spawn];
_pos_dropZone set [2, _ASL_release];

//// Create Aircraft
private _airFrameClass = _parameters getOrDefault ["airframe_class", "C_Heli_Light_01_civil_F"];
private _airFrameObject = createVehicle [_airFrameClass, [0,0,0], [], 0, "FLY"];

_airFrameObject flyInHeight [ _ATL_dropZone, _parameters getOrDefault ["airdrop_alt_forced", true] ];
_airFrameObject flyInHeightASL [ _ASL_release, _ASL_release, _ASL_release ];

// Yeet airframe so it doesnt fall to the ground, requires next frame as it doesnt seem to be simulated yet in the initial frame.
[{ _this setVelocityModelSpace [0, 66, 66]; }, _airFrameObject] call CBA_fnc_execNextFrame;


private _side = switch (_parameters getOrDefault ["airframe_side", "CIV"]) do {
    case "WEST": { west };
    case "EAST": { east };
    case "GUER": { independent };
    case "CIV":  { civilian };
    default { civilian };
};

private _grp = _side createVehicleCrew _airFrameObject;
_grp addVehicle _airFrameObject;
_grp setBehaviourStrong "CARELESS";
_grp deleteGroupWhenEmpty true;

// Add vic to curator
{ _x addCuratorEditableObjects [[_airFrameObject], true] } forEach allCurators;

//  Manage ACE HC Blacklist
[[_airFrameObject] + units _grp, true] call ace_headless_fnc_blacklist;

// Place and Rotate Plane
_airFrameObject setPos _pos_startPos; // ToDo: Turn into setPosASL
private _dir = (_pos_startPos getDir _pos_dropZone);
_airFrameObject setDir _dir;

// If enabled, make Asset Invincible
if (_parameters getOrDefault ["airframe_protected", true]) then {
    { _x allowDamage false; } forEach [_airFrameObject] + crew _airFrameObject;
};



//// Provide Waypoints

// Pre-Target Waypoint
private _preWPPos = vectorLinearConversion [0, 1, 0.80, _pos_startPos, _pos_dropZone, true];
_preWPPos set [2, _ASL_spawn];
private _preWP = _grp addWaypoint [_preWPPos, -1];
private _speed_init = switch (true) do {
    case (_airFrameClass isKindOf "Helicopter"): { "FULL" };
    case (_airFrameClass isKindOf "Plane"): { "LIMITED" };
    default { "NORMAL" };
};
_preWP setWaypointSpeed _speed_init;

// Target Waypoint
private _tgtWP = _grp addWaypoint [_pos_dropZone, -1];
if (_speed_init isEqualTo "FULL") then { _tgtWP setWaypointSpeed "NORMAL"; };

// Post-Target Waypoint
private _postWPPos = _pos_dropZone getPos [1000, _dir];
_postWPPos set [2, _ASL_spawn];
private _postWP = _grp addWaypoint [_postWPPos, -1];

// Return Waypoint
private _endWPPos = _parameters getOrDefault ["pos_end", [0,0,0]];
_endWPPos = switch true do {
    case (_endWPPos isEqualTo "RETURN"):   { _pos_startPos };
    case (_endWPPos isEqualTo "CONTINUE"): { _pos_dropZone getPos [10000, _dir] };
    default { [0,0,0] };
};
_endWPPos set [2, _ASL_spawn];
private _endWP = _grp addWaypoint [_endWPPos, -1];
_endWP setWaypointSpeed _speed_init;
_endWP setWaypointStatements ["true", "{deleteVehicle _x} forEach ([vehicle this] + thisList)"];

[
    {
        params ["_request", "_airFrameObject", "_parameters"];
        (_request get "destination" distance2D _airFrameObject) < (speed _airFrameObject)
    },
    {
        params ["_request", "_airFrameObject", "_parameters"];
        private _crates = _request get "crates";

        private _recursive = {
            params ["_crates", "_airFrameObject", "_parameters", "_recursive"];

            private _crate = _crates deleteAt 0;
            [_crate, _airFrameObject, _parameters] call FUNC(parachuteCrate);

            [{ _this allowDamage true }, _crate] call CBA_fnc_execNextFrame;

            if (_crates isEqualTo []) exitWith {};
            [ _recursive, [_crates, _airFrameObject, _parameters, _recursive], 1.0 ] call CBA_fnc_waitAndExecute;
        };

        [_crates, _airFrameObject, _parameters, _recursive] call _recursive;
    },
    [
        _request,
        _airFrameObject,
        _parameters
    ],
    _parameters getOrDefault ["timeout", 900],
    {
        params ["_request", "_airFrameObject", "_parameters"];
        deleteVehicleCrew _airFrameObject;
        deleteVehicle _airFrameObject;
        { deleteVehicle _x } forEach (_request get "crates");
    }
] call CBA_fnc_waitUntilAndExecute;

