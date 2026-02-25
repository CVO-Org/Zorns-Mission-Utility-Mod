#include "../../script_component.hpp"

/*
* Author: Zorn
* Function
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
    [ "_speaker",    "",         [""] ],
    [ "_text",       "",         [""] ],
    [ "_color",      "ORANGE",   [""] ]
];

_color = switch (_color) do {
    case "CVO_RED": { QCVO_RED_HEX };
    case "INDFOR":  { "#008000" };
    case "BLUFOR":  { "#004C99" };
    case "REDFOR":  { "#800000" };
    case "CIV":     { "#660080" };
    case "ORANGE":  { "#F18B1D" };
    default { _color };
};

if (_speaker isNotEqualTo "") then { _speaker = _speaker + ":"};

private _string = format ["
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<t align = 'center' shadow = '2' color='%3' size='2' font='RobotoCondensedBold'>
%1</t><br/><br/>
<t color='#ffffff' size='1.5' font='RobotoCondensed'>
%2
</t>
",
_speaker,
_text,
_color
];

titleText [_string, "PLAIN", 0.7, true, true];
