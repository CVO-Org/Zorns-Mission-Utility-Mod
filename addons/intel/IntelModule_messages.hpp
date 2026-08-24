#define MESSAGE_TYPE_NONE(INDEX)\
class GVAR(TRIPLES(message,INDEX,type)): Combo {\
    displayName = Q(INDEX. Message: Type);\
    tooltip = "Who is sending the message?";\
    property = QGVAR(TRIPLES(message,INDEX,type));\
    typeName = "STRING";\
    defaultValue = """NONE""";\
    class values {\
        class NONE {\
            default = 1;\
            name = "NONE";\
            value = "NONE";\
        };\
        class RECIPIENT {\
            name = "RECIPIENT";\
            value = "RECIPIENT";\
        };\
        class SENDER {\
            name = "SENDER";\
            value = "SENDER";\
        };\
    };\
}

#define MESSAGE_TYPE_RECIPIENT(INDEX)\
class GVAR(TRIPLES(message,INDEX,type)): Combo {\
    displayName = Q(INDEX. Message: Type);\
    tooltip = "Who is sending the message?";\
    property = QGVAR(TRIPLES(message,INDEX,type));\
    typeName = "STRING";\
    defaultValue = """RECIPIENT""";\
    class values {\
        class NONE {\
            name = "NONE";\
            value = "NONE";\
        };\
        class RECIPIENT {\
            default = 1;\
            name = "RECIPIENT";\
            value = "RECIPIENT";\
        };\
        class SENDER {\
            name = "SENDER";\
            value = "SENDER";\
        };\
    };\
}

#define MESSAGE_TYPE_SENDER(INDEX)\
class GVAR(TRIPLES(message,INDEX,type)): Combo {\
    displayName = Q(INDEX. Message: Type);\
    tooltip = "Who is sending the message?";\
    property = QGVAR(TRIPLES(message,INDEX,type));\
    typeName = "STRING";\
    defaultValue = """SENDER""";\
    class values {\
        class NONE {\
            name = "NONE";\
            value = "NONE";\
        };\
        class RECIPIENT {\
            name = "RECIPIENT";\
            value = "RECIPIENT";\
        };\
        class SENDER {\
            default = 1;\
            name = "SENDER";\
            value = "SENDER";\
        };\
    };\
}

#define MESSAGE_TEXT(INDEX,DEFAULT)\
class GVAR(TRIPLES(message,INDEX,text)): Edit {\
    control = "EditMulti3";\
    displayName = Q(INDEX. Message: Text);\
    tooltip = "Content of the Message\nUse <br\> for linebreaks";\
    property = QGVAR(TRIPLES(message,INDEX,text));\
    typeName = "STRING";\
    defaultValue = QQ(Q(DEFAULT));\
}
#define MESSAGE_TEXT_EMPTY(INDEX)\
class GVAR(TRIPLES(message,INDEX,text)): Edit {\
    control = "EditMulti3";\
    displayName = Q(INDEX. Message: Text);\
    tooltip = "Content of the Message\nUse <br\> for linebreaks";\
    property = QGVAR(TRIPLES(message,INDEX,text));\
    typeName = "STRING";\
    defaultValue = """""";\
}


class GVAR(module_IntelItem_messages): Module_F {
    // Standard object definitions:
    scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                               // Zeus visibility
    displayName = CSTRING(module_IntelItem_messages_displayName);                   // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_IntelItem_messages);     // Name of function triggered once conditions are met
    functionPriority = 10;                        // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
    isGlobal = 0;                                 // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isTriggerActivated = 0;                       // 1 for module waiting until all synced triggers are activated
    isDisposable = 1;                             // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
    is3DEN = 0;                                   // 1 to run init function in Eden Editor as well
    curatorCanAttach = 0;                         // 1 to allow Zeus to attach the module to an entity

    // 3DEN Attributes Menu Options
    canSetArea = 0;                         // Allows for setting the area values in the Attributes menu in 3DEN
    canSetAreaShape = 0;                    // Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
    canSetAreaHeight = 0;                   // Allows for setting height or Z value in Attributes menu in 3DEN

    // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
    class Attributes: AttributesBase {
        // Module-specific arguments:

        INTEL_GROUP;
        INTEL_TITLE(Recovered Messages);
        INTEL_DESC(Most of the messages seem irrelevant but this conversation cought your attention...);

        class GVAR(senderName): Edit {
            displayName = "Message Sender";
            tooltip = "Name of the Message Partner.\nWhen empty, defaults to: 'Unknown'";
            property = QGVAR(senderName);
            defaultValue = """M. Muster"""; // Because this is an expression, one must have a string within a string to return a string
        };
        class GVAR(senderMeta): Edit {
            displayName = "Message Meta";
            tooltip = "Subtitle of Message Partner.\nWhen empty, defaults to: 'Last Activity: Unknown'";
            property = QGVAR(senderMeta);
            defaultValue = """Last seen: Yesterday"""; // Because this is an expression, one must have a string within a string to return a string
        };

        MESSAGE_TYPE_SENDER(1);
        MESSAGE_TEXT(1,Knock Knock);

        MESSAGE_TYPE_RECIPIENT(2);
        MESSAGE_TEXT(2,Who is there?);

        MESSAGE_TYPE_SENDER(3);
        MESSAGE_TEXT(3,A. Joke);

        MESSAGE_TYPE_RECIPIENT(4);
        MESSAGE_TEXT(4,Dude wtf...);

        MESSAGE_TYPE_NONE(5);
        MESSAGE_TEXT_EMPTY(5);

        MESSAGE_TYPE_NONE(6);
        MESSAGE_TEXT_EMPTY(6);

        MODULE_ATTRIBUTES_META(Check for messages...);

        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Turns an Object into an MUM INTEL ITEM.";    // Short description, will be formatted as structured text
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};
