#include "../../script_component.hpp"

/*
* Author: Zorn
* Returns fixed position from destination configuration.
* Supports optional random radius offset around base position.
*
* Arguments:
* 0: _request - Request hashmap (not used in this function). <HASHMAP>
* 1: _parameters - Destination parameters hashmap with pos and optional radius. <HASHMAP>
*
* Return Value:
* Array [x, y, z] position <ARRAY>
*
* Example:
* [requestHashMap, parametersHashMap] call mum_csc_fnc_base_fixedPos
*
* Public: No
*/

params [ "_request", "_parameters" ];




private _position = _parameters getOrDefault ["position", [0,0,0]];

private _radius = _parameters getOrDefault ["radius", 0];

if (_radius isNotEqualTo 0) then { _position = _position getPos [ random _radius, random 360 ]; };

_position
