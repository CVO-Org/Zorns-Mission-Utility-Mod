#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to move (Teleport) Units into all available Cargo Seats of the provided Vehicles
*
* Arguments:
*   0: Units    <ARRAY of Objects>
*   1: Vehicles <ARRAY of Objects>
*
* Return Value:
* None
*
* Example:
* [_units, _vehicles] call mum_common_fnc_moveUnitsIntoVehicles;
*
* Public: No
*/

params [
    ["_units",          [],         [objNull, []]       ],
    ["_vehicles",       [],         [objNull, []]       ],
    ["_roles",          "DEFAULT",  [[], ""]            ],  // "driver","gunner","commander","cargo","turret", "personTurret"
    ["_blockCopilot",   true,       [true]              ],
    ["_prioMap",        "HELI",     [createHashMap, ""] ]
];

// Input Sanitisation
if (_units isEqualType objNull) then { _units = [_units] };
if (_vehicles isEqualType objNull) then { _vehicles = [_vehicles] };

if ( _units isEqualTo [] || {_vehicles isEqualTo []} ) exitWith { ZRN_LOG_MSG(No units or vehicles provided); };

_roles = switch (true) do {
    case (_roles isEqualTo "DEFAULT"): { ["cargo", "personturret", "turret", "gunner", "commander"] };
    case (_roles isEqualTo "ALL"): { ["driver", "gunner", "commander", "cargo", "turret", "personturret"] };
    default {
        if (_roles isEqualType "") then { _roles = [ _roles ]; };
        _roles apply { toLowerANSI _x } select { _x in ["driver", "gunner", "commander", "cargo", "turret", "personturret"] };
    };
};

if (_roles isEqualTo []) exitWith { ZRN_LOG_MSG(No valid whitelisted roles provided); };

// Handle Priority
if (_prioMap isEqualType "") then {

    _prioMap = switch (_prioMap) do {
        case "HELI": {
            createHashMapFromArray [
                 [ "cargo",         0 ] // Passenger
                ,[ "personturret",  0 ] // Passenger FFV
                ,[ "turret",       -1 ] // DoorGunners
                ,[ "gunner",       -2 ] // DoorGunners ?
                ,[ "copilot",      -3 ] // CoPilot(s)
                ,[ "driver",       -4 ] // Pilot
                ,[ "commander",    -5 ] // ?
            ];
        };

        case "DEFAULT";
        default {
            createHashMapFromArray [
                 [ "cargo",         0 ]
                ,[ "personturret",  0 ]
                ,[ "turret",        0 ]
                ,[ "copilot",       0 ]
                ,[ "driver",        0 ]
                ,[ "gunner",        0 ]
                ,[ "commander",     0 ]
            ];
        };
    };
};

// Create Slot Array - [ role, vehicle, args ]
// args can be nil, cargoIndex or turretPath

// [slot, priority]
private _slots = [];

{
    private _vic = _x;

    // Free Seats
    private _seats = fullCrew [_vic, "", true] select { isNull (_x select 0) };

    {
        // Filter only whitelisted Roles
        private _role = _x;
        switch (_role) do {
            case "driver": {
                private _filteredSeats = _seats select { (_x select 1) isEqualTo _role };
                // _args: nil - specialState: ""
                {
                    if (lockedDriver _vic) then { continue };
                    _slots pushBack [
                        [_role, _vic ],
                        _prioMap getOrDefault [_role, 0]
                    ];
                } forEach _filteredSeats;
            };

            case "gunner": {
                private _filteredSeats = _seats select { (_x select 1) isEqualTo _role };
                // _args: nil - specialState: ""
                {
                    if (_vic lockedTurret (_x select 3) ) then { continue };
                    _slots pushBack [
                        [_role, _vic ],
                        _prioMap getOrDefault [_role, 0]
                    ];
                } forEach _filteredSeats;
            };

            case "commander": {
                private _filteredSeats = _seats select { (_x select 1) isEqualTo _role };
                // _args: nil - specialState: ""
                {
                    if (_vic lockedTurret (_x select 3) ) then { continue };
                    _slots pushBack [
                        [_role, _vic ],
                        _prioMap getOrDefault [_role, 0]
                    ];
                } forEach _filteredSeats;
            };

            case "cargo": {
                private _filteredSeats = _seats select { (_x select 1) isEqualTo _role };
                // _args: cargoIndex - specialState: ""
                {
                    private _cargoIndex = _x select 2;
                    if (_vic lockedCargo _cargoIndex ) then { continue };
                    _slots pushBack [
                        [_role, _vic, _cargoIndex ],
                        _prioMap getOrDefault [_role, 0]
                    ];
                } forEach _filteredSeats;
            };

            case "turret": {
                private _filteredSeats = _seats select { (_x select 1) isEqualTo "turret" && { _x select 4 isEqualTo false } };
                // _args: turretPath - specialState: "" or "COPILOT")
                {
                    private _turretPath = _x select 3;
                    if ( _vic lockedTurret _turretPath ) then { continue };

                    private _isCopilot = getNumber ([_vic, _turretPath] call BIS_fnc_turretConfig >> "isCopilot") isEqualTo 1;
                    if (_isCopilot && _blockCopilot) then { continue };

                    private _priority = _prioMap getOrDefault [ [_role, "copilot"] select _isCopilot, 0 ];

                    _slots pushBack [
                        [ "turret", _vic, _turretPath ],
                        _priority
                    ];
                } forEach _filteredSeats;
            };

            case "personturret": {
                private _filteredSeats = _seats select { (_x select 1) isEqualTo "turret" && { _x select 4 isEqualTo true  } };
                // _args: turretPath - specialState: nil
                {
                    private _turretPath = _x select 3;
                    if (_vic lockedTurret _turretPath) then { continue };

                    private _isCopilot = getNumber ([_vic, _turretPath] call BIS_fnc_turretConfig >> "isCopilot") isEqualTo 1;
                    if (_isCopilot && _blockCopilot) then { continue };

                    _slots pushBack [
                        ["turret", _vic, _turretPath ],
                        _prioMap getOrDefault [_role, 0]
                    ];
                } forEach _filteredSeats;
            };
        };
    } forEach _roles;
} forEach _vehicles;


// Prep Priority Slots
private _slots_prio_first = [_slots, [], { _x select 1 }, "DESCEND", { (_x select 1) > 0 } ] call BIS_fnc_sortBy apply { _x select 0 };
private _slots_prio_mid   =  _slots select { (_x select 1) isEqualTo 0 }                                         apply { _x select 0 };
private _slots_prio_last  = [_slots, [], { _x select 1 }, "DESCEND", { (_x select 1) < 0 } ] call BIS_fnc_sortBy apply { _x select 0 };

private _return = [];
private _pairs = [];

{
    private _unit = _x;

    // take random slot, remove it from the main array and apply it to a player.
    private _slot = switch (true) do {
        case ( _slots_prio_first isNotEqualTo [] ): { _slots_prio_first deleteAt 0 };
        case ( _slots_prio_mid   isNotEqualTo [] ): { _slots_prio_mid   deleteAt ( floor random count _slots_prio_mid ) };
        case ( _slots_prio_last  isNotEqualTo [] ): { _slots_prio_last  deleteAt 0 };
        default { nil };
    };

    if (isNil "_slot") then { _return pushBack _unit; } else { _pairs pushBack [_unit, _slot]; };

} forEach _units;


private _code = {
    params ["_pairs", "_code"];
    if (_pairs isEqualTo []) exitWith {};
    _pairs deleteAt 0 call { [QGVAR(EH_UnitIntoVehicle), [_this#0, _this#1], _this#0] call CBA_fnc_targetEvent; };
    [_pairs, _code] call _code;
};
[_pairs, _code] call _code;


if (_return isEqualTo []) then { _return = true; };

_return


/*

// GM URAL
[
    // Unit,          role,     CargoIndex, TurretPath, personTurret, assignedUnit,             PositionName
    [ <NULL-object>,  "driver",     -1,         [],         false,      <NULL-object>,      "$STR_POSITION_DRIVER" ]        // Driver - AI
    ,[ <NULL-object>, "cargo",      0,          [],         false,      <NULL-object>,      "$STR_GETIN_POS_PASSENGER" ]    // CoDriver - Keep empty
    ,[ <NULL-object>, "turret",     13,         [0],        true,       <NULL-object>,      "$STR_GN_GM_BENCH01" ]
    ,[ <NULL-object>, "turret",     14,         [1],        true,       <NULL-object>,      "$STR_GN_GM_BENCH02" ]
    ,[ <NULL-object>, "turret",     3,          [2],        true,       <NULL-object>,      "$STR_GN_GM_BENCH03" ]
    ,[ <NULL-object>, "turret",     5,          [3],        true,       <NULL-object>,      "$STR_GN_GM_BENCH04" ]
    ,[ <NULL-object>, "turret",     7,          [4],        true,       <NULL-object>,      "$STR_GN_GM_BENCH05" ]
    ,[ <NULL-object>, "turret",     9,          [5],        true,       <NULL-object>,      "$STR_GN_GM_BENCH06" ]
    ,[ <NULL-object>, "turret",     11,         [6],        true,       <NULL-object>,      "$STR_GN_GM_BENCH07" ]
    ,[ <NULL-object>, "turret",     12,         [7],        true,       <NULL-object>,      "$STR_GN_GM_BENCH08" ]
    ,[ <NULL-object>, "turret",     10,         [8],        true,       <NULL-object>,      "$STR_GN_GM_BENCH09" ]
    ,[ <NULL-object>, "turret",     8,          [9],        true,       <NULL-object>,      "$STR_GN_GM_BENCH10" ]
    ,[ <NULL-object>, "turret",     6,          [10],       true,       <NULL-object>,      "$STR_GN_GM_BENCH11" ]
    ,[ <NULL-object>, "turret",     4,          [11],       true,       <NULL-object>,      "$STR_GN_GM_BENCH12" ]
    ,[ <NULL-object>, "turret",     2,          [12],       true,       <NULL-object>,      "$STR_GN_GM_BENCH13" ]
    ,[ <NULL-object>, "turret",     1,          [13],       true,       <NULL-object>,      "$STR_GN_GM_BENCH14" ]
]

// EF APC
[
    // Unit,           role,        CargoIndex, TurretPath, personTurret, assignedUnit,          PositionName
    [ B Alpha 1-1:2,   "driver",    -1,         [],         false,        B Alpha 1-1:2,          "$STR_POSITION_DRIVER" ]
    ,[ <NULL-object>,  "cargo",      0,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      1,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      2,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      3,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      4,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      5,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      6,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      7,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-1:3,  "gunner",    -1,         [0],        true,         B Alpha 1-1:3,          "$STR_POSITION_GUNNER" ]
    ,[ B Alpha 1-1:4,  "commander", -1,         [0,0],      true,         B Alpha 1-1:4,          "$STR_POSITION_COMMANDER" ]
    ,[ <NULL-object>,  "turret",    -1,         [0,1],      false,        <NULL-object>,          "$STR_B_crew_F0" ]
    ,[ <NULL-object>,  "turret",    -1,         [1],        true,         <NULL-object>,          "$STR_A3_TURRETS_CARGOTURRET_L1" ]
    ,[ <NULL-object>,  "turret",    -1,         [2],        true,         <NULL-object>,          "$STR_A3_TURRETS_CARGOTURRET_R1" ]
    ,[ <NULL-object>,  "turret",    -1,         [3],        true,         <NULL-object>,          "$STR_A3_TURRETS_CARGOTURRET_L2" ]
    ,[ <NULL-object>,  "turret",    -1,         [4],        true,         <NULL-object>,          "$STR_A3_TURRETS_CARGOTURRET_R2" ]
]

// EF APC (filled)
[
    // Unit,           role,        CargoIndex, TurretPath, personTurret, assignedUnit,          PositionName
    [ B Alpha 1-1:2,   "driver",    -1,         [],         false,        B Alpha 1-1:2,          "$STR_POSITION_DRIVER" ]
    ,[ B Alpha 1-4:6,  "cargo",      0,         [],         false,        B Alpha 1-4:6,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-4:7,  "cargo",      1,         [],         false,        B Alpha 1-4:7,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-4:8,  "cargo",      2,         [],         false,        B Alpha 1-4:8,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-4:9,  "cargo",      3,         [],         false,        B Alpha 1-4:9,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-4:10, "cargo",      4,         [],         false,        B Alpha 1-4:10,         "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-4:11, "cargo",      5,         [],         false,        B Alpha 1-4:11,         "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-4:12, "cargo",      6,         [],         false,        B Alpha 1-4:12,         "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-4:13, "cargo",      7,         [],         false,        B Alpha 1-4:13,         "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-1:3,  "gunner",    -1,         [0],        false,        B Alpha 1-1:3,          "$STR_POSITION_GUNNER" ]
    ,[ B Alpha 1-4:3,  "commander", -1,         [0,0],      true,         B Alpha 1-4:3,          "$STR_POSITION_COMMANDER" ]
    ,[ B Alpha 1-4:1,  "turret",    -1,         [0,1],      false,        B Alpha 1-4:1,          "$STR_B_crew_F0" ]
    ,[ B Alpha 1-4:2,  "turret",    -1,         [1],        true,         B Alpha 1-4:2,          "$STR_A3_TURRETS_CARGOTURRET_L1" ]
    ,[ <NULL-object>,  "turret",    -1,         [2],        true,         B Alpha 1-1:4,          "$STR_A3_TURRETS_CARGOTURRET_R1" ]
    ,[ B Alpha 1-4:4,  "turret",    -1,         [3],        true,         B Alpha 1-4:4,          "$STR_A3_TURRETS_CARGOTURRET_L2" ]
    ,[ B Alpha 1-4:5,  "turret",    -1,         [4],        true,         B Alpha 1-4:5,          "$STR_A3_TURRETS_CARGOTURRET_R2" ]
]

// SOG M113
[
    // Unit,           role,        CargoIndex, TurretPath, personTurret, assignedUnit,          PositionName
    [ B Alpha 1-3:1,   "driver",    -1,         [],         false,        B Alpha 1-3:1,          "$STR_POSITION_DRIVER" ]
    ,[ B Alpha 1-4:5,  "cargo",      4,         [],         false,        B Alpha 1-4:5,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-4:6,  "cargo",      5,         [],         false,        B Alpha 1-4:6,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-5:1,  "cargo",      6,         [],         false,        B Alpha 1-5:1,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-5:2,  "cargo",      7,         [],         false,        B Alpha 1-5:2,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-5:3,  "cargo",      8,         [],         false,        B Alpha 1-5:3,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-5:4,  "cargo",      9,         [],         false,        B Alpha 1-5:4,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-5:5,  "cargo",     10,         [],         false,        B Alpha 1-5:5,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-5:6,  "cargo",     11,         [],         false,        B Alpha 1-5:6,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 1-6:1,  "cargo",     12,         [],         false,        B Alpha 1-6:1,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "turret",    -1,         [0],        false,        <NULL-object>,          "$STR_VN_V_ROLE_COMMANDER_DN" ]
    ,[ B Alpha 1-3:2,  "commander", -1,         [1],        false,        B Alpha 1-3:2,          "$STR_VN_ARMOR_M113A1_GUNNER_MG1" ]
    ,[ B Alpha 1-3:3,  "turret",    -1,         [2],        false,        B Alpha 1-3:3,          "$STR_VN_ARMOR_M113A1_GUNNER_MG2" ]
    ,[ B Alpha 1-3:4,  "turret",    -1,         [3],        false,        B Alpha 1-3:4,          "$STR_VN_ARMOR_M113A1_GUNNER_MG3" ]
    ,[ B Alpha 1-4:1,  "turret",     0,         [4],        true,         B Alpha 1-4:1,          "$STR_VN_ARMOR_M113A1_CARGO_12" ]
    ,[ B Alpha 1-4:2,  "turret",     1,         [5],        true,         B Alpha 1-4:2,          "$STR_VN_ARMOR_M113A1_CARGO_13" ]
    ,[ B Alpha 1-4:3,  "turret",     2,         [6],        true,         B Alpha 1-4:3,          "$STR_VN_ARMOR_M113A1_CARGO_14" ]
    ,[ B Alpha 1-4:4,  "turret",     3,         [7],        true,         B Alpha 1-4:4,          "$STR_VN_ARMOR_M113A1_CARGO_15" ]
]

// Uh-60 Stealth Hawk
[
    // Unit,           role,        CargoIndex, TurretPath, personTurret, assignedUnit,          PositionName
    [ B Alpha 2-1:1,   "driver",    -1,         [],         false,        B Alpha 2-1:1,          "$STR_POSITION_DRIVER"     ]    // Pilot
    ,[ <NULL-object>,  "cargo",      0,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      1,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      2,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      3,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      4,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      5,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      6,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ <NULL-object>,  "cargo",      7,         [],         false,        <NULL-object>,          "$STR_GETIN_POS_PASSENGER" ]
    ,[ B Alpha 2-1:2,  "turret",    -1,         [0],        false,        B Alpha 2-1:2,          "$STR_A3_COPILOT" ]        // Co-Pilot
    ,[ B Alpha 2-1:3,  "gunner",    -1,         [1],        false,        B Alpha 2-1:3,          "$STR_A3_LEFT_GUNNER" ]    // Left  Door Gunner
    ,[ B Alpha 2-1:4,  "turret",    -1,         [2],        false,        B Alpha 2-1:4,          "$STR_A3_RIGHT_GUNNER" ]   // Right Door Gunner
]

//MH-6
[
    [B Alpha 2-5:1,"driver",-1,[],false,B Alpha 2-5:1,"$STR_POSITION_DRIVER"],
    [<NULL-object>,"cargo",0,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",1,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [B Alpha 2-5:2,"turret",-1,[0],false,B Alpha 2-5:2,"$STR_A3_COPILOT"],
    [<NULL-object>,"turret",2,[1],true,<NULL-object>,"$STR_A3_TURRETS_BENCH_R1"],
    [<NULL-object>,"turret",3,[2],true,<NULL-object>,"$STR_A3_TURRETS_BENCH_L2"],
    [<NULL-object>,"turret",4,[3],true,<NULL-object>,"$STR_A3_TURRETS_BENCH_L1"],
    [<NULL-object>,"turret",5,[4],true,<NULL-object>,"$STR_A3_TURRETS_BENCH_R2"]
]


// Chinnok unarmed
[
    [B Alpha 2-4:1,"driver",-1,[],false,B Alpha 2-4:1,"$STR_POSITION_DRIVER"],
    [<NULL-object>,"cargo",0,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",1,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",2,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",3,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",4,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",5,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",6,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",7,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",8,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",9,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",10,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",11,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",12,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",13,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [B Alpha 2-4:2,"turret",-1,[0],false,B Alpha 2-4:2,"$STR_A3_COPILOT"],
    [<NULL-object>,"turret",16,[1],true,<NULL-object>,"$STR_A3_TURRETS_WINDOW_L"],
    [<NULL-object>,"turret",17,[2],true,<NULL-object>,"$STR_A3_TURRETS_WINDOW_R"],
    [<NULL-object>,"turret",14,[3],true,<NULL-object>,"$STR_A3_TURRETS_CARGOTURRET_R"],
    [<NULL-object>,"turret",15,[4],true,<NULL-object>,"$STR_A3_TURRETS_CARGOTURRET_L"]
]

// Chinnok
[
    [B Alpha 2-3:1,"driver",-1,[],false,B Alpha 2-3:1,"$STR_POSITION_DRIVER"],
    [<NULL-object>,"cargo",0,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",1,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",2,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",3,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",4,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",5,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",6,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",7,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",8,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",9,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",10,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",11,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",12,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",13,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [B Alpha 2-3:2,"turret",-1,[0],false,B Alpha 2-3:2,"$STR_A3_COPILOT"],
    [B Alpha 2-3:3,"gunner",-1,[1],false,B Alpha 2-3:3,"$STR_A3_LEFT_GUNNER"],
    [B Alpha 2-3:4,"turret",-1,[2],false,B Alpha 2-3:4,"$STR_A3_RIGHT_GUNNER"],
    [<NULL-object>,"turret",14,[3],true,<NULL-object>,"$STR_A3_TURRETS_CARGOTURRET_R"],
    [<NULL-object>,"turret",15,[4],true,<NULL-object>,"$STR_A3_TURRETS_CARGOTURRET_L"]
]

// Merlin
[
    [B Alpha 2-2:1,"driver",-1,[],false,B Alpha 2-2:1,"$STR_POSITION_DRIVER"],
    [<NULL-object>,"cargo",2,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",3,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",4,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",5,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",6,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",7,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",8,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",9,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",10,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",11,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",12,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",13,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",14,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",15,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [B Alpha 2-2:2,"turret",-1,[0],false,B Alpha 2-2:2,"$STR_A3_COPILOT"],
    [<NULL-object>,"turret",0,[1],true,<NULL-object>,"$STR_A3_TURRETS_CARGOTURRET_R"],
    [<NULL-object>,"turret",1,[2],true,<NULL-object>,"$STR_A3_TURRETS_CARGOTURRET_L"]
]


// SOG Huey
[
    [B Alpha 3-2:1,"driver",-1,[],false,B Alpha 3-2:1,"$STR_POSITION_DRIVER"],
    [<NULL-object>,"cargo",2,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [<NULL-object>,"cargo",3,[],false,<NULL-object>,"$STR_GETIN_POS_PASSENGER"],
    [B Alpha 3-2:2,"gunner",-1,[0],false,B Alpha 3-2:2,"$STR_VN_V_ROLE_COPILOT_DN"],
    [<NULL-object>,"turret",0,[1],true,<NULL-object>,"$STR_VN_BOAT_02_CARGO_5"],
    [<NULL-object>,"turret",1,[2],true,<NULL-object>,"$STR_VN_BOAT_02_CARGO_6"]
]

// SOG Cobra
[
    [B Alpha 2-6:1,"driver",-1,[],false,B Alpha 2-6:1,"$STR_POSITION_DRIVER"],
    [B Alpha 2-6:2,"gunner",-1,[0],false,B Alpha 2-6:2,"$STR_POSITION_GUNNER"]
]

// SOG baby little bird
[
    [B Alpha 3-1:1,"driver",-1,[],false,B Alpha 3-1:1,"$STR_POSITION_DRIVER"],
    [B Alpha 3-1:2,"turret",-1,[0],false,B Alpha 3-1:2,"$STR_VN_B_MEN_AIRCREW_02_DN"],
    [B Alpha 3-1:3,"gunner",-1,[1],false,B Alpha 3-1:3,"$STR_VN_B_MEN_AIRCREW_04_DN"],
    [<NULL-object>,"turret",0,[2],true,<NULL-object>,"$STR_VN_B_MEN_AIRCREW_99_DN"]
]
*/
