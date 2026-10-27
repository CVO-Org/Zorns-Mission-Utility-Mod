#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to create an Intel Item formatted as a handwritten note, the same way as the "Intel Item - Handwritten Note" module. Server only - does nothing on clients.
*
* Arguments:
* 0: _objects       <OBJECT|ARRAY of OBJECTS>
*           Object(s) which shall be the intel. Each object becomes its own intel item.
*
* 1: _intelGroup    <STRING>  <OPTIONAL> <DEFAULT: "General">
*           Group Name of the Intel - Only used for the Intel Summary Feature.
*
* 2: _intelTitle    <STRING>  <OPTIONAL> <DEFAULT: "Handwritten Note">
*           The title of the Intel piece.
*
* 3: _intelDesc     <STRING>  <OPTIONAL> <DEFAULT: "">
*           Short description, shown in grey above the content. Empty string to skip.
*
* 4: _noteText      <STRING>  <OPTIONAL> <DEFAULT: "">
*           Text of the note, shown in a handwritten font. Use <br/> for line breaks.
*
* 5-9: _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith <OPTIONAL>
*           Same as MUM_intel_fnc_createIntel arguments 4-8. Default Action Title: "Investigate the note..."
*
* Return Value:
* Success? <BOOLEAN>
*
* Example:
* [intel_bridge_note, "North Bridge", "Note to the Night Shift", "A crumpled note.", "Let the white truck through. No questions."] call MUM_intel_fnc_createIntelHandwrittenNote;
*
* Public: Yes
*/

if !(isServer) exitWith { false };

params [
    ["_objects",        [],                         [objNull, []]  ],
    ["_intelGroup",     "General",                  [""]           ],
    ["_intelTitle",     "Handwritten Note",         [""]           ],
    ["_intelDesc",      "",                         [""]           ],
    ["_noteText",       "",                         [""]           ],
    ["_removeObject",   false,                      [true]         ],
    ["_actionTitle",    "Investigate the note...",  [""]           ],
    ["_actionDuration", 15,                         [0]            ],
    ["_actionSound",    "AUTO",                     [""]           ],
    ["_shareWith",      "DEFAULT",                  [""]           ]
];

if (_objects isEqualType objNull) then { _objects = [_objects]; };
if (_objects isEqualTo []) exitWith { false };

// Compose Intel Body
private _content = "<br/>";
if (_intelDesc isNotEqualTo "") then { _content = _content + format [Q(<font COLOR_GREY face='RobotoCondensedLight'>%1</font><br/><br/>), _intelDesc]; };

_content = _content + format [ "<br/><font face='Caveat' size='25'>%1</font>", _noteText ];

// Apply Intel
private _results = _objects apply {
    [_x, _intelTitle, _content, _intelGroup, _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith] call FUNC(createIntel)
};

!(false in _results)
