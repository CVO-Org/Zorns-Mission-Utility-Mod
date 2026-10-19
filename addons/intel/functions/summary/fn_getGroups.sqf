#include "../../script_component.hpp"

/*
* Author: Zorn
* Returns, per intel group, how many intel items the local player has found out of the total.
*
* Arguments:
* None
*
* Return Value:
* Intel groups, sorted by name <ARRAY>
*    Each: [Group name <STRING>, Found <NUMBER>, Total <NUMBER>]
*
* Example:
* [] call mum_intel_fnc_getGroups
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
