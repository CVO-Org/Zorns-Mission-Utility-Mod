#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Module function to turn the synced objects into MUM intel items, formatted as a photograph.
* The image is taken from the synced object's texture or from a custom path, the backside note is shown below it.
*
* Arguments:
* 0: Module logic <OBJECT>
* 1: Synced objects <ARRAY>
* 2: Activated <BOOL>
*
* Return Value:
* None
*
* Example:
* [_logic, [_object], true] call mum_intel_fnc_module_intelItem_photo
*
* Public: No
*/

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

if (_units isEqualTo []) exitWith {};

// Get Content
// private _intel_handwritten = _logic getVariable QGVAR(intel_handwritten);


// get photo texture (photo getObjectTextures [-1]) findIf { _x isEqualType "" }
// _intelContent = _intelContent + format [ "<br/><font face='Caveat' size='25'>%1</font>", _intel_handwritten ];


// Apply Intel
{
    private _obj = _x;

    // Compose Intel Body
    private _intelContent  = "<br/>";
    private _intelDesc = _logic getVariable QGVAR(intel_desc);
    if (_intelDesc isNotEqualTo "") then { _intelContent = _intelContent + format [Q(<font COLOR_GREY face='RobotoCondensedLight'>%1</font><br/><br/>), _intelDesc]; };

    private _texPath = switch (_logic getVariable QGVAR(intel_photoSelector)) do {
        case "CUSTOM": { _logic getVariable QGVAR(intel_photoCustom) };
        case "CUSTOM_MISSION": { getMissionPath (_logic getVariable QGVAR(intel_photoCustom)) };
        case "OBJECT": {
            private _objTextures = _obj getObjectTextures [0];
            private _hasTexture = _objTextures findIf { _x isEqualType "" } isNotEqualTo -1;
            if (_hasTexture) then { _objTextures select 0 } else { "" }
        };
        default { "" };
    };
    if (_texPath isNotEqualTo "") then { _intelContent = _intelContent + format ["<img width='370' image='%1'/>", _texPath]; };

    private _intelBackside = _logic getVariable QGVAR(intel_backside);
    if (_intelBackside isNotEqualTo "") then { _intelContent = _intelContent + format ["<br/><font face='Caveat' size='25'>%1</font>", _intelBackside]; };

    [
        _obj,
        _logic getVariable QGVAR(intelTitle),
        _intelContent,
        _logic getVariable QGVAR(intelGroup),
        _logic getVariable QGVAR(removeObject),
        _logic getVariable QGVAR(actionTitle),
        _logic getVariable QGVAR(actionDuration),
        _logic getVariable QGVAR(actionSound),
        _logic getVariable QGVAR(shareWith)
    ] call FUNC(createIntel)
} forEach _units;

nil
