#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Draw the Icons on the map control.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/


params ["_display", "_mapCTRL"];



#define COLOR_ACTIVE [0.412, 0.00, 0.00, 1.00]
#define ICON_SIZE_ACTIVE 32

#define COLOR_PASSIVE [0.00, 0.00, 0.00, 0.25]
#define ICON_SIZE_PASSIVE 24

// Add Departure Marker
private _departure = _display getVariable QGVAR(departure);
_departure = switch (true) do {
    case (_departure isEqualType []): { _departure };
    case (_departure isEqualType objNull): { getPos _departure };
    default { getPos ACE_player };
};

private _queue = [];
_queue pushBack ["\A3\ui_f\data\map\markers\military\start_CA.paa", COLOR_ACTIVE, _departure, ICON_SIZE_ACTIVE, ICON_SIZE_ACTIVE, 0, "Departure"];

private _mapPosArray = [];
_mapPosArray pushBack _departure;

// handle remaining destination markers
private _curSel_index = _display getVariable [QGVAR(curSel_index), -1];
private _network = _display getVariable QGVAR(network);
private _destinations = _network get "destinations";
_destinations = _destinations apply { [_x get "destinationID", _x get "target"] };
_destinations = _destinations apply {
    [
        _x#0,
        switch (true) do {
            case (_x#1 isEqualType []): { _x#1 };
            case (_x#1 isEqualType objNull): { getPos (_x#1) };
            default { getPos ACE_player };
        }
    ]
};

switch (_curSel_index) do {
    case -1: {
        {
            _queue pushBack ["\A3\ui_f\data\map\markers\military\end_CA.paa", COLOR_PASSIVE, _x#1, ICON_SIZE_PASSIVE, ICON_SIZE_PASSIVE, 0, "Destination"];
            _mapPosArray pushBack _x#1;
        } forEach _destinations;
    };
    default {
        private _listControl = _display displayCtrl 1500;
        private _destinationID  = _listControl lbData _curSel_index;

        private _destinationIndex = _destinations findIf { _x#0 isEqualTo _destinationID };
        private _selDestination = _destinations deleteAt _destinationIndex;

        _mapPosArray pushBack _selDestination#1;        
        
        _queue pushBack ["\A3\ui_f\data\map\markers\military\end_CA.paa", COLOR_ACTIVE, _selDestination#1, ICON_SIZE_ACTIVE, ICON_SIZE_ACTIVE, 0, "Destination"];

        { _queue pushBack ["\A3\ui_f\data\map\markers\military\end_CA.paa", COLOR_PASSIVE, _x#1, ICON_SIZE_PASSIVE, ICON_SIZE_PASSIVE, 0, "Destination"]; } forEach _destinations;
    };
};


// Handle the Map Frame
[_mapPosArray, true] call EFUNC(common,getMedianPosASL) params ["_medianPos", "", "_maxRadius"];
private _scale = linearConversion [500, 0.4 * worldSize * sqrt 2, _maxRadius*2, 0.03, 1, true];
_mapCTRL ctrlMapAnimAdd [0.5, _scale, _medianPos];
ctrlMapAnimCommit _mapCTRL;


// Store queue of to be drawn icons on the map control
_mapCTRL setVariable [QGVAR(queue), _queue];

// Start Draw Icon Per Frame Handler if not established yet
private _drawIcon_handle = _display getVariable [QGVAR(drawIcon_handle), nil];
if (isNil "_drawIcon_handle") then {
    _drawIcon_handle = [
        {
            _this#0 params ["_mapCTRL"];
            { _mapCTRL drawIcon _x } forEach (_mapCTRL getVariable [QGVAR(queue), []]);
        },
        0,
        _mapCTRL
    ] call CBA_fnc_addPerFrameHandler;
    _display setVariable [QGVAR(drawIcon_handle), _drawIcon_handle];
};

