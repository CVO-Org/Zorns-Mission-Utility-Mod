#include "../script_component.hpp"

/*    here, you put in your CBA Settings so they are available in the editor! */

[
    QSET(mode),                                         //    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "LIST",                                             //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    SETLSTRING(ui_mode),
                                                        //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    LSTRING(cba_category),                           //    _networkegory    - Category for the settings menu + optional sub-category <STRING, ARRAY>
    [["GUI DIALOG","ACE ACTION"],["DIALOG","ACE ACTION"], 0],                                    //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    0,                                                  //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
    {},                                                 //    _script      - Script to execute when setting is changed. (optional) <CODE>
    true                                                //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
