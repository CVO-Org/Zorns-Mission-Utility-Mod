[
    QSET(disableIntelSummary),                                    //    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX",                                                    //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    SETLSTRING(disableIntelSummary),
                                                                //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [LSTRING(set_cat_title),LSTRING(set_subcat_general)],        //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
    false,                                                        //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    1,                                                            //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
    FUNC(updateSummary),                                        //    _script      - Script to execute when setting is changed. (optional) <CODE>
    true                                                        //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
    QSET(default_shareWith),                                                                //    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "LIST",                                                                                    //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    SETLSTRING(default_shareWith),
                                                                                            //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [LSTRING(set_cat_title),LSTRING(set_subcat_general)],                                    //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
    [["GLOBAL", "SIDE", "GROUP", "UNIT"], ["GLOBAL", "SIDE", "GROUP", "UNIT"], 1],            //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    1,                                                                                        //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
    {},                                                                                        //    _script      - Script to execute when setting is changed. (optional) <CODE>
    true                                                                                    //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

