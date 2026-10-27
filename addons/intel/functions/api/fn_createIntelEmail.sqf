#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to create an Intel Item formatted as an eMail, the same way as the "Intel Item - eMail" module. Server only - does nothing on clients.
*
* Arguments:
* 0: _objects       <OBJECT|ARRAY of OBJECTS>
*           Object(s) which shall be the intel. Each object becomes its own intel item.
*
* 1: _intelGroup    <STRING>  <OPTIONAL> <DEFAULT: "General">
*           Group Name of the Intel - Only used for the Intel Summary Feature.
*
* 2: _intelTitle    <STRING>  <OPTIONAL> <DEFAULT: "eMail">
*           The title of the Intel piece.
*
* 3: _intelDesc     <STRING>  <OPTIONAL> <DEFAULT: "">
*           Short description, shown in grey above the content. Empty string to skip.
*
* 4: _emailDate     <STRING>  <OPTIONAL> <DEFAULT: "">
* 5: _emailSender   <STRING>  <OPTIONAL> <DEFAULT: "">
* 6: _emailRecipient <STRING> <OPTIONAL> <DEFAULT: "">
* 7: _emailSubject  <STRING>  <OPTIONAL> <DEFAULT: "">
* 8: _emailText     <STRING>  <OPTIONAL> <DEFAULT: "">
*           eMail header fields and body. Empty fields are skipped. Use <br/> for line breaks.
*
* 9-13: _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith <OPTIONAL>
*           Same as MUM_intel_fnc_createIntel arguments 4-8. Default Action Title: "Check for eMails..."
*
* Return Value:
* Success? <BOOLEAN>
*
* Example:
* [intel_depot_laptop, "Puesto Crow", "Quartermaster's Inbox", "The laptop is still logged in.", "14.03.", "qm.crow", "R.", "Crates", "The crates are ready."] call MUM_intel_fnc_createIntelEmail;
*
* Public: Yes
*/

if !(isServer) exitWith { false };

params [
    ["_objects",        [],                     [objNull, []]  ],
    ["_intelGroup",     "General",              [""]           ],
    ["_intelTitle",     "eMail",                [""]           ],
    ["_intelDesc",      "",                     [""]           ],
    ["_emailDate",      "",                     [""]           ],
    ["_emailSender",    "",                     [""]           ],
    ["_emailRecipient", "",                     [""]           ],
    ["_emailSubject",   "",                     [""]           ],
    ["_emailText",      "",                     [""]           ],
    ["_removeObject",   false,                  [true]         ],
    ["_actionTitle",    "Check for eMails...",  [""]           ],
    ["_actionDuration", 15,                     [0]            ],
    ["_actionSound",    "AUTO",                 [""]           ],
    ["_shareWith",      "DEFAULT",              [""]           ]
];

if (_objects isEqualType objNull) then { _objects = [_objects]; };
if (_objects isEqualTo []) exitWith { false };

#define COLOR_EMAIL_HEADER_TITLE   color=QQ(#42d3a3)
#define COLOR_EMAIL_HEADER_CONTENT color=QQ(#429ed3)

// Compose Intel Body
private _content = "<br/>";
if (_intelDesc isNotEqualTo "") then { _content = _content + format [Q(<font COLOR_GREY face='RobotoCondensedLight'>%1</font><br/><br/>), _intelDesc]; };

if (_emailDate      isNotEqualTo "") then {_content = _content + format [Q(<font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_TITLE size='10'>DATE: </font><font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_CONTENT size='10'>%1</font><br/>), _emailDate]; };
if (_emailSender    isNotEqualTo "") then {_content = _content + format [Q(<font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_TITLE size='10'>FROM: </font><font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_CONTENT size='10'>%1</font><br/>), _emailSender]; };
if (_emailRecipient isNotEqualTo "") then {_content = _content + format [Q(<font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_TITLE size='10'>  TO: </font><font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_CONTENT size='10'>%1</font><br/>), _emailRecipient]; };
if (_emailSubject   isNotEqualTo "") then {_content = _content + format [Q(<font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_TITLE size='10'>SUBJ: </font><font face='EtelkaMonospacePro' COLOR_EMAIL_HEADER_CONTENT size='10'>%1</font><br/>), _emailSubject]; };
if (_emailText      isNotEqualTo "") then {_content = _content + format [Q(<br/><font face='EtelkaMonospaceProBold' size='11'>%1</font>), _emailText]; };

// Apply Intel
private _results = _objects apply {
    [_x, _intelTitle, _content, _intelGroup, _removeObject, _actionTitle, _actionDuration, _actionSound, _shareWith] call FUNC(createIntel)
};

!(false in _results)
