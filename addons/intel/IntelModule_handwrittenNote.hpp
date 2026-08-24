

class GVAR(module_IntelItem_handwrittenNote): Module_F {
    // Standard object definitions:
    scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                               // Zeus visibility
    displayName = CSTRING(module_IntelItem_handwrittenNote_displayName);                   // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_IntelItem_handwrittenNote);     // Name of function triggered once conditions are met
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
        INTEL_TITLE(Handwritten Note);
        INTEL_DESC(The note seems hastily written and is hard to read...);

        class GVAR(intel_handwritten): Edit {
            control = "EditMulti5";
            displayName = "Handrwitten Note";
            tooltip = "Body of the Intel Content.\nUsed for the actual, handwritten text.\n Use <br/> for linebreaks.";
            property = QGVAR(intel_handwritten);
            defaultValue = "'Meet us in the destroyed village.<br/>Be careful, they are watching!'"; // Because this is an expression, one must have a string within a string to return a string
        };

        MODULE_ATTRIBUTES_META(Investigate the note...);

        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Turns an Object into an MUM INTEL ITEM.";    // Short description, will be formatted as structured text
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};
