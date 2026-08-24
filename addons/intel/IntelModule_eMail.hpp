

class GVAR(module_IntelItem_email): Module_F {
    // Standard object definitions:
    scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                               // Zeus visibility
    displayName = CSTRING(module_IntelItem_email_displayName);                   // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_IntelItem_email);     // Name of function triggered once conditions are met
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

        INTEL_GROUP;
        INTEL_TITLE(Recovered eMail);
        INTEL_DESC(Most of the eMails seem irrelevant but this one cought your eye...);

        class GVAR(emailDate): Edit {
            displayName = "eMail Date";
            tooltip = "Ignored if left empty";
            property = QGVAR(emailDate);
            defaultValue = "'2035-07-07 13:37:69'"; // Because this is an expression, one must have a string within a string to return a string
        };
        class GVAR(emailSender): Edit {
            displayName = "eMail Sender";
            tooltip = "Ignored if left empty";
            property = QGVAR(emailSender);
            defaultValue = "'noreply@nhs.co.uk'"; // Because this is an expression, one must have a string within a string to return a string
        };
        class GVAR(emailRecipient): Edit {
            displayName = "eMail Recipient";
            tooltip = "Ignored if left empty";
            property = QGVAR(emailRecipient);
            defaultValue = "'ThomasAdams@aol.com'"; // Because this is an expression, one must have a string within a string to return a string
        };
        class GVAR(emailSubject): Edit {
            displayName = "eMail Subject";
            tooltip = "Ignored if left empty";
            property = QGVAR(emailSubject);
            defaultValue = "'Re: Life Insurance'"; // Because this is an expression, one must have a string within a string to return a string
        };

        class GVAR(emailText): Edit {
            control = "EditMulti5";
            displayName = "eMail Text";
            tooltip = "Body of the eMail.\n Use <br/> for linebreaks.";
            property = QGVAR(emailText);
            defaultValue = "'We have been trying to reach you regarding your lifes extended warrenty!'"; // Because this is an expression, one must have a string within a string to return a string
        };

        MODULE_ATTRIBUTES_META(Check for eMails...);

        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Turns an Object into an MUM INTEL ITEM.";    // Short description, will be formatted as structured text
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};
