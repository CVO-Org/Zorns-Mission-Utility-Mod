#include "../../script_component.hpp"

/*
* Author: Zorn
* Radio Message Function to be used remotely
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

params [ "_unit", "_message", "_type" ];

switch (toLower _type) do {
    case "globalchat":  { _unit globalChat _message; };
    case "sidechat":    { _unit sideChat _message; };
    case "groupchat":   { _unit groupChat _message; };
    case "vehiclechat": { _unit vehicleChat _message; };
    case "commandchat": { _unit commandChat _message; };
    default {};
};
