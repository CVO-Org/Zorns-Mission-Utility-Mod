#include "../script_component.hpp"

/*
* Author: Zorn
* Init Function to establish the related EventHandlers
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

[
    QGVAR(EH_remote),
    {
        params ["_args", "_code"];
        _code = switch (typeName (_code)) do {
            case "STRING": { (_code) call CBA_fnc_convertStringCode; };
            case "CODE": { _code };
            default { {} };
        };
        _args call _code;
    }
] call CBA_fnc_addEventHandler;

[
    QGVAR(eh_toggleAIfeature),
    {
        params ["_units", "_mode", "_features"];

        // Recursive Function:
        // On individual Owner: toggle ai features per units - one unit per frame
        ZRN_LOG_MSG_3(Recieving Package:,count _units,_mode,_features);
        private _recursiveCode = {
            params ["_units", "_mode", "_features", "_recursiveCode"];

            private _unit = _units deleteAt 0;
            {
                switch (_mode) do {
                    case true:  { _unit  enableAI _feature };
                    case false: { _unit disableAI _feature };
                };
            } forEach _features;

            if (_units isEqualTo []) exitWith {};
            [_recursiveCode, [_units, _mode, _features, _recursiveCode]] call CBA_fnc_execNextFrame;
        };

        [_units, _mode, _features,_recursiveCode] call _recursiveCode;
    }
] call CBA_fnc_addEventHandler;


[
    QGVAR(EH_UnitIntoVehicle),
    {
        params ["_unit", "_slot"];
        _slot params  ["_role", "_vic", "_params"];

        moveOut _unit;

        private _statement = {
            params ["_unit", "_slot"];
            _slot params  ["_role", "_vic", "_params"];

            switch (_role) do {
                case "driver": {
                    _unit moveInDriver _vic;
                    _unit assignAsDriver _vic;
                };
                case "commander": {
                    _unit moveInCommander _vic;
                    _unit assignAsCommander _vic;
                };
                case "gunner": {
                    _unit moveInGunner _vic;
                    _unit assignAsGunner _vic;
                };
                case "turret": {
                    _unit moveInTurret [_vic, _params];
                    _unit assignAsTurret [_vic, _params];
                };
                case "cargo": {
                    _unit moveInCargo [_vic, _params, false];
                    _unit assignAsCargoIndex [_vic, _params];
                };
            };
        };
        [_statement, _this] call CBA_fnc_execNextFrame;
    }
] call CBA_fnc_addEventHandler;
