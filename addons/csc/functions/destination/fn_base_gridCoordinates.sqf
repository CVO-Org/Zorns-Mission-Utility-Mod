#include "../../script_component.hpp"

/*
* Author: Zorn
* Client destination handler: opens UI to enter grid coordinates.
*
* Arguments:
* 0: _request - Request hashmap (not directly used). <HASHMAP>
* 1: _parameters - Destination parameters hashmap (not directly used). <HASHMAP>
*
* Return Value:
* String - Variable name to wait for position, or false on cancel <STRING or BOOL>
*
* Example:
* [requestHashMap, parametersHashMap] call mum_csc_fnc_base_mapClick
*
* Public: No
*/

params ["_request", "_parameters"];


[FUNC(grid_openDialog), _this] call CBA_fnc_execNextFrame;

// return varname as string
QGVAR(waitForGridCoordinates)
