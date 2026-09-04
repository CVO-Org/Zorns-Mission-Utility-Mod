#include "../../script_component.hpp"

/*
* Author: Zorn
* PostInit - Creates ACE Zeus self-action for CSC access.
* Retrieves all registered crates/destinations/deliveryModes, registers Zeus action.
*
* Arguments:
* None
*
* Return Value:
* nil
*
* Example:
* [] call mum_csc_fnc_createAccessPointZeus
*
* Public: Yes
*/

private _accessPointID =  "#ZEUS";

private _conditionCode = { true };

private _aceAction = [_accessPointID, _conditionCode] call FUNC(createAction);

[
    ["ACE_ZeusActions"]                      // * 0: Parent path of the new action (e.g. ["ACE_ZeusActions"]) <ARRAY>
    ,_aceAction                                 // * 1: Action <ARRAY>
] call ace_interact_menu_fnc_addActionToZeus;
