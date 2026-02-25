#include "../../script_component.hpp"

/*
* Author: Zorn
*
* Function to handle objects within a layer.
*
* - /!\ Only Executable on Server /!\ getMissionLayerEntities only works on the server.
*
* - Can handle multiple modes at once
* - Recursive function: adjusts 1 adjustment per iteration.
*   - Dynamic delay: default: 0.1s delay between. if set to 0 one iteration per frame.
*
*
* Arguments:
*     0:     _layerName        <STRING>             Name of the Editor Layer
*    1:    _mode            <BOOL>                Controls mode: true: Enable - false: Disable
*    2:    _feature        <STRING or ARRAY>    What ai feature to toggle. see link above for more details.
*
* Return Value:
* None
*
*
* Example:
* ["ambush1", "DELETE"] call mum_common_fnc_layerObjects; // enable units of the layer
*
* Public: yes
*/

if !(isServer) exitWith {};

params [
    [ "_layerName",    "",     [""]     ],
    [ "_modes",     [],     ["", []] ],
    [ "_delay",     0.1,     [0]      ]
];


// Get Objects from Layer
getMissionLayerEntities _layerName params [["_objects", []], ["_markers", []], ["_groups", []]];

if (_objects isEqualTo []) exitWith {};

if (_modes isEqualType "") then { _modes = [_modes]; };


private _recursiveNotRunning = isNil QGVAR(layerObjects_queue);

// [obj, code, delay]
private _queue = if (_recursiveNotRunning) then {
    GVAR(layerObjects_queue) = []; GVAR(layerObjects_queue)
} else {
    GVAR(layerObjects_queue)
};

// custom Handling for "DELETE"
if ("DELETE" in _modes) then {

    // Sets Groups within this layer to be deleted when empty.
    { _queue pushBack [_x, { [QGVAR(EH_remote), [_this, { _this deleteGroupWhenEmpty true; }], _this] call CBA_fnc_targetEvent; }, _delay ]; } forEach _groups;
    // Deletes Markers of the targeted Layer
    { _queue pushBack [_x, { deleteMarker _this }, _delay ]; } forEach _markers;
    // Deletes the Objects
    { _queue pushBack [_x, { deleteVehicle _this }, _delay ] } forEach _objects;

} else {

    {
        switch (toUpper _x) do {
            case "ENABLE":  { _modes append ["SIM_ON", "HIDE_OFF"]; };
            case "DISABLE": { _modes append ["SIM_OFF", "HIDE_ON"]; };
            case "SIM_ON":  { { _queue pushBack [_x, { _this enableSimulationGlobal true;  }, _delay ] } forEach _objects; };
            case "SIM_OFF": { { _queue pushBack [_x, { _this enableSimulationGlobal false; }, _delay ] } forEach _objects; };
            case "HIDE_ON":  { { _queue pushBack [_x, { _this hideObjectGlobal true;  }, _delay ] } forEach _objects; };
            case "HIDE_OFF": { { _queue pushBack [_x, { _this hideObjectGlobal false; }, _delay ] } forEach _objects; };
            default { };
        };
    } forEach _modes;

};


// Start recursive Function
if(_recursiveNotRunning) then {

    private _recursiveCode = {
        params ["_recursiveCode"];

        private _queue = missionNamespace getVariable [QGVAR(layerObjects_queue), []];
        if (_queue isEqualTo []) exitWith { missionNamespace setVariable [QGVAR(layerObjects_queue), nil] };

        _queue deleteAt 0 params ["_obj", "_code", "_delay"];
        _obj call _code;

        if (_delay == 0) then {
            [_code, _code] call CBA_fnc_execNextFrame;
        } else {
            [_recursiveCode, _recursiveCode, _delay] call CBA_fnc_waitAndExecute;
        }
    };

    [_recursiveCode] call _recursiveCode;
};
