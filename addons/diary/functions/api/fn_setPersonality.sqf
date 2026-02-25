#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to set (create or update) a "Personality" Entry.
*
* Arguments:
*   0:
*
* Return Value:
* None
*
* Example begin:

[
    "Mc Dude",
    "", // default Image
    "Head of Kitchen</br>Chief of Dishes",
    "His cooking alright fam...",
    "\A3\Data_F\Flags\Flag_AAF_CO.paa"  // icon
] call mum_intel_fnc_setPersonality;

[
    "'Spike' Gillian",
    "", // default Image
    "Senior Operations Lead<br />Myrmidones Altis Branch",
    "Mr Gillian has had a long career in the British armed forces, serving for over 20 years before his deployment to Altis under the NATO banner. On the cusp of retirement, a fellow ex-Altis war veteran reached out to him with a proposal - leave the Marines, and join the Myrmidones. Now, a few years later, Mr Gillian is a senior operations lead on Altis, delegating tasks to various Myrmidon units in the centre of the island.",
    "\A3\Data_F\Flags\Flag_NATO_CO.paa"  // icon
] call mum_intel_fnc_setPersonality;

*
* Public: No
*/

params [
    [ "_name",      "",     [""]      ],
    [ "_image",     "",     [""]      ],
    [ "_subtitle",  "",     [""]      ],
    [ "_text",      "",     [""]      ],
    [ "_icon",      "",     [""]      ],
    [ "_newName",   "",     [""]      ],
    [ "_subject",   "",     ["", []]  ],
    [ "_target",    player, [objNull] ]
];

_subject = [_subject, "Personalities"] select (_subject isEqualTo "");

switch (_image) do {
    case "":     { _image = QPATHTOF(data\personalities_default.paa) };
    case "NONE": { _image = "" };
};

[
    _subject
    ,_name
    ,_image
    ,_subtitle
    ,_text
    ,_icon
    ,_newName
    ,_target
] call FUNC(setEntry);
