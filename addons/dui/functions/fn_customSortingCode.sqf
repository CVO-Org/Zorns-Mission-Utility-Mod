#include "..\script_component.hpp"

/*
* Author: Zorn
* Function to set DUI's custom Sorting Function
* see: https://github.com/diwako/diwako_dui/wiki/Custom-namelist-sorting
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

if (!hasInterface) exitWith {};

// _grp: array of units that needs sorting (careful SQL could be removed from the array)
// _player: the current unit the player is controling
// DUI expects an array as return value. e.g. [_unit1, _unit2, etc]

params["_grp", "_player"];

private _group = group _player;
private _SL = leader group _player;
private _SLTeam = assignedTeam _SL;
private _TLs = values (_group getVariable [QGVAR(TeamLeaders), createHashMap]);

if diwako_dui_radar_sqlFirst then { _grp pushBack _SL };

private _sortingMethod = {
    // _this returns same as _x
    // parameters are _input0..9
    [_input0, _input1] params ["_SL", "_TLs"];
    switch (true) do {
        case (_x isEqualTo _SL): { 30 };
        case (_x in _TLs): { 20 };
        default { rankID _x };
    } // return
};

private _map = createHashMap;

// add each unit to map based upon assignedTeam
{ _map getOrDefault [assignedTeam _x, [], true] pushBack _x; } forEach _grp;

// Sort Teams based on Sorting Method
{ _map set [ _x, [_y, [_SL, _TLs], _sortingMethod, "DESCEND"] call BIS_fnc_sortBy ]; } forEach _map;


// Add padding per Fireteam Collumn
private _maxLinesPerCollumn = call FUNC(getLinesPerCollumn);

private _addPadding = {
    if ( getArray (configFile >> "CfgPatches" >> "diwako_dui_radar" >> "versionAr") isEqualTo [1,12,11,0] ) exitWith {}; // // ToDo: Remove once DUI updated
    params [ "_fireTeam", "_maxLinesPerCollumn" ];
    private _fireTeamSize = count _fireTeam;
    private _sizeLastFireTeamCollumn = _fireTeamSize mod _maxLinesPerCollumn;
    private _paddingNeeded = _maxLinesPerCollumn - _sizeLastFireTeamCollumn;

    while {_paddingNeeded isNotEqualTo 0} do { _paddingNeeded = _paddingNeeded - 1; _fireTeam pushBack objNull; };

};

// Sort Fireteams: Priotize SL Fireteam, handle remaining based upon dui sorting
private _fireTeamsSorted = [keys _map, [_SLTeam], { if (_x isEqualTo _input0) then { -1 } else { diwako_dui_radar_sortNamespace getVariable toLowerANSI _x } } ] call BIS_fnc_sortBy;
private _finalIndex = count _fireTeamsSorted - 1;


private _return = [];

{
    private _team = _map get _x;
    if (_forEachIndex isNotEqualTo _finalIndex ) then { [_team, _maxLinesPerCollumn] call _addPadding; }; // Dont add padding to last Fireteam
    _return append _team;
} forEach _fireTeamsSorted;

if diwako_dui_radar_sqlFirst then { _return = _return - [_SL]; };

_return
