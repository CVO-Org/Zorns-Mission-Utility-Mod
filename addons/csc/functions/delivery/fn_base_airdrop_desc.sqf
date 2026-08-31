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

params ["_deliveryMap"];

private _airframeDisplayName = getText (configFile >> "CfgVehicles" >> _deliveryMap get "parameters" get "airframe_class" >> "displayName");

format [
"Will be air-dropped by %1 %2 at %3 meters ATL.",
["a", "an"] select ( toLower (_airframeDisplayName select [0,1]) in ["a", "e", "i", "o", "u", "1", "8"] ),
_airframeDisplayName,
_deliveryMap get "parameters" get "airdrop_alt"
] // return

