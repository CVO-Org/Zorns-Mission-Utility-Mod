#include "..\script_component.hpp"

/*
* Author: Zorn
* Function to apply the Icon on the Server
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

#define PATH_SL Q(a3\ui_f\data\map\vehicleicons\iconManOfficer_ca.paa)
#define PATH_TL Q(a3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa)

if (!isServer) exitWith {};

params [
    ["_unit", objNull, [objNull] ],
    ["_type", "NIL",   [""]      ]
];

switch (toUpperANSI _type) do {
    case "SL":  { _unit setVariable ["diwako_dui_radar_customIcon", PATH_SL, true ] };
    case "TL":  { _unit setVariable ["diwako_dui_radar_customIcon", PATH_TL, true ] };
    case "NIL": { _unit setVariable ["diwako_dui_radar_customIcon", nil,     true ] };
};
