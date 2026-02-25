#include "../../script_component.hpp"

/*
* Author: Zorn
* function that will create the supplybox, fill, modify, etc.
*
* Arguments:
*
* Return Value:
* _box
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

if !(isServer) exitWith {};

params [
    ["_entry",  nil,  [createHashMap] ]
];

if (isNil "_entry") exitWith {};

private _box = createVehicle [_entry getOrDefault ["box_class", "C_supplyCrate_F"], [0,0,0],[],2,"CAN_COLLIDE"];

_box setVariable ["ace_cargo_customname", _entry getOrDefault ["displayName", "DisplayName"], true];

if (_entry getOrDefault ["box_empty", true]) then {
    // Empties the inventory of the Box
    clearBackpackCargoGlobal _box;
    clearMagazineCargoGlobal _box;
    clearWeaponCargoGlobal _box;
    clearItemCargoGlobal _box;
};

private _items =     _entry getOrDefault ["items", []];
private _backpacks = _entry getOrDefault ["backpacks", []];

if (count _items > 0) then {
    {    _box addItemCargoGlobal [_x # 0, _x # 1] } forEach _items;
};
// Fills the Box with with backpacks

if (count _backpacks > 0) then {
    { _box addBackpackCargoGlobal [_x # 0, _x # 1] } forEach _backpacks;
};

//////////////////////////////////////////////////
///////////// ACE Rearm Repair Refuel ////////////
//////////////////////////////////////////////////

// // Optional Parameters for Additional ACE Funcitonality (RRR)

// ACE Medical Facility
if (_entry getOrDefault ["ace_medical_facility", false]) then { 
    _box setVariable ["ace_medical_isMedicalFacility", true, true];  
};

// ACE Medical vehicle
if (_entry getOrDefault ["ace_medical_vehicle", false]) then {
    _box setVariable ["ace_medical_isMedicalVehicle", true, true];  
};

// ACE Repair Facility
if (_entry getOrDefault ["ace_repair_facility", false]) then {
    _box setVariable ["ace_isRepairFacility", true, true];  
};

// ACE Repair Vehicle
if (_entry getOrDefault ["ace_repair_vehicle", false]) then {
    _box setVariable ["ace_repair_canRepair", true, true];  
};

// ACE Rearm Source
if (_entry getOrDefault ["ace_rearm_source", false]) then {
    [
        _box,
        _entry getOrDefault ["ace_rearm_source_value", 50]
    ] call ace_rearm_fnc_makeSource;
};

// ACE Refuel Source
if (_entry getOrDefault ["ace_refuel_source", false]) then {
    [
        _box,
        _entry getOrDefault ["ace_refuel_source_value", 50],
        _entry getOrDefault ["ace_refuel_source_nozzlePos", [0,0,0]]
    ] call ace_refuel_fnc_makeSource;
};

//////////////////////////////////////////////////
///////////// ACE DRAGGING / CARRYING /////////////
//////////////////////////////////////////////////

// ACE Drag
[
    [
        QGVAR(EH_ace_setDraggable),
        [
            _box,
            _entry getOrDefault ["ace_drag_canDrag", true],
            _entry getOrDefault ["ace_drag_relPOS", [0,1.5,0]],
            _entry getOrDefault ["ace_drag_dir", 0],
            _entry getOrDefault ["ace_drag_ignoreWeight", true]
        ]
    ] call CBA_fnc_globalEventJIP,
    _box
] call CBA_fnc_removeGlobalEventJIP;


// ACE Carry

[
    [
        QGVAR(EH_ace_setCarryable),
        [
            _box,
            _entry getOrDefault ["ace_carry_canCarry", true],
            _entry getOrDefault ["ace_carry_relPOS", [0,1,1]],
            _entry getOrDefault ["ace_carry_dir", 0],
            _entry getOrDefault ["ace_carry_ignoreWeight", false]
        ]
    ] call CBA_fnc_globalEventJIP,
    _box
] call CBA_fnc_removeGlobalEventJIP;


//////////////////////////////////////////////////
///////////// ACE CARGO /////////////
//////////////////////////////////////////////////

// ACE Cargo SetSize (how big is the crate itself)
if (_entry getOrDefault ["ace_cargo_setSize", "DEFAULT"] isEqualType 0) then {
    [_box, _entry get "ace_cargo_setSize"] call ace_cargo_fnc_setSize;
};


private _space =        _entry getOrDefault ["ace_cargo_setSpace", 0];
private _addWheels =    _entry getOrDefault ["ace_cargo_add_spareWheels", 0];   // cargoSize = 1
private _addJerryCans = _entry getOrDefault ["ace_cargo_add_jerrycans", 0];     // cargoSize = 1
private _addTracks =    _entry getOrDefault ["ace_cargo_add_tracks", 0];        // cargoSize = 2
_space = _space + _addWheels + _addJerryCans + _addTracks * 2;


// ACE Cargo SetSpace (how much can you put INSIDE the crate)
[_box, _space] call ace_cargo_fnc_setSpace;


while {_addWheels > 0}    do { ["ACE_Wheel",           _box]  call ace_cargo_fnc_loadItem; _addWheels = _addWheels -1; };
while {_addJerryCans > 0} do { ["Land_CanisterFuel_F", _box]  call ace_cargo_fnc_loadItem; _addJerryCans = _addJerryCans -1 };
while {_addTracks > 0}    do { ["ACE_Track",           _box]  call ace_cargo_fnc_loadItem; _addTracks = _addTracks -1};

[QGVAR(api_crateSpawned), [_box] ] call CBA_fnc_ServerEvent;

_box setVehiclePosition [[0,0,0], [], 100];

// add object to all curators

{ _x addCuratorEditableObjects [[_box], false] } forEach allCurators;

_box
