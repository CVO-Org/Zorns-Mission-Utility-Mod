#include "../../script_component.hpp"

/*
* Author: Zorn
* Retrieves registered IDs filtered by network and type.
*
* Arguments:
* 0: _network - Network identifier, use '#ALL' for all networks <STRING> (default: '#ALL')
* 1: _type - Type filter: 'CRATES', 'DESTINATIONS', or 'DELIVERYMODES' <STRING> (default: 'CRATES')
*
* Return Value:
* Array of registered ID strings matching filter, or false if none found <ARRAY or BOOL>
*
* Example:
* ['#ALL', 'DESTINATIONS'] call mum_csc_fnc_getIDsFromNetwork
*
* Public: No
*/



params [
    [ "_network", "#ALL",   [""] ],
    [ "_type",    "CRATES", [""] ]
];

private _networks = missionNamespace getVariable QGVAR(networks);



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



_return
