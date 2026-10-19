#include "../../script_component.hpp"

/*
* Author: Zorn
* Server function to handle a found intel item.
* Stores who the intel has been shared with (based on its "Share With" option) and publishes it to those players only.
*
* Arguments:
* 0: Intel ID <STRING>
* 1: Finder <OBJECT>
*
* Return Value:
* None
*
* Example:
* [QGVAR(EH_intelFound), ["mum_intel_0", player]] call CBA_fnc_serverEvent
*
* Public: No
*/

if (!isServer) exitWith {};

params ["_id", "_finder"];

// Already shared with the finder - for example, two players completing the action at the same time
if ([_finder, _id] call FUNC(hasBeenFoundByUnit)) exitWith {};

// Get Intel Data
private _intelData = missionNamespace getVariable _id;
private _intelTitle = _intelData getVariable "intelTitle";
// Inform Zeus
[
    QEGVAR(common,EH_zeusMessage),
    [format [localize LSTRING(PlayerFoundIntel), name _finder, _intelTitle]],
    allCurators
] call CBA_fnc_targetEvent;

// Who is this intel being shared with?
private _shareWith = _intelData getVariable "shareWith";
if (_shareWith isEqualTo "DEFAULT") then { _shareWith = SET(default_shareWith); };

private _targets = switch (toUpper _shareWith) do {
    case "GLOBAL": {
        _intelData setVariable ["foundByAll", true, true];

        call CBA_fnc_players
    };
    case "SIDE": {
        private _targetSide = side group _finder;
        private _foundBySide = _intelData getVariable "foundBySide";
        _foundBySide pushBackUnique _targetSide;
        _intelData setVariable ["foundBySide", _foundBySide, true];

        (call CBA_fnc_players) select { side group _x isEqualTo _targetSide }
    };
    case "GROUP": {
        private _targetGroup = group _finder;
        private _foundByGroup = _intelData getVariable "foundByGroup";
        _foundByGroup pushBackUnique _targetGroup;
        _intelData setVariable ["foundByGroup", _foundByGroup, true];

        units _targetGroup select { isPlayer _x }
    };
    // "UNIT" - only the finder
    default { [] };
};

// Always add the finder
private _foundByUnit = _intelData getVariable "foundByUnit";
_foundByUnit pushBackUnique _finder;
_intelData setVariable ["foundByUnit", _foundByUnit, true];

_targets pushBackUnique _finder;

// Publish Intel to targets - JIP players are handled via FUNC(handleJIP)
[QGVAR(EH_publishIntel), _this, _targets] call CBA_fnc_targetEvent;


// Delete Object - otherwise the action stays available for those who have not received the intel
private _object = _intelData getVariable "object";
if (_intelData getVariable "objectRemove") then { deleteVehicle _object; };
