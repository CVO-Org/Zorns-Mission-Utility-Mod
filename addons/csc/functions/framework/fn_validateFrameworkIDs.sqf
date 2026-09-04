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
* ['#ALL', 'DESTINATIONS'] call mum_csc_fnc_validateFrameworkIDs
*/


params [
    [ "_entries", "#ALL",   ["", []] ],
    [ "_type",    "CRATES", [""]     ]
];


private _dataBase = switch (toUpperANSI _type) do {
    case "CRATES":        { GVAR(crates) };
    case "DESTINATIONS":  { GVAR(destinations) };
    case "DELIVERYMODES": { GVAR(deliveryModes) };
    default { createHashMap };
};

private _keys = keys _dataBase;

if (_entries isEqualTo "#ALL") exitWith { _keys };
if (_entries isEqualTo ["#ALL"]) exitWith { _keys };
if (_entries isEqualType "") then { _entries = [_entries]; };

// return validated/existing entries
private _return = _entries apply { toLowerANSI _x } select { _x in _keys };

_return
