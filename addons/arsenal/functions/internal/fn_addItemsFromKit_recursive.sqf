#include "../../script_component.hpp"

/*
* Author: Zorn
* "Recursive" Function to iterate over the kits one after another
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

params [
    [ "_box",   objNull,                 [objNull]       ],
    [ "_unit",  ACE_player,              [objNull]       ],
    [ "_roles", [],                      [[]]            ],
    [ "_id64",  getPlayerUID player,     [""]            ],
    [ "_kits",  createHashMap,           [createHashMap] ],
    [ "_total", -1,                      [0]             ],
    [ "_keys",  nil,                     [[]]            ],
    [ "_added", 0,                       [0]             ]
];

if (isNull _box) exitWith {};

if (isNil "_keys") then {
    _keys = keys _kits;
    _keys sort true;
};

private _count = count _keys;

if (_total == -1) then {
    _total = _count;
};

if (_count == 0) exitWith {
    systemChat " "; systemChat " "; systemChat " "; systemChat " ";
    systemChat format ['(Done) %1 out of %2 Kits added', _added, _total];
    systemChat format ['(Done) Roles detected: %1', _roles];
    diag_log format ['(Done) %1 out of %2 Kits added', _added, _total];
};

private _nextIteration = {
    [FUNC(addItemsFromKit_recursive), [_box, _unit, _roles, _id64, _kits, _total, _keys, _added]] call CBA_fnc_execNextFrame;
};

private _returnArray = [];

private _kitName = _keys deleteAt 0;
private _kit = _kits get _kitName;

diag_log format ['(Processing)[%1/%2] %3',1 + _total - _count, _total, _kitName];
systemChat format ['(Processing)[%1/%2] %3',1 + _total - _count, _total, _kitName];

// #### Check if Setting for Default Kits
private _settingName = [QADDON, _kitName] joinString "_";
if (!isNil _settingName && { !(missionNamespace getVariable _settingName) } ) exitWith _nextIteration;



// #### Check Roles ####
private _role = _kit get "role";
if (_role isNotEqualTo "" && { !( _role in _roles) }) exitWith _nextIteration;


// #### Check ID64 ####
private _kitID = _kit get "id64";
if ( _kitID isNotEqualTo "") then {
    if (_kitID isEqualType "") then { _kitID = [_kitID]; };
    _kitID = _id64 in _kitID;
};
if (_kitID isEqualTo false) exitWith _nextIteration;


private _items = _kit get "items";


// #### Condition ####
private _conditionCode = _kit getOrDefault ["condition", {}];
private _conditionResult = [_unit, _items] call _conditionCode;


// validate Return
if (isNil "_conditionResult" || { typeName _conditionResult isNotEqualTo "BOOL" }) then {
    ERROR_1("Bad condition return for Kit: %1",_kitName);
    _conditionResult = false;
};

if (!_conditionResult) exitWith _nextIteration;

_returnArray append _items;


// #### Code ####
private _codeCode = _kit getOrDefault ["code", {}];
private _codeResult = if (_codeCode isNotEqualTo {}) then {
    [_unit, _items] call _codeCode;
} else {[]};

// Validate Return
switch (true) do {
    case ( isNil "_codeResult" ):      { _codeResult = []; };
    case (_codeResult isEqualType ""): { _codeResult = [_codeResult]; };
};
_codeResult = _codeResult select { _x call CBA_fnc_getItemConfig isNotEqualTo configNull };
_returnArray append _codeResult;

systemChat format ['(Processing)[%1/%2] %3 - ADDED',1 + _total - _count, _total, _kitName];
diag_log format ['(Processing)[%1/%2] %3 - ADDED',1 + _total - _count, _total, _kitName];

// Add stuff to the Arsenal
[_box, _returnArray arrayIntersect _returnArray] call ace_arsenal_fnc_addVirtualItems;

_added = _added + 1;

call _nextIteration;

nil
