#include "../../script_component.hpp"

/*
* Author: Zorn
* Creates Waypoints to Slingload slingloadable cargo to an destination and then returns to a waiting point.
*
* Arguments:
* 0: _heli            <Object or Group>    - Group of Heli Crew
* 1: _cargoObj        <Object>            - Object to be slung - needs to be slingloadable!
* 2: _dropOffPos    <Object or Pos>        - Destination of the Cargo Object. Ether Pos or Object, like empty Helipad.
* 3: _returnPos        <Object or Pos>        - Point of return for the helicopter once the cargo has been delivered. Ether Pos or Object, like empty Helipad.
* 4: _direction        <Number>            - Direction of Ingress / Egress - Default: "AUTO"
* 5: _kickout        <Boolean>            - If true, empties crew and locks the seat during airlift    <Default: false>
* 5: _protected        <Boolean>            - If true, Disable Damage for helicopter and Crew            <Default: true>
*
* Return Value:
* none
*
* Example:
* [_heliGRPGroup, _CargoObj, _DZ, _home, _ingress] call mum_common_fnc_airlift
*
* Public: [Yes/No]
*/

if (!isServer) exitWith {};

params [
    [ "_heli",          grpNull,        [objNull,grpNull]           ],
    [ "_cargoObj",      objNull,        [objNull]                   ],
    [ "_dropOffPos",    nil,            [objNull,[]],       [2,3]   ],
    [ "_returnPos",     nil,            [objNull,[], ""],   [2,3]   ],
    [ "_direction",     "AUTO",         [0, ""]                     ],
    [ "_kickOut",       false,          [false]                     ],
    [ "_protected",     true,           [false]                     ]
];

// Input Sanitization
if (_heli isEqualTo grpNull) exitWith {};
if (_cargoObj isEqualTo objNull) exitWith {};
if (isNil "_dropOffPos") exitWith {};

private ["_heliOBJ", "_heliGRP"];

switch (typeName _heli) do {
    case "GROUP": {
        _heliGRP = _heli;
        _heliObj = vehicle leader _heliGRP;
    };
    case "OBJECT": {
        _heliGRP = group driver _heli;
        _heliObj = _heli;
    };
};

//Check if target can be airlifted
private _helperNeeded = getArray (configOf _cargoObj >> "slingLoadCargoMemoryPoints") isEqualTo [];


{    _x setGroupOwner 2;    } forEach [_heliGRP, group driver _cargoObj];
{    _x setOwner 2;        } forEach [_cargoObj, _heliObj];


// turn off damage if _protected
if (_protected) then {
    { _x allowDamage false; } forEach units _heliGRP + [vehicle leader _heliGRP];
};

// Create Helper Object for The Drop Off Point and Landing Point
private ["_dropOffPosObj", "_returnPosObj"];
if (_dropOffPos isEqualType []) then {
    _dropOffPosObj = createVehicle ["Land_HelipadEmpty_F", _dropOffPos];
} else {    _dropOffPosObj = _dropOffPos; _dropOffPos = getPos _dropOffPosObj;  };


if (isNil "_returnPos") then {    _returnPos = getPos leader _heliGRP;  };

if (_returnPos isEqualType []) then {
    _returnPosObj = createVehicle ["Land_HelipadEmpty_F", _returnPos];
} else {    _returnPosObj = _returnPos; _returnPos = getPos _returnPosObj;  };



private _heliPos = getPos leader _heliGRP;
private _cargoPos = getPos _cargoObj;

private _dis = _heliObj distance _cargoObj;
private _far = 1500;
private _mid = 350;
private _near = 50;

if  (_direction isEqualTo "AUTO" && _dis < _far) then {
    _mid = _dis / _far * 200;
    _far = _dis;
};


// Adjust Direction in case of "AUTO"
if (_direction isEqualTo "AUTO") then {
    _direction = _cargoObj getDir _heliObj;
};



// Empty the cargo vehicle and locks it + setMass for Airlift
private _code = {
    params ["_heliObj","_cargoObj","_kickOut"];

    if (_kickOut) then {
        {    moveOut _x;    } forEach crew (_cargoOBJ);
        _cargoOBJ lockCargo true;
        _cargoOBJ lockDriver true;
        { _cargoOBJ lockTurret [_x, true]; } forEach allTurrets [_cargoOBJ, true];
    };

    if !(_heliObj canSlingLoad _cargoOBJ) then {
        _cargoOBJ setVariable [QGVAR(original_mass), getMass (_cargoOBJ), true ];
        _cargoOBJ setMass 1000;
    };
};
[ { (_this # 0 distance2D _this # 1) < 100 }, _code, [_heliObj, _cargoObj,_kickOut], 600, _code ] call CBA_fnc_waitUntilAndExecute;


private _code = {
    params ["_heliObj","_cargoObj","_kickOut"];

    if (_kickOut) then {
        _cargoOBJ lockCargo false;
        _cargoOBJ lockDriver false;
        { _cargoOBJ lockTurret [_x, false]; } forEach allTurrets [_cargoOBJ, true];
    };

    private _ogMass = _cargoOBJ getVariable QGVAR(original_mass);
    if (!isNil "_ogMass") then { _cargoOBJ setMass _ogMass; };

};
[ { (_this # 0 distance2D _this # 1) < 10 }, _code, [_dropOffPosObj, _cargoObj,_kickOut], 600, _code ] call CBA_fnc_waitUntilAndExecute;


_heliObj setFuel 1;
_heliObj limitSpeed 200;

private _wpPos1 = _cargoPos getPos [_far,  _direction];
private _wpPos2 = _cargoPos getPos [_mid,  _direction];
private _wpPos3 = _cargoPos getPos [_near, _direction];
private _wpPos4 = + _cargoPos;
private _wpPos5 = _cargoPos getPos [_far, _direction];

private _wp1 = _heliGRP addWaypoint [_wpPos1, 0];
_wp1 setWaypointBehaviour "CARELESS";
_wp1 setWaypointStatements ["true", "vehicle this flyInHeight [50, true]; vehicle this limitSpeed 100;"];
_wp1 setWaypointSpeed "FULL";


private _wp2 = _heliGRP addWaypoint [_wpPos2, 0];
_wp2 setWaypointStatements ["true", "vehicle this flyInHeight [30, true]; vehicle this limitSpeed 50;"];
_wp2 setWaypointSpeed "LIMITED";

private _wp3 = _heliGRP addWaypoint [_wpPos3, 0];
_wp3 setWaypointStatements ["true", "vehicle this flyInHeight [30, false]; vehicle this limitSpeed 25;" ];



private _wp4 = _heliGRP addWaypoint [_cargoObj, 0];
_wp4 waypointAttachVehicle _cargoObj;
_wp4 setWaypointType "HOOK";
_wp4 setWaypointStatements ["true", "vehicle this flyInHeight [15, false]; vehicle this limitSpeed 75;"];


private _wp5 = _heliGRP addWaypoint [_wpPos5, 0];
_wp5 setWaypointStatements ["true", "vehicle this flyInHeight [75, true]; vehicle this limitSpeed 200;"];



private _wp6 = _heliGRP addWaypoint [_dropOffPos, 0];
private _wp7 = _heliGRP addWaypoint [_dropOffPos, 0];
_wp7 waypointAttachVehicle _dropOffPosObj;
_wp7 setWaypointType "UNHOOK";
_wp7 setWaypointStatements ["true", "vehicle this flyInHeight [50, false]; vehicle this limitSpeed 200;"];


private _wp8 = _heliGRP addWaypoint [_returnPos, 0];
_wp8 setWaypointSpeed "FULL";
_wp8 setWaypointStatements ["true", "vehicle this land 'LAND'"];
_wp8 waypointAttachVehicle _returnPosObj;


/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
// adds the action to every client and JIP, but also adds it when it was already removed. E.g., Laptop has already been hacked by a player



/*
_cargoObj = cursorObject;
_helperObj = createVehicle ["Land_CargoBox_V1_F", [0,0,0]];
_helperObj allowDamage false;
//_helperObj hideObjectGlobal true;
_helperObj disableCollisionWith _cargoObj;

_offset = getCenterOfMass _cargoObj;

_helperObj setPos getPos _cargoObj;

_offset = _cargoObj get
_cargoObj attachTo [_helperObj, _offset];
*/


// config property: "slingLoadMaxCargoMass"

/*
[heli, cargo, DZ] call mum_common_fnc_airlift_cargo;
[heli_1, cargo_1, DZ] call mum_common_fnc_airlift_cargo;
[heli_2, cargo_2, DZ_1] call mum_common_fnc_airlift_cargo;
*/
