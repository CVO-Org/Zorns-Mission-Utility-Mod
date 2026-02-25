#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to get the diameter of bounding spehere based on its classname using "sizeOf".
* Will handle creation of object to take messurement if need be as well as storing it in a global hashmap for later use.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [_className] call mum_common_fnc_getSizeOf
*
* Public: No
*/

params [
    [ "_className", "", [""] ]
];

if (isNil QGVAR(db_sizeOf)) then { GVAR(db_sizeOf) = createHashMap; };
private _db = GVAR(db_sizeOf);

if (_className in keys _db) then {
    _db get _className // return
} else {
    private _obj = _className createVehicleLocal [0,0,0];
    private _size = sizeOf _className;
    _db set [_className, _size];
    deleteVehicle _obj;
    _size // return
}
