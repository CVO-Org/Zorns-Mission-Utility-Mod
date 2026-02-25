#include "../script_component.hpp"

/*
* Author: Zorn
* This function registers a layername, which objects are to be deleted once a layer to be revealed has been completely revealed.
* Useful for large compositions. The _deleteLayer can contain flags or other marker objects to indicate the "building zone" towards the players.
*
* Arguments:
* 0 <STRING>    _revealLayer    Layername of the Layer which will be revealed. (Needs to be setup already by MUM_ula_fnc_register)
* 1 <STRING>    _deleteLayer    Layername of the Layer which will be deleted once _revealLayer has been fully revealed.
*
* Return Value:
* None
*
* Example:
* ["MyBunker", "MyBunkerMarkerFlags"] call MUM_ula_fnc_register_cleanup
*
* Public: Yes
*/

if !(isServer) exitWith {};

params [
    ["_revealLayer",    "404", [""]     ],
    ["_deleteLayer",    "404", [""]     ]
];

if (_revealLayer isEqualTo "404") exitWith {};
if (_deleteLayer isEqualTo "404") exitWith {};

private _hashMap = missionNamespace getVariable [QGVAR(HM_Delete), "404"];
if (_hashMap isEqualTo "404") then {_hashMap = createHashMap};

_hashMap set [_revealLayer, _deleteLayer];

missionNamespace setVariable [QGVAR(HM_Delete), _hashMap];


// Server Event
if (isNil QGVAR(EHID_deleteLayer)    ) then { GVAR(EHID_deleteLayer) = [QGVAR(EH_completed), FUNC(delete_layer)] call CBA_fnc_addEventHandler; };
