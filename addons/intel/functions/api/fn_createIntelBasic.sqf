#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to create a basic Intel Item, formatted the same way as the "Intel Item - Basic" module. Server only - does nothing on clients.
*
* Arguments:
* 0: _objects       <OBJECT|ARRAY of OBJECTS>
*           Object(s) which shall be the intel. Each object becomes its own intel item.
*
* 1: _intelGroup    <STRING>  <OPTIONAL> <DEFAULT: "General">
*           Group Name of the Intel - Only used for the Intel Summary Feature.
*
* 2: _intelTitle    <STRING>  <OPTIONAL> <DEFAULT: "Intel">
*           The title of the Intel piece.
*
* 3: _intelDesc     <STRING>  <OPTIONAL> <DEFAULT: "">
*           Short description, shown in grey above the content. Empty string to skip.
*
* 4: _intelContent  <STRING>  <OPTIONAL> <DEFAULT: "">
*           Content of the Intel - Can be a simple String or Structured Text. Use <br/> for line breaks.
*
* 5-9: _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith <OPTIONAL>
*           Same as MUM_intel_fnc_createIntel arguments 4-8. Default Action Title: "Gather Intel..."
*
* Return Value:
* Success? <BOOLEAN>
*
* Example:
* [intel_depot_ledger, "Puesto Crow", "Supply Ledger", "A water-stained ledger, several pages torn out.", "Crates 23-25: lost in transit"] call MUM_intel_fnc_createIntelBasic;
*
* Public: Yes
*/

if !(isServer) exitWith { false };

params [
    ["_objects",        [],                 [objNull, []]  ],
    ["_intelGroup",     "General",          [""]           ],
    ["_intelTitle",     "Intel",            [""]           ],
    ["_intelDesc",      "",                 [""]           ],
    ["_intelContent",   "",                 [""]           ],
    ["_removeObject",   false,              [true]         ],
    ["_actionTitle",    "Gather Intel...",  [""]           ],
    ["_actionDuration", 15,                 [0]            ],
    ["_actionSound",    "AUTO",             [""]           ],
    ["_shareWith",      "DEFAULT",          [""]           ]
];

if (_objects isEqualType objNull) then { _objects = [_objects]; };
if (_objects isEqualTo []) exitWith { false };

// Compose Intel Body
private _content = "<br/>";
if (_intelDesc isNotEqualTo "") then { _content = _content + format [Q(<font COLOR_GREY face='RobotoCondensedLight'>%1</font><br/><br/>), _intelDesc]; };

_content = _content + _intelContent;

// Apply Intel
private _results = _objects apply {
    [_x, _intelTitle, _content, _intelGroup, _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith] call FUNC(createIntel)
};

!(false in _results)
