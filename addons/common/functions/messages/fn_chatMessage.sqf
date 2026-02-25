#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to simplify the usage of the sideChat, groupChat, ...
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [ "High Command", "420 blaze it" ] call mum_common_fnc_chatMessage;
*
* Public: No
*/


params [
    ["_sender",     "Jimmethy",     ["", objNull, []], [1,2] ],
    ["_message",    "TestMessage",  [""]                     ],
    ["_type",       "sidechat",     [""]                     ]
    //["_addParams",  createHashMap,   [createHashMap]         ]
];

private _unit = switch (typeName _sender) do {
    case "OBJECT": { _sender };
    case "STRING";
    case "ARRAY": {
        _sender params [ "_identity", [ "_side", playerSide ] ];

        // Sanitize Side
        if (_side isEqualType "") then { _side = toUpperANSI _side };
        _side = switch (_side) do {
            case "WEST": { west };
            case "EAST": { east };
            case "GUER": { independent };
            case "CIV":  { civilian };
            default {
                switch (true) do {
                    case (_side in [west, east, independent, civilian]): { _side };
                    default { playerSide };
                };
            };
        };
        // get or Create Unit
        [_identity, _side] call FUNC(getSenderUnit) // return
    };
};

[ CBA_fnc_globalEvent, [ QGVAR(EH_chatMessage), [ _unit, _message, _type ] ] ] call CBA_fnc_execNextFrame;
