#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to create an Intel Item.
*
* Arguments:
* 0: _object        <OBJECT>
*           Object which shall be the intel.
*
* 1: _intelTitle    <STRING>
*           The title of the Intel piece.
*
* 2: _intelContent  <STRING>
*           Content of the Intel - Can be very simple String or can be formatted as Structured Text.
*           Needs to be a String, not text.
*
* 3: _intelGroup    <STRING>  <OPTIONAL> <DEFAULT: "General">
*           Group Name of the Intel - Only used for the Intel Summary Feature. Can be, for Example, Location based or Type Based.
*
* 4: _removeObject  <BOOLEAN> <OPTIONAL> <DEFAULT: true>
*           Weather the Object gets deleted once it has been picked up or not.
*
* 5: _actonTitle    <STRING>  <OPTIONAL> <DEFAULT: "Gather Intel">
*           String to be used for the Ace Action and Progress Bar.
*
* 6: _actonDuration <NUMBER>  <OPTIONAL> <DEFAULT: 15>
*           Duration of the Progressbar in Seconds. Will be reducing in Eden Editor Preview Editor to 1 second.
*
* 7: _actionSound   <STRING>  <OPTIONAL> <DEFAULT: "AUTO">
*           Can be "BODY", "KEYBOARD" or "AUTO".
*           "AUTO" will check if Object is like Laptop or similar.
*           Defines the Type of Sound during the Progressbar.
*
* 8: _shareWith     <STRING>  <OPTIONAL> <DEFAULT: "DEFAULT">
*           Can be "GLOBAL", "SIDE", "GROUP", "UNIT", "DEFAULT".
*           "DEFAULT" will reference CBA Setting defined default.
*           Defines who the intel is being shared with once its picked up.
*
*
* Return Value:
* Success? <BOOLEAN>
*
* Example:
* [this, "Secret Documents", "We, the bad guys, will attack the good guys tonight at checkpoint charlie!"] call MUM_intel_fnc_createIntel;
*
* Public: Yes
*/


if !(isServer) exitWith {};

params [
    ["_object",             objNull,                [objNull]      ],
    ["_intelTitle",         "Diary Record Title",   [""]           ],
    ["_intelContent",       "Diary Body",           [""]           ],
    ["_intelGroupName",     "General",              [""]           ],
    ["_removeObject",       true,                   [true]         ],
    ["_actionTitle",        "Gather Intel",         [""]           ],
    ["_actionDuration",     15,                     [0]            ],
    ["_actionSound",        "AUTO",                 [""]           ],   // "AUTO", "BODY", "KEYBOARD"
    ["_shareWith",          "DEFAULT",              [""]           ]    // "GLOBAL", "SIDE", "GROUP", "UNIT", "DEFAULT"
];


if (_object isEqualTo objNull) exitWith { false };


// Store Intel in
private _intelCatalog = [QGVAR(catalog)] call EFUNC(catalog,getCatalog);
private _id = [QPREFIX, QCOMPONENT, count keys _intelCatalog] joinString "_";

// Check if object is type of Laptop, Keyboard or alike
if (_actionSound isEqualTo "AUTO") then {
    private _laptops = [
        "Land_Laptop_F",
        "Land_Laptop_unfolded_F",
        "Land_Laptop_02_F",
        "Land_Laptop_03_base_F",
        "Land_MultiScreenComputer_01_base_F",
        "Land_PCSet_01_case_F",
        "Land_PCSet_01_keyboard_F",
        "Land_PCSet_01_mouse_F",
        "Land_PCSet_01_mousepad_base_F",
        "Land_PCSet_01_screen_F",
        "Land_IPPhone_01_base_F",
        "Item_Laptop_Unfolded",
        "Item_Laptop_Closed"
    ];
    _actionSound = ["KEYBOARD", "BODY"] select (_laptops findIf { _object isKindOf _x } == -1);
};

// Debug Mode
if ( is3DENPreview ) then {
    _str = format ["intel entry created: %1 - %2", _id, _object]; diag_log _str; systemChat _str;
    _actionDuration = 1;
};

// Create CBA Namespace for shared & jip compatible data.
private _namespace = true call CBA_fnc_createNamespace;

{
    _namespace setVariable [ _x#0, _x#1, true ];
} forEach [
    ["id",              _id             ],
    ["object",          _object         ],
    ["objectRemove",    _removeObject   ],
    ["actionTitle",     _actionTitle    ],
    ["actionSound",     _actionSound    ],
    ["actionDuration",  _actionDuration ],
    ["intelTitle",      _intelTitle     ],
    ["intelContent",    _intelContent   ],
    ["intelGroup",      _intelGroupName ],
    ["shareWith",       _shareWith      ],
    // Internal
    ["found",        false  ],    // Local cache, shall never be published
    ["foundByAll",   false  ],
    ["foundBySide",  []     ],
    ["foundByGroup", []     ],
    ["foundByUnit",  []     ]
];

missionNamespace setVariable [_id, _namespace, true];

[ QGVAR(EH_addIntelAction), [_object, _id, _actionTitle, _actionSound, _actionDuration], _object] call CBA_fnc_globalEventJIP;


// Update Public Intel Catalog
_intelCatalog set [_id, _namespace];
missionNamespace setVariable [QGVAR(catalog), _intelCatalog, true];

true
