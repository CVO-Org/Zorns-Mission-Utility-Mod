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

diwako_dui_radar_customSort = {
	// _grp: array of units that needs sorting (careful SQL could be removed from the array)
	// _player: the current unit the player is controling
	// DUI expects an array as return value. e.g. [_unit1, _unit2, etc]

	params["_grp", "_player"];


    private _group = group _player;
    private _SL = leader group _player;
    private _SLTeam = assignedTeam _SL;
    private _TLs = _group getVariable [QGVAR(TeamLeaders), []];

    private _sortingMethod = {
        params ["_SL", "_TLs"];
        switch (true) do {
            case (_x isEqualTo _SL): { 100 };
            case (_x in _TLs): { 10 };
            default { rankID _x };
        };
    };

    private _fireTeamRed    = [ _grp, [_SL, _TLs], _sortingMethod, "DESCEND", { assignedTeam _x isEqualTo "RED"    } ] call BIS_fnc_sortBy;
	private _fireTeamBlue   = [ _grp, [_SL, _TLs], _sortingMethod, "DESCEND", { assignedTeam _x isEqualTo "BLUE"   } ] call BIS_fnc_sortBy;
	private _fireTeamGreen  = [ _grp, [_SL, _TLs], _sortingMethod, "DESCEND", { assignedTeam _x isEqualTo "GREEN"  } ] call BIS_fnc_sortBy;
	private _fireTeamYellow = [ _grp, [_SL, _TLs], _sortingMethod, "DESCEND", { assignedTeam _x isEqualTo "YELLOW" } ] call BIS_fnc_sortBy;
	private _fireTeamWhite  = [ _grp, [_SL, _TLs], _sortingMethod, "DESCEND", { assignedTeam _x isEqualTo "MAIN"   } ] call BIS_fnc_sortBy;


    // Add padding per Fireteam Collumn
    private _maxLinesPerCollumn = call FUNC(getLinesPerCollumn);

    private _addPadding = {
        params [ "_fireTeam", "_maxLinesPerCollumn", "_edgeCase" ];

        if (_fireTeam isEqualTo []) exitWith {};

        private _fireTeamSize = count _fireTeam;
        if (_edgeCase) then { _fireTeamSize = _fireTeamSize + 1 }; // when edgeCase, assume Fireteam + 1

        private _sizeLastFireTeamCollumn = _fireTeamSize mod _maxLinesPerCollumn;
        private _paddingNeeded = _maxLinesPerCollumn - _sizeLastFireTeamCollumn;

        while {_paddingNeeded isNotEqualTo 0} do { _paddingNeeded = _paddingNeeded - 1; _fireTeam pushBack objNull; diag_log text format ['[CVO](debug)(fn_applyCustomSort) While Loop: FT Size: %1', count _fireTeam];};

    };

    {
        private _edgeCase = _sqlFirst && { assignedTeam (_x#0) isEqualTo _SLTeam }; // When _sqlFirst setting is true, Group Leader is removed from list, so we have to handle the edgecase
        [ _x, _maxLinesPerCollumn, _edgeCase ] call _addPadding;

    } forEach [ _fireTeamRed, _fireTeamBlue, _fireTeamYellow, _fireTeamWhite ];



    // Sort Fireteams while priotizing SL's Fireteam
    switch (_SLTeam) do {
        case "RED":    { _fireTeamRed + _fireTeamBlue + _fireTeamGreen + _fireTeamYellow + _fireTeamWhite };
        case "BLUE":   { _fireTeamBlue + _fireTeamRed + _fireTeamGreen + _fireTeamYellow + _fireTeamWhite };
        case "GREEN":  { _fireTeamGreen + _fireTeamRed + _fireTeamBlue + _fireTeamYellow + _fireTeamWhite };
        case "YELLOW": { _fireTeamYellow + _fireTeamRed + _fireTeamBlue + _fireTeamGreen + _fireTeamWhite };
        case "MAIN":   { _fireTeamWhite + _fireTeamRed + _fireTeamBlue + _fireTeamGreen + _fireTeamYellow };
    } // return
};

