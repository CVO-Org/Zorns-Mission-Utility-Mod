#include "..\..\script_component.hpp"

/*
* Author: Zorn
* 3den Function for Intel Modules
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

        private _intelFunction = getText (configOf _logic >> "mum_intel_function") call CBA_fnc_convertStringCode;

        [_logic, _units, _isActivated] call _intelFunction;
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

        // VALIDATION 2: Check for Blacklisted Objects
        private _blacklistedConnections = _connections select { _x#1 call FUNC(isBlacklistedItem) };
        if (_blacklistedConnections isNotEqualTo []) then {
            _removeConnections append _blacklistedConnections;
            _errors pushBack "Blacklisted Objects synced - see RPT";
            _connections = _connections - _blacklistedConnections;
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
