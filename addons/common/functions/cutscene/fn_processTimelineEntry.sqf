#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
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

#define LAYER_NUM_IMG 100000
#define LAYER_NUM_TEXT_PLAIN 10000
#define LAYER_NUM_TEXT 1000
#define LAYER_NUM_BG 100

params [ "_data", "_isJIP"];
_data params [ [ "_type", "", [""] ], ["_args", []] ];

private _delay = missionNamespace getVariable [QGVAR(cutscene_delay), 0.1];
private _defaultDelay = missionNamespace getVariable [QGVAR(cutscene_defaultDelay), 7];



switch (toUpperANSI _type) do {

    case "START": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        // Handle additional Code
        [
            {
                GVAR(cutscene_cache_dui) = diwako_dui_main_toggled_off;
                diwako_dui_main_toggled_off = true;
                openMap [false, true];
            },
            "",
            _delay
        ] call CBA_fnc_waitAndExecute;

        // Handle Visuals
        [{ LAYER_NUM_BG cutText ["", "BLACK OUT", _this, true, false, true]; }, _duration, _delay] call CBA_fnc_waitAndExecute;
        _delay = _delay + _duration;
        [{ LAYER_NUM_BG cutText ["", "BLACK FADED", _this, true, false, true]; }, 999, _delay] call CBA_fnc_waitAndExecute;
        [
            {
                disableUserInput true;
            },
            "",
            _delay
        ] call CBA_fnc_waitAndExecute;
    };


    case "END": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        // Handle Visuals
        [{ LAYER_NUM_BG cutText ["", "BLACK IN", _this, true, false, true]; }, _duration, _delay] call CBA_fnc_waitAndExecute;

        // Handle additional Code
        [
            {
                openMap [false, false];
                while {userInputDisabled} do {disableUserInput false;};
            },
            "",
            _delay
        ] call CBA_fnc_waitAndExecute;

        [
            {
                diwako_dui_main_toggled_off = GVAR(cutscene_cache_dui);
                GVAR(cutscene_cache_dui) = nil;
            },
            "",
            ( (_delay * 10) max 150 ) min 600
        ] call CBA_fnc_waitAndExecute;

    };

    case "BLUR_IN": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        [
            {
                if (!isNil QGVAR(dynamicBlurHandle)) then {
                    ppEffectDestroy GVAR(dynamicBlurHandle);
                    GVAR(dynamicBlurHandle) = nil;
                };
                GVAR(dynamicBlurHandle) = ppEffectCreate ["DynamicBlur", 103];
                GVAR(dynamicBlurHandle) ppEffectAdjust [3];
                GVAR(dynamicBlurHandle) ppEffectEnable true;
                GVAR(dynamicBlurHandle) ppEffectCommit _this;
            },
            _duration,
            _delay
        ] call CBA_fnc_waitAndExecute;

    };
    case "BLUR_OUT": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        [
            {
                if (isNil QGVAR(dynamicBlurHandle)) then {
                    GVAR(dynamicBlurHandle) = ppEffectCreate ["DynamicBlur", 103];
                    GVAR(dynamicBlurHandle) ppEffectAdjust [3];
                    GVAR(dynamicBlurHandle) ppEffectEnable true;
                    GVAR(dynamicBlurHandle) ppEffectCommit 0;
                };

                GVAR(dynamicBlurHandle) ppEffectAdjust [0];
                GVAR(dynamicBlurHandle) ppEffectEnable true;
                GVAR(dynamicBlurHandle) ppEffectCommit _this;

                [ { ppEffectDestroy GVAR(dynamicBlurHandle); GVAR(dynamicBlurHandle) = nil; }, "", _this] call CBA_fnc_waitAndExecute;
            },
            _duration,
            _delay
        ] call CBA_fnc_waitAndExecute;
    };


    case "CODE": {
        _args params [ [ "_code", {}, [{}] ], ["_params", []]];
        [
            {
                params ["", "", "_isJIP"];
                (_this#0) call (_this#1);
            },
            [_params, _code, _isJIP],
            _delay
        ] call CBA_fnc_waitAndExecute;
    };

    case "DELAY": {
        _args params [ [ "_addDelay", 7, [0] ] ];
        _delay = _delay + _addDelay;
    };

    case "TEXT": {
        _args params [ [ "_strings", "", ["",[]] ], [ "_duration", _defaultDelay, [0] ] ];

        _duration = _duration max 5;

        private _defaultSize  = missionNamespace getVariable [QGVAR(cutscene_defaultSize), 3];
        private _defaultColor = missionNamespace getVariable [QGVAR(cutscene_defaultColor), "#690000"];
        private _defaultFont  = missionNamespace getVariable [QGVAR(cutscene_defaultFont), "EraserRegular"];

        if (_strings isEqualType "") then { _strings = [_strings] };

        _strings = _strings apply { format [ "<t size=%1 color='%2' font='%3'>%4</t>", _defaultSize, _defaultColor, _defaultFont, _x ] };

        private _fullString = _strings joinString "<br/>";

        [{ LAYER_NUM_TEXT cutText [_this#0, "BLACK OUT",   _this#1, true, true, true]; }, [_fullString, _duration * 0.15], _delay + _duration * 0.00] call CBA_fnc_waitAndExecute;
        [{ LAYER_NUM_TEXT cutText [_this#0, "BLACK FADED", _this#1, true, true, true]; }, [_fullString, _duration * 0.70], _delay + _duration * 0.15] call CBA_fnc_waitAndExecute;
        [{ LAYER_NUM_TEXT cutText [_this#0, "BLACK IN",    _this#1, true, true, true]; }, [_fullString, _duration * 0.15], _delay + _duration * 0.85] call CBA_fnc_waitAndExecute;

        _delay = _delay + _duration;
    };

    case "TEXT_PLAIN": {
        _args params [ [ "_strings", "", ["",[]] ], [ "_duration", _defaultDelay, [0] ] ];

        _duration = _duration max 5;

        private _defaultSize  = missionNamespace getVariable [QGVAR(cutscene_defaultSize), 3];
        private _defaultColor = missionNamespace getVariable [QGVAR(cutscene_defaultColor), "#690000"];
        private _defaultFont  = missionNamespace getVariable [QGVAR(cutscene_defaultFont), "EraserRegular"];

        if (_strings isEqualType "") then { _strings = [_strings] };

        _strings = _strings apply { format [ "<t size=%1 color='%2' font='%3'>%4</t>", _defaultSize, _defaultColor, _defaultFont, _x ] };

        private _fullString = _strings joinString "<br/>";

        [{ LAYER_NUM_TEXT_PLAIN cutText [_this#0, "PLAIN", _this#1, true, true, true]; }, [_fullString, _duration / 10], _delay] call CBA_fnc_waitAndExecute;
        _delay = _delay + _duration;
    };

    case "RAVEN": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        private _string = format ["<img shadow='0' size=20 image='%1'/>",QPATHTOEF(main,data\Raven_Voron_white_1024.paa)];

        [{ LAYER_NUM_IMG cutText [_this#0, "PLAIN", _this#1, true, true, true]; }, [_string, _duration * 0.10], _delay] call CBA_fnc_waitAndExecute;
    };

    case "QUIET": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        private _string = format ["<img shadow='0' size=10 image='%1'/>",QPATHTOF(data\quietplease.paa)];
        [{ LAYER_NUM_IMG cutText [_this#0, "PLAIN", _this#1, true, true, true]; }, [_string, _duration * 0.10], _delay] call CBA_fnc_waitAndExecute;
    };

    case "MUTE": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        [
            {
                ace_hearing_disableVolumeUpdate = true;
                _this fadeSound 0;
                _this fadeEnvironment 0;
                [0.05] call acre_api_fnc_setGlobalVolume;
            },
            _duration,
            _delay
        ] call CBA_fnc_waitAndExecute;
    };

    case "UNMUTE": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        [
            {
                _this fadeSound 1;
                _this fadeEnvironment 1;
                [1] call acre_api_fnc_setGlobalVolume;
            },
            _duration,
            _delay
        ] call CBA_fnc_waitAndExecute;

        [
            {
                ace_hearing_disableVolumeUpdate = nil;
            },
            "",
            _delay + _duration
        ] call CBA_fnc_waitAndExecute;
    };

    case "MUSIC_BOOST": {
        _args params [ [ "_duration", 2, [0] ] ];

        [
            {
                GVAR(cutscene_cache_allowFadeMusic) = ace_common_allowFadeMusic;
                ace_common_allowFadeMusic = true;

                GVAR(cutscene_cache_prevMusicVolume) = musicVolume;
                _this fadeMusic 2;
            },
            _duration,
            _delay
        ] call CBA_fnc_waitAndExecute;
    };

    case "MUSIC_RESET": {
        _args params [ [ "_duration", _defaultDelay, [0] ] ];

        [
            {
                _this fadeMusic GVAR(cutscene_cache_prevMusicVolume);
                GVAR(cutscene_cache_prevMusicVolume) = nil;
            },
            _duration,
            _delay
        ] call CBA_fnc_waitAndExecute;

        [
            {
                // reset and Cleanup after fade complete
                ace_common_allowFadeMusic = GVAR(cutscene_cache_allowFadeMusic);
                GVAR(cutscene_cache_allowFadeMusic) = nil;
            },
            "",
            _delay + _duration
        ] call CBA_fnc_waitAndExecute;
    };

    case "MUSIC": {
        _args params [ [ "_musicClass", "", [""] ]];

        [ { playMusic _this }, _musicClass, _delay ] call CBA_fnc_waitAndExecute;
    };

    default { WARNING_1("Not Compatible Input: %1",_this); };
};

missionNamespace setVariable [QGVAR(cutscene_delay), _delay];

