#include "../../script_component.hpp"

/*
* Author: Zorn
* Processes one kit per frame: if the unit meets the kit's requirements, its items are added to the arsenal box.
* Calls itself in the next frame until all kits are processed.
*
* Arguments:
* 0: Arsenal box <OBJECT>
* 1: Unit <OBJECT> (default: ACE_player)
* 2: Side of the unit <STRING> (default: "CIV")
* 3: Roles of the unit <ARRAY of STRINGS> (default: [])
* 4: Steam64 ID of the unit <STRING> (default: getPlayerUID player)
* 5: Kits <HASHMAP> (default: empty hashmap)
* 6-9: Internal - used for the recursion
*
* Return Value:
* None
*
* Example:
* [_box, ACE_player, "WEST", ["medic"], getPlayerUID player, _kits] call mum_arsenal_fnc_addItemsFromKit_recursive
*
* Public: No
*/

params [
    [ "_box",   objNull,                 [objNull]       ],
    [ "_unit",  ACE_player,              [objNull]       ],
    [ "_side",  "CIV",                   [""]            ],
    [ "_roles", [],                      [[]]            ],
    [ "_id64",  getPlayerUID player,     [""]            ],
    [ "_kits",  createHashMap,           [createHashMap] ],
    [ "_total", nil,                      [0]             ],
    [ "_keys",  nil,                     [[]]            ],
    [ "_added", 0,                       [0]             ],
    "_nextIteration"
];

if (isNull _box) exitWith {};

if (isNil "_keys") then {
    _keys = keys _kits;
    _keys sort true;
};

private _count = count _keys;
if (isNil "_total") then { _total = _count; };


// when Done, Final SystemChat Message
if (_count == 0) exitWith {
    systemChat " "; systemChat " "; systemChat " "; systemChat " ";
    systemChat format ['(Done) %1 out of %2 Kits added', _added, _total];
    systemChat format ['(Done) Roles detected: %1', _roles];

};

if (isNil "_nextIteration") then {
    _nextIteration = { [FUNC(addItemsFromKit_recursive), [_box, _unit, _side, _roles, _id64, _kits, _total, _keys, _added, _nextIteration]] call CBA_fnc_execNextFrame; };
};

private _returnArray = [];

private _kitName = _keys deleteAt 0;
private _kit = _kits get _kitName;


systemChat format ['(Processing)[%1/%2] %3',1 + _total - _count, _total, _kitName];

// #### Check if Default Kit is disabled (CBA Setting or Module) - Personal Kits can not be disabled
if ( ( _kit getOrDefault [ "id64", "" ] ) in [ "", [] ] && { [ "kits", _kitName ] call FUNC(isDisabled) } ) exitWith _nextIteration;


// #### Check Side-Condition
// Ignore when empty, otherwise unit side needs tobe inside _sides array.
private _sides = _kit get "sides";
if ( _sides isNotEqualTo [] && { !(_side in _sides) } ) exitWith _nextIteration;


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
    case !(_codeResult isEqualType []): { _codeResult = []; };
};
_codeResult = _codeResult select { _x call CBA_fnc_getItemConfig isNotEqualTo configNull };
_returnArray append _codeResult;

systemChat format ['(Processing)[%1/%2] %3 - ADDED',1 + _total - _count, _total, _kitName];

if (GVAR(loaded_greenMag)) then {
    // Get all Magazines and get the compatible greenMag items
    private _gmItems = flatten (_returnArray select { isClass (configFile >> "CfgMagazines" >> _x) } apply { _x call FUNC(getGreenMagItems) } );
        _returnArray append _gmItems;
};

// Add stuff to the Arsenal
[_box, _returnArray arrayIntersect _returnArray] call ace_arsenal_fnc_addVirtualItems;

_added = _added + 1;

call _nextIteration;

nil
