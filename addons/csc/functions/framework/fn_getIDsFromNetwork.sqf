#include "../../script_component.hpp"

/*
* Author: Zorn
* Returns an Array of IDs based upon Network and Type (Crate, Destination or Delivery Mode)
*
* Arguments:
* Network <STRING>
* TYPE <STRING>
*
* Return Value:
* Array of data ID's
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
    [ "_network", "ALL", [""] ],
    [ "_type", "CRATES", [""] ]
];

private _networks = missionNamespace getVariable QGVAR(networks);

if (isNil "_networks") exitWith { false };

private _dataBase = switch (toUpperANSI _type) do {
    case "CRATES":         { GVAR(crates) };
    case "DESTINATIONS":   { GVAR(destinations) };
    case "DELIVERY_MODES": { GVAR(delivery_modes) };
    default { false };
};

private _keys = keys _dataBase;

// return
switch (true) do {
    case (_network isEqualTo "ALL"): { _keys };
    case (_network in _networks): {
        // get Keys from network
        private _ids = _networks get _network get _type;
        // Validate and return
        _ids select { _x in _keys }
    };
    default { false };
};
