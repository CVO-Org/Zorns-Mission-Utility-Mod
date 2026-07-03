#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Define
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ["AAF", "They wear green"] call mum_diary_fnc_setAlliedForces;
*

[
    "AAF"                                       // Faction Name (Title)
    ,"
<br/>In the wake of civil war, the Jerusalem Cease Fire of 2030 mandated the creation of an armed defence force to secure the sovereign territory of The Republic of Altis and Stratis.
<br/>
<br/>Although it officially operates under the observation and training of international peacekeepers, the force remains loyal to the new, hard-line Altis government and acts with de facto judicial and executive authority. However, it is debilitated by an inexperienced command structure and is blighted by widespread corruption.",
"                                               // Description Text
    ,"Colloquially known as Greenbags"          // subTitle
    ,getMissionPath "aaf_photo.png"             // Photo
    ,""\a3\Data_f\Flags\flag_AAF_co.paa""       // Flag
] call mum_diary_fnc_setAlliedForces;


*
* Public: No
*/

params [
    [ "_factionName",   "", [""]    ],
    [ "_description",   "", [""]    ],
    [ "_subTitle",      "", [""]    ],
    [ "_photo",         "", [""]    ],
    [ "_flag",          "", [""]    ]

];

if (_factionName isEqualTo "") exitWith {};

[
    "Allied Forces"
    ,_factionName
    ,_photo
    ,_subTitle
    ,_description
    ,_flag
] call FUNC(setEntry);
