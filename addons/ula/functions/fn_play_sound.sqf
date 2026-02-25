#include "..\script_component.hpp"


/*
* Author: Zorn
* [Description]
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call MUM_fnc_sth
*
* Public: Yes
*/

if (!hasInterface) exitWith {};

params [
    ["_soundSourceOBJ",     objNull,    [objNull]   ],
    ["_type",               "",         [""]        ]
];

if  (_soundsourceOBJ isEqualTo objNull) exitWith {false};
if !(_type in ["PLACE", "BREAK"]) exitWith {false};

private _sound = switch (_type) do {
    case "PLACE": { selectRandom [QGVAR(place_1),QGVAR(place_2),QGVAR(place_3),QGVAR(place_4)] };
    case "BREAK": { QGVAR(broke) };
    default { "" };
};

if (_type isEqualTo "BREAK") then {
    _soundSourceOBJ = createVehicleLocal ["Helper_Base_F",_soundSourceOBJ];
    [ {
        if (isNil "_this" ) exitWith {};
        deleteVehicle _this;
    } , _soundSourceOBJ, 3] call CBA_fnc_waitAndExecute;
};

_soundSourceOBJ say3D _sound;
true
