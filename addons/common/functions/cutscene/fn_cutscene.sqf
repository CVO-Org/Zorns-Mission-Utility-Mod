#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to handle a simple Cutscene which mainly uses Text 
*
* Arguments:
*
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/


// Check if START has been used without END
private _hasStart = _this findIf { _x select 0 isEqualTo "START" } isNotEqualTo -1;
private _hasEnd = _this findIf { _x select 0 isEqualTo "END" } isNotEqualTo -1;
if (_hasStart && !_hasEnd) then { _this pushBack ["END"]; };


// Check if MUTE has been used without UNMUTE
private _hasMute = _this findIf { _x select 0 isEqualTo "MUTE" } isNotEqualTo -1;
private _hasUnMute = _this findIf { _x select 0 isEqualTo "UNMUTE" } isNotEqualTo -1;
if (_hasMute && !_hasUnMute) then { _this pushBack ["UNMUTE", 60]; };


// Check if BLUR_IN has been used without BLUR_OUT
private _hasBlur = _this findIf { _x select 0 isEqualTo "BLUR_IN" } isNotEqualTo -1;
private _hasBlurOut = _this findIf { _x select 0 isEqualTo "BLUR_OUT" } isNotEqualTo -1;
if (_hasBlur && !_hasBlurOut) then { _this pushBack ["BLUR_OUT"]; };


// Check if Music Boost has been used without Music Reset
private _hasMusicBoost = _this findIf { _x select 0 isEqualTo "MUSIC_BOOST" } isNotEqualTo -1;
private _hasMusicReset = _this findIf { _x select 0 isEqualTo "MUSIC_RESET" } isNotEqualTo -1;
if (_hasMusicBoost && !_hasMusicReset) then { _this pushBack ["MUSIC_RESET", 120]; };


// Handle JIP
private _jipIndex = _this findIf { _x select 0 isEqualTo "JIP" };
private _isJIP = _jipIndex isNotEqualTo -1;
if (_isJIP) then {
    private _data = _this deleteAt _jipIndex;
    if (_data isNotEqualTo ["JIP"]) then { _isJIP = _data select 1; };
};


// Process Timeline
{ [_x, _isJIP] call FUNC(processTimelineEntry); } forEach _this;


private _delay = missionNamespace getVariable [QGVAR(cutscene_delay), 0];
missionNamespace setVariable [QGVAR(cutscene_delay), nil];

_delay // return final delay so custom WAE can be added afterwards
