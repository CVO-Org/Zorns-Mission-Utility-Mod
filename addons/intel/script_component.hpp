#define COMPONENT intel
#define COMPONENT_BEAUTIFIED Intel


#include "\zrn\MUM\addons\main\script_mod.hpp"
#include "\zrn\MUM\addons\main\script_macros.hpp"


#define COLOR_GREY color=QQ(#b8b9b9)

#define INTEL_GROUP\
class GVAR(intelGroup): Edit {\
    displayName = "Intel Group";\
    tooltip = "Used for the Intel Summary Feature.\nExamples: ""First Objective"", ""Bomb Makers Hideout""";\
    property = QGVAR(intelGroup);\
    defaultValue = "'Gathered Intel'";\
}

#define INTEL_TITLE(TITLE)\
class GVAR(intelTitle): Edit {\
    displayName = "Intel Title";\
    tooltip = "Used for the Intel Summary Feature.\nExamples: ""First Objective"", ""Bomb Makers Hideout""";\
    property = QGVAR(intelTitle);\
    defaultValue = QQ(Q(TITLE));\
}

#define INTEL_DESC(DESC)\
class GVAR(intel_desc): Edit {\
    control = "EditMulti3";\
    displayName = "Intel Description";\
    tooltip = "Above of the intel content.\nUsed for rough description.\n Use <br/> for linebreaks.";\
    property = QGVAR(intel_desc);\
    defaultValue = QQ(Q(DESC));\
}


#define MODULE_ATTRIBUTES_META(ACTION_TITLE)\
class GVAR(removeObject): Checkbox {\
    displayName = "Remove Object";\
    tooltip = "Wether the Object shall be removed once found or not.";\
    property = QGVAR(removeObject);\
    defaultValue = "true";\
};\
class GVAR(actionTitle): Edit {\
    displayName = "Action Title";\
    tooltip = "Text of ACE Action and Progressbar";\
    property = QGVAR(actionTitle);\
    defaultValue = QQ(Q(ACTION_TITLE));\
};\
class GVAR(actionDuration): Edit {\
    displayName = "Action Duration";\
    tooltip = "Duration of the progressbar in seconds";\
    property = QGVAR(actionDuration);\
    typeName = "NUMBER";\
    validate = "number";\
    defaultValue = 15;\
};\
class GVAR(actionSound): Combo {\
    displayName = "Action Sound";\
    tooltip = "Type of sounds to be played during the gathering process";\
    property = QGVAR(actionSound);\
    typeName = "STRING";\
    defaultValue = """AUTO""";\
    class values {\
        class AUTO {\
            default = 1;\
            name = "AUTO";\
            value = "AUTO";\
        };\
        class BODY {\
            name = "BODY";\
            value = "BODY";\
        };\
        class KEYOARD {\
            name = "KEYOARD";\
            value = "KEYOARD";\
        };\
    };\
};\
class GVAR(shareWith): Combo {\
    displayName = "Share With";\
    tooltip = "Who the intel is being shared with when found";\
    property = QGVAR(shareWith);\
    defaultValue = """DEFAULT""";\
    class values {\
        class GLOBAL {\
            name = "GLOBAL";\
            value = "GLOBAL";\
        };\
        class SIDE {\
            name = "SIDE";\
            value = "SIDE";\
        };\
        class GROUP {\
            name = "GROUP";\
            value = "GROUP";\
        };\
        class UNIT {\
            name = "UNIT";\
            value = "UNIT";\
        };\
        class DEFAULT {\
            default = 1;\
            name = "DEFAULT";\
            value = "DEFAULT";\
        };\
    };\
}
