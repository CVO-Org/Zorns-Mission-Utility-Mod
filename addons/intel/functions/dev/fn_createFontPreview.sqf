#include "..\..\script_component.hpp"

/*
* Author: Zorn
* DEV Function - creates a whiteboard with an example text for each font in config.
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

#define OBJ_CLASSNAME "Land_MapBoard_01_Wall_F"
#define DIR 10

params [ ["_object", player, [objNull] ] ];

private _currPos = getPos _object vectorAdd [1,1,1];
private _fonts = "true" configClasses (configFile >> "CfgFontFamilies") apply { configName _x };
_fonts sort true;

private _delay = 0;

{
    _delay = _delay + 2;
    _currPos = _currPos vectorAdd [1.5,0,0];

    [
        {
            params ["_pos", "_texture"];

            private _obj = createVehicle [OBJ_CLASSNAME, _pos];
            _obj setDir DIR;
            _obj setObjectTexture [0, _texture];

        },
        [
            + _currPos,
            format ["#(rgb,512,512,3)text(1,1,""%1"",0.1,""#FFFFFF"",""#000000"",""%1\n\nHallo\nWelt"")", _x]
        ],
        _delay
    ] call CBA_fnc_waitAndExecute;


} forEach _fonts;
