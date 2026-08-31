#include "..\..\script_component.hpp"

/*
* Author: Zorn
* 3den Function for the Register Crate (Synced) module
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
	["_mode", "", [""]],
	["_input", [], [[]]]
];

switch _mode do {
	// Default object init
	case "init": {
        _input params [
			["_logic", objNull, [objNull]],		// Module logic
			["_isActivated", true, [true]],		// True when the module was activated, false when it is deactivated
			["_isCuratorPlaced", false, [true]]	// True if the module was placed by Zeus
		];

        private _units = synchronizedObjects _logic;
        [_logic, _units, _isActivated] call FUNC(module_registerCrate_Init);
	};


	// When connection to object changes (i.e., new one is added or existing one removed)
	case "connectionChanged3DEN": {

        if (!is3DEN) exitWith {};

		_input params [ ["_logic", objNull, [objNull]] ];


        // [[Type, counterpart]]
        private _connections = get3DENConnections _logic;

        private _removeConnections = []; // Collect all invalid connections to remove
        private _errors = ["The following error occoured:"]; // Collect validation error messages

        // VALIDATION 1: Only allow Connections of the type "Sync"
        private _wrongTypeConnections = _connections select { _x#0 isNotEqualTo "Sync" };
        if (_wrongTypeConnections isNotEqualTo []) then {
            _removeConnections append _wrongTypeConnections;
            _errors pushBack "Only Sync-Connections are valid";
            _connections = _connections - _wrongTypeConnections;
        };

        // VALIDATION 2: Connected object must be kindOf "B_supplyCrate_F"
        private _wrongObjectsConnections = _connections select { !(_x#1 isKindOf "B_supplyCrate_F") };
        if (_wrongObjectsConnections isNotEqualTo []) then {
            _removeConnections append _wrongObjectsConnections;
            _errors pushBack "Synced objects must inherit from B_supplyCrate_F (Dont ask me why :sob:)";
            _connections = _connections - _wrongObjectsConnections;
        };

        // VALIDATION 3: Only allow one synced object
        if (count _connections > 1) then {
            private _surplusConnections = + _connections;
            _surplusConnections deleteAt 0;
            _removeConnections append _surplusConnections;
            _errors pushBack "Only one object can be synced to the module";
        };



        // No Invalid Connections? Exit without action
        if (_removeConnections isEqualTo []) exitWith {};

        // Remove faulty connections
        { remove3DENConnection [_x#0, [_logic], _x#1] } forEach _removeConnections;

        // Error Message
        [
            _errors joinString "<br />  - ",
            "Error: Module Connections",
            true,
            false
        ] call BIS_fnc_3DENShowMessage;
	};
};
true;
