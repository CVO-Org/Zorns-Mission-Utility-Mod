#include "..\..\script_component.hpp"

/*
* Author: Zorn
* This function will take a string/sentence and splits it into multiple strings to avoid exeeding a certain length of characters per line.
* Optional: add padding to the individual strings.
*
* Best to be used with monospace font (obviously)
*
* Arguments:
*
* Return Value:
* array of padded strings.
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
    "_sentence",
    [ "_maxLineLength", 40,      [0]  ],
    [ "_lineBreak",     "<br/>", [""] ],
    [ "_paddingMode",   "NONE",  [""] ],
    [ "_paddingChar",   " ",     [""] ]
];

private _words = _sentence splitString " ";

// search for Linebreak in words

private _lnLinebreak = count _linebreak;
private _i = _words findIf { _linebreak in _x && { _x isNotEqualTo _linebreak } };
while { _i isNotEqualTo -1 } do {

	private _str = _words deleteAt _i;
	private _ln = count _str;
	private _begin = _str find _linebreak;

	private _insertArray = [];

	if (_begin > 0) then {_insertArray pushBack (_str select [0, _begin])}; // has Prefix?
	_insertArray pushBack _lineBreak;
	if (_begin + _lnLinebreak < _ln) then { _insertArray pushBack (_str select [_begin + _lnLinebreak, _ln - _lnLinebreak - _begin])}; // Has Suffix?
	_words insert [_i, _insertArray];

	_i = _words findIf { _linebreak in _x && { count _x isNotEqualTo _lnLinebreak } };
};

private _lines = [""];
private _currentLength = 0;

{
    private _word = _x;
    private _wordLength = count _word;
    private _newLineLength = if (_currentLength == 0) then { _wordLength } else { _currentLength + 1 +_wordLength };

    switch (true) do {
        // Add new Line, Ignore the word itself
        case (_word isEqualTo _lineBreak): { _lines pushBack ""; _currentLength = 0; };

        // New Word fits within maxLength and is the first word in the new line
        case (_maxLineLength > _newLineLength && {_currentLength isEqualTo 0}): {
            // Just add new word to line
            private _currentLineIndex = count _lines - 1;
            _lines set [_currentLineIndex, _word ];
            _currentLength = _newLineLength;
        };
        // New Word fits within maxLength
        case (_maxLineLength > _newLineLength): {
            // Add Space between previous words in line and new word
            private _currentLineIndex = count _lines - 1;
            _lines set [_currentLineIndex, (_lines#_currentLineIndex) + " " + _word ];
            _currentLength = _newLineLength;
        };


        // New Word does not fit within the current line
        default {
            // Add new Word as the first word of the new line
            _lines pushBack _word;
            _currentLength = _wordLength;
        };

    };
} forEach _words;

// Apply Padding when needed
if (toLowerANSI _paddingMode in ["left", "right", "center"]) then { _lines = _lines apply { [ _x, _maxLineLength, _paddingMode] call FUNC(stringPadding) }; };

_lines
