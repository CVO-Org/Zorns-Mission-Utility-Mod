#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Check which intel group has how many discovered intel items
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

private _catalog = [QGVAR(catalog)] call EFUNC(catalog,getCatalog);

private _map = createHashMap;


{
    // private _id = _x;
    private _intelData = _y;

    private _intelGroup = _intelData getVariable "intelGroup";
    private _hasBeenFound = _intelData getVariable "found";

    if (_intelGroup in keys _map) then {
        private _entry = _map get _intelGroup;

        _entry set ["total", (_entry get "total") + 1];

        if (_hasBeenFound) then {
            _entry set ["found", (_entry get "found") + 1];
        };

    } else {
        _map set [
            _intelGroup,
            createHashMapFromArray [
                ["total", 1],
                ["found", [0,1] select _hasBeenFound ]
            ]
        ];
    };

} forEach _catalog;

private _return = keys _map;
_return sort true;

_return apply {
    [
        _x,
        _map get _x get "found",
        _map get _x get "total"
    ]
}  // Return
