#include "../../script_component.hpp"

/*
* Author: Zorn
* Returns formatted description text for airdrop delivery mode.
*
* Arguments:
* 0: _deliveryMap - Delivery mode configuration hashmap with parameters and airframe info. <HASHMAP>
*
* Return Value:
* Formatted description string with airframe name and altitude info <STRING>
*
* Example:
* [deliveryMapHashMap] call mum_csc_fnc_base_airdrop_desc
*
* Public: No
*/

params ["_deliveryMap"];

private _airframeDisplayName = getText (configFile >> "CfgVehicles" >> _deliveryMap get "parameters" get "airframe_class" >> "displayName");

format [
    "<t color='#B3B3B3'>Will be air-dropped by %1</t> %2 <t color='#B3B3B3'>at</t> %3 meters ATL.",
    ["a", "an"] select ( toLower (_airframeDisplayName select [0,1]) in ["a", "e", "i", "o", "u", "1", "8"] ),
    _airframeDisplayName,
    _deliveryMap get "parameters" get "airdrop_alt"
] // return

