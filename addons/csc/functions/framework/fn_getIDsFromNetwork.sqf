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

diag_log format ['[CVO](debug)(fn_getIDsFromNetwork) _this: %1', _this];

params [
    [ "_network", "#ALL",   [""] ],
    [ "_type",    "CRATES", [""] ]
];

private _networks = missionNamespace getVariable QGVAR(networks);

diag_log format ['[CVO](debug)(fn_getIDsFromNetwork) _networks: %1', _networks];

if (isNil "_networks") exitWith { false };

private _dataBase = switch (toUpperANSI _type) do {
    case "CRATES":        { GVAR(crates) };
    case "DESTINATIONS":  { GVAR(destinations) };
    case "DELIVERYMODES": { GVAR(deliveryModes) };
    default { createHashMap };
};

private _keys = keys _dataBase;

// return
private _return = switch (true) do {
    case (_network isEqualTo "#ALL"): { _keys };
    case (_network in _networks): {
        // get Keys from network
        private _ids = _networks get _network get _type;
        // Validate and return
        _ids select { _x in _keys }
    };
    default { [] };
};

diag_log format ['[CVO](debug)(fn_getIDsFromNetwork) _return: %1', _return];

_return
