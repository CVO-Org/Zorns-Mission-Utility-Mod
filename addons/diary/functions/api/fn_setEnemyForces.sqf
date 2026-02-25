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
* ["AAF", "They wear green"] call mum_diary_fnc_setEnemyForces;
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
    "Enemy Forces"
    ,_factionName
    ,_photo
    ,_subTitle
    ,_description
    ,_flag
] call FUNC(setEntry);
