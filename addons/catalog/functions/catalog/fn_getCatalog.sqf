#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to retrieve a catalog (hashmap) and creating it if needed.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ["arsenal_kits"] call cvo_catalog_Fnc_getCatalog
*
* Public: No
*/

params [
    [ "_catName", "", [""] ]
];

if (_catName isEqualTo "") exitWith { false };

private _catalogName = if (QPREFIX in _catName) then {
    _catName
} else {
    [QPREFIX,_catName] joinString "_"
};

private _catalog = missionNamespace getVariable [ _catalogName , nil ];

if (isNil "_catalog") then {
    _catalog = createHashMap;
    missionNamespace setVariable [ _catalogName, _catalog ];
};

_catalog
