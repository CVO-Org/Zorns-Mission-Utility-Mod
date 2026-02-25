#include "../../script_component.hpp"

/*
* Author: Zorn
* FUnction to extract all data from a ListNBox / Toolbox Control.
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
    [ "_ctrl", controlNull, [controlNull, 0] ]
];

lnbSize _ctrl params ["_rows", "_columns"];

_rows = _rows -1;
_columns = _columns -1;

private _db = createHashMap;

for "_curRow" from 0 to _rows do {
    for "_curCol" from 0 to _columns do {
        _db set [ format ["%1-%2-%3",_curRow,_curCol,"Text"],  _ctrl lnbText  [ _curRow, _curCol ] ];
        _db set [ format ["%1-%2-%3",_curRow,_curCol,"Data"],  _ctrl lnbData  [ _curRow, _curCol ] ];
        _db set [ format ["%1-%2-%3",_curRow,_curCol,"Value"], _ctrl lnbValue [ _curRow, _curCol ] ];
    };
};

private _keys = keys _db;

private _db_colWidth = createHashMap;

for "_col" from 0 to _columns do {
    private _curColKeys = _keys select { _x splitString "-" select 1 isEqualTo str _col };

    private _widths = [];

    {
        private _value = _db get _x;
        if !(_value isEqualType "") then { _value = str _value; };
        _widths pushBack count _value;

    } forEach _curColKeys;

    _db_colWidth set [_col, selectMax _widths];
};


// Header
// [              ][ 0 ][ 1 ][ 2 ][ 3 ][ 4 ]
// [ ROW  0 TEXT  ]
// [        DATA  ]
// [        VALUE ]


private _title = "[              ]";

for "_index" from 0 to _columns do {
    _title = _title insert [
        -1,
        "[ " + ([_index, _db_colWidth get _index ] call FUNC(stringPadding)) + " ]"
    ];
};

private _fullWidth = count _title;

private _outputArray = [];

// Lines
private _line = ["", _fullWidth, "RIGHT", "-" ] call FUNC(stringPadding);
private _lineDouble = ["", _fullWidth, "RIGHT", "=" ] call FUNC(stringPadding);

_outputArray pushBack _lineDouble;
_outputArray pushBack (format ['[MUM](debug)(fn_ui_lnb_output) _ctrl: %1', _ctrl]);
_outputArray pushBack _title;
_outputArray pushBack _lineDouble;

for "_row" from 0 to _rows do {

    {
        private _type = _x;
        private _head = ["[           %2 ]", "[ ROW %1 %2 ]"] select (_type isEqualTo "Text");
        private _str = format [
            _head,
            [_row,  2, "RIGHT", "0" ] call EFUNC(common,stringPadding),
            [_type, 5, "LEFT",  " " ] call EFUNC(common,stringPadding)
        ];

        for "_col" from 0 to _columns do {

            private _key = format ["%1-%2-%3",_row,_col,_type];
            private _cell = [
                _db get _key,
                _db_colWidth get _col,
                "RIGHT"
            ] call EFUNC(common,stringPadding);

            _str = _str + "[ " + _cell + " ]";
        };

        _outputArray pushBack _str;
    } forEach ["Text", "Data", "Value"];
    _outputArray pushBack _line;
};

{ diag_log _x } forEach _outputArray;
