#include "../../script_component.hpp"

/*
* Author: Zorn
* Function which makes the provided object fully static. no actions, no scrollwheel, no nothin'
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [this] call mum_common_fnc_makeCosmetic;
*
* Public: No
*/

#define INITIAL_DELAY 1

params [ "_object", "_effects"];

{
    //Server effects
    if (isServer) then {
        switch (_x) do {
            case "LOCK_VEHICLE":    { _object lock true; };
            case "DISABLE_SIM":     { _object enableSimulationGlobal false; };
            case "DESTROY":         { _object setDamage 1; };
        };
    };

    // Local effects
    if (hasInterface) then {
        switch (_x) do {
            case "LOCK_INVENTORY":  { _object lockInventory true; };
            case "REM_ACTIONS":     { removeAllActions _object; };
            case "ACE_CLAIM":       { [_object, _object] call ace_common_fnc_claim; };
        };
    };

} forEach _effects;
