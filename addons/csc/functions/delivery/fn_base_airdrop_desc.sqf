#include "../../script_component.hpp"

/*
* Author: Zorn
* Delivery - Description Function for AirDrops
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

params ["_cfg"];

private _airframeDisplayName = getText (configFile >> "CfgVehicles" >> getText (_cfg >> "parameters" >> "airframe_class") >> "displayName");

format [
" will be air-dropped by %1 %2 at %3 meters ATL.",
["a", "an"] select ( toLower (_airframeDisplayName select [0,1]) in ["a", "e", "i", "o", "u", "1", "8"] ),
_airframeDisplayName,
getNumber (_cfg >> "parameters" >> "airdrop_alt")
] // return

