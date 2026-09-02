#include "..\..\script_component.hpp"

/*
* Author: Zorn
* INIT Module Function to register a Destination (relativeTo Position).
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

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];



private _data = createHashMap;

// Common Module Attributes
{ _data set [_x, _logic getVariable _x]; } forEach [ "id", "displayName", "description_string" ];

// Hard Data
_data set [ "code", QFUNC(base_relativeTo) ];


// Parameters
private _reference = _logic getVariable "reference";

if (_reference isEqualTo "" && { _units isNotEqualTo [] }) then {
    private _obj = _units select 0;
    _reference = [_obj, QADDON + "_ref_"] call BIS_fnc_objectVar;
};


_data set [
    "parameters",
    createHashMapFromArray [
        ["reference",    _reference                        ],
        ["mode",         _logic getVariable "mode"         ],
        ["offset",       _logic getVariable "offset"       ],
        ["randomOffset", _logic getVariable "randomOffset" ]
    ]
];

//Store Data
[_data] call FUNC(registerDestination);
