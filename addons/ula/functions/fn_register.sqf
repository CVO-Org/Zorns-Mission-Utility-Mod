#include "..\script_component.hpp"


/*
* Author: Zorn
* This function will do all the setup needed. It is to be apllied on the box "that carries the building supplies".
*
* Create an action on an object to simulate the building of "something", by unhiding a layer based on the name of the layer.
*
* Arguments:
* 0 <OBJECT>            _object         <REQUIRED>          the object that acts as the "building supplies crate" which has the action attached to it.
* 1 <ARRAY of STRINGS>  _layers         <REQUIRED>          Array of Layernames: One crate can be used for multiple layers.
* 2 <NUMBER>            _distance       <DEFAULT: 25>       Minimum Distance the Object needs to be from the Median Position of the Layer
* 3 <NUMBER>            _time           <DEFAULT: 5>        The time it takes per individual entity to be placed. On a dedicated Multiplayer Server, this has a lower limit of 1s.
* 4 <BOOLEAN>           _playSound      <DEFAULT: true>     Toggles if a soundeffect should be played when an object is revealed or the supplyer object gets deleted
* 5 <BOOLEAN>           _blockInput     <DEFAULT: false>    Toggles if the player's input are being blocked by the progress bar.
*
* Return Value:
* None
*
* Example:
* [this, ["SIGINT at Comms Alpha", "SIGINT at Comms Alpha"]] call MUM_ula_fnc_register;
* [this, ["SIGINT at Comms Alpha", "SIGINT at Comms Alpha"], 25, 5, true, true] call MUM_ula_fnc_register;
*
* Public: Yes
*/


if (!isServer) exitWith {};

params [
    ["_obj",        objNull,        [objNull]       ],
    ["_layers",     [],             [[]]            ],
    ["_distance",   25,             [0]             ],
    ["_time",       5,              [0]             ],
    ["_playSound",  true,           [true]          ],
    ["_blockInput", false,          [true]          ]
];

diag_log "[MUM](debug)(fn_register) Init";

if (_obj isEqualTo objNull) exitWith {false};
if (_layers isEqualTo []) exitWith {false};
if (_distance <= 0) exitWith {false};

_obj setVariable [QGVAR(playSound), _playSound, true];
_obj setVariable [QGVAR(blockInput), _blockInput, true];
_obj setVariable [QGVAR(size), boundingBoxReal _obj # 2, true];


// In case of Dedicated MP Server, a minimum time of 1 is being enforced to avoid spamming the Network.
if (     isMultiplayer
    && { isDedicated
    && { !(missionNamespace getVariable [QGVAR(ignoreTimeLimiter), false]) }}
    ) then { _time = _time max 1; };

// Initialises the layer's HMO
{
    private _layerName = _x;
    [_obj, _layerName, _distance, _time] call FUNC(init_layer);
    [QGVAR(EH_addAction), [_obj, _layerName, _distance, _time]] call CBA_fnc_globalEventJIP;
} forEach _layers;

private _attachedLayers = _obj getVariable [QGVAR(layers), []];
_attachedLayers append _layers;

diag_log "[MUM](debug)(fn_register) Done";
true
