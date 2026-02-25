# MUM_Common

## Systems
### [Common - Cutscene](/addons/common/functions/cutscene/readme.md)

## functions

### `mum_common_fnc_makeCosmetic`

Turns an item, like guns (technically, ground weapon holders), into an non interactable, unmovable, purely cosmetic item.

```sqf
// objects init field
[this] call mum_common_fnc_makeCosmetic;
```

### `mum_common_fnc_executeUnit`

adds force to a unit and sets damage to 1 afterwards.

#### Example
```sqf
// to be used in the units init file
[this] call mum_common_fnc_executeUnit;

[_unit, 0, 300] call mum_common_fnc_executeUnit;
```

Parameters:
```sqf
params  [
    ["_target", objNull,    [objNull]   ],
    ["_dir",    "RND",      [0,""]      ],
    ["_mag",    300,        [0]         ],
    ["_rndVal", 90,         [0]         ],
    ["_offset", [0,0,1.5],  [[]],   [3] ]
];
```

#### cba server Event:
`mum_EVENT_executeUnitServer`


#### Preview
https://www.youtube.com/watch?v=pVdZ5OpLhb4



## mum_common_medical

```sqf
/*
Description:
     Adds an Ace Interaction to a vehicle class so players can perform a fullheal with a progressbar (30s) on said vehicle.

Dependency: ACE, CBA

Parameter(s):
    0: <_target> can be one of:
                    <Object>                                             - Individual Object to add the Full Heal ACE Action
                    <String of classname>                               - Entire Class to add the Full Heal ACE Action
        1:  <_duration>    <Number in secounds>    <Optional> <Default: 30>    - Duration of the Healing Process
    2:     <_chance>     <Number 0..100>         <Optional> <Default: 5>        - Defines the chance for the Easeregg sound - 0 disables the Easteregg
    Returns:
    Returns False when <_target> is not defined.

*/
        [ourMedicalVehicleObject]                 call mum_common_fnc_fullHeal;    // Adds Full Health Check on a single object
        ["mod_vehicle_medical_classname", 30, 0]  call mum_common_fnc_fullHeal;    // Adds Full Health Check on all objects of this classname and disables the easteregg
```

