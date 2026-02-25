#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to create/update an entry within a given subject.
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

/* Copy Paste Template
[
    "Subject"      // Subject Display Name
    ,"Titel"       // Record Display Name
    ,""            // Image inside the Entry. getMissionPath "\data\personalities.paa"
    ,""            // Subtitles
    ,"
Block 1 Channel  1: 1-1 - Infantry
<br/> Block 1 Channel  2: 1-2 - Infantry
"                   // Text Body
    // ,_icon       // Image next to the entry Title (small flags for example)
    // ,_newName
    // ,_target
] call mum_intel_fnc_setEntry;

*/

params [
    [ "_subject",    "",         ["", []]  ],
    [ "_name",       "",         [""]      ],
    [ "_image",      "",         [""]      ],
    [ "_subtitle",   "",         [""]      ],
    [ "_text",       "",         [""]      ],
    [ "_icon",       "",         [""]      ],
    [ "_newName",    "",         [""]      ],
    [ "_target",     player,     [objNull] ]
];

if (_subject == "") exitWith {};

if (_subject isEqualType "") then { _subject = [_subject] };

_subject params ["_subjectDisplay", ["_subjectIcon", "", [""]]];
_subjectID = toLowerANSI _subjectDisplay splitString " " joinString "_";

[_subjectID, _subjectDisplay, _subjectIcon] call FUNC(createDiarySubject);


private _currentRecords = _target allDiaryRecords _subjectID;
private _index = _currentRecords findIf { _x#1 == _name };


if (_newName != "") then { _name = _newName; };

// Handle Default Image
private _img_width = missionNamespace getVariable [QSET(img_width), 350];
if (_image isEqualTo "") then {"<br/><br/>"} else {
    _image = format ["<img width='%1' image='%2' >></img><br/><br/>", _img_width, _image]
};

if (_subtitle isEqualTo "") then {"<br/><br/>"} else {
    _subtitle = format ["<font size=14 face='EtelkaMonospaceProBold' color='#0099ff'>%1</font><br/><br/>", _subtitle]
};


private _body = format ["
<br/><font size=20 face='EtelkaMonospaceProBold' color='#0099ff'>%2</font><br/>
%3
%4
<font size=%1 face='EtelkaMonospaceProBold'>%5</font>
",
missionNamespace getVariable [QSET(size_body),11],
_name,
_image,
_subtitle,
_text
];


if (_index > -1) then {
    private _record = _currentRecords select _index select 8;
    _target setDiaryRecordText [[_subjectID, _record], [_name, _body, _icon]];
} else {
    _target createDiaryRecord [_subjectID, [_name, _body, _icon]];
};
