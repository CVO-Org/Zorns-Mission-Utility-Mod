[
    QSET(save_arsenalClose),//    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX",                                //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    SETLSTRING(save_arsenalClosed),
                                            //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [LSTRING(set_cat_title),LSTRING(set_subcat_save)],                    //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
    true,                                    //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    1,                                        //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
    {},                                        //    _script      - Script to execute when setting is changed. (optional) <CODE>
    true                                    //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


[
    QSET(save_missionStart),//    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX",                                //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    SETLSTRING(save_missionstart),
                                            //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [LSTRING(set_cat_title),LSTRING(set_subcat_save)],                    //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
    true,                                    //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    1,                                        //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
    {},                                        //    _script      - Script to execute when setting is changed. (optional) <CODE>
    true                                    //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


[
    QSET(save_missionStart_delay),//    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "SLIDER",                                //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    SETLSTRING(save_missionStart_delay),
                                            //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [LSTRING(set_cat_title),LSTRING(set_subcat_save)],                    //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 60, 30, 0, false],                                    //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    1,                                        //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
    {},                                        //    _script      - Script to execute when setting is changed. (optional) <CODE>
    true                                    //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


[
    QSET(load_onRespawn),//    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX",                                //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    SETLSTRING(apply_onRespawn),
//    ["Load Player Loadout on Respawn","Load Player Loadout on Respawn"],
                                            //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [LSTRING(set_cat_title),LSTRING(set_subcat_load)],                    //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
    true,                                    //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
    1,                                        //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
    {},                                        //    _script      - Script to execute when setting is changed. (optional) <CODE>
    true                                    //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
