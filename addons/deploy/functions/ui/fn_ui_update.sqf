#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to update the Cvo Deploy UI.
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

params ["_display"];

// Get Network Destinations
private _network = _display getVariable QGVAR(network);
private _destinations = _network get "destinations";
_destinations = _destinations apply { [_x get "destinationID", _x] };   // [destID, destination]

// Get CT_Listbox Items
private _listControl = _display displayCtrl 1500;
private _listAmount = lbSize _listControl;
private _listItems = if (_listAmount == 0) then { [] } else {
    private _return = []; // [destinationID, list_index ]
    for "_listIndex" from 0 to (_listAmount -1) do { _return pushBack [_listControl lbData _listIndex, _listIndex]; };
    _return
};

// Identify what what needs be done and add to the queue
private _queue = []; // [Task, destination, destinationID, listIndex]

// Handle all current Destinations
{
    _x params ["_destinationID", "_destination"];
    private _index = _listItems findIf { _x#0 isEqualTo _destinationID };
    if (_index == -1) then {
        _queue pushBack ["ADD", _destination, _destinationID, -1];
    } else {
        _listItems deleteAt _index params ["", "_listIndex"];
        _queue pushBack ["UPDATE", _destination, _destinationID, _listIndex];
    };
} forEach _destinations;

// Remove remaining list Items, as there is  longer valid destination for them
{ _queue pushBack ["REMOVE", nil, nil, _x#0]; } forEach _listItems;

// Process the queue
{
    _x params ["_task", "_destination", "_destinationID", "_listIndex"];

    switch (_task) do {
        case "ADD": {
            _listIndex = _listControl lbAdd ([_destination] call FUNC(getName));
            _listControl lbSetData [_listIndex, _destinationID];
        };
        case "REMOVE": {
            _listControl lbDelete _listIndex;
        };
        case "UPDATE": {
            _listControl lbSetText [_listIndex, ([_destination] call FUNC(getName))];
        };
        default {};
    };
} forEach _queue;


// UPDATE: OKButton and Status Text
// Get the currently selected Index and store
private _curSelIndex = lbCurSel _listControl;
_display setVariable [QGVAR(curSel_index), _curSelIndex];

// Handle Specific Cases 
// Later: Handle "busy" destination check here
private _state = switch (true) do {
    case (_curSelIndex == -1): { "NONE" };
    default { true };
};

private _ctrlButtonOK = _display displayCtrl 1;
private _ctrlStatusText = _display displayCtrl 1003;

if (_state isEqualTo true) then {

    // Can Fasttravel
    _ctrlButtonOK ctrlEnable true;
    _ctrlStatusText ctrlSetText "You can deploy to the selected destination!";


} else {
    // Can not Fasttravel

    private _str = switch (_state) do {
        case "BUSY": { "The selected destination is currently busy!" }; // will be used later
        case "NONE": { "No Destination selected!" };
        default { "No valid destination selected!" };
    };

    _ctrlButtonOK ctrlEnable false;
    _ctrlStatusText ctrlSetText _str;

};
