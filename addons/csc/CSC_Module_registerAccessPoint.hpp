class GVAR(module_registerAccessPoint): Module_F {
    // Standard object definitions:
    scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                               // Zeus visibility
    displayName = CSTRING(module_registerAccessPoint);                   // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_registerAccessPoint);    // Name of function triggered once conditions are met
    functionPriority = 11;                           // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
    isGlobal = 0;                                    // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isTriggerActivated = 0;                          // 1 for module waiting until all synced triggers are activated
    isDisposable = 1;                                // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
    is3DEN = 0;                                      // 1 to run init function in Eden Editor as well
    curatorCanAttach = 0;                            // 1 to allow Zeus to attach the module to an entity

    // 3DEN Attributes Menu Options
    canSetArea = 0;                         // Allows for setting the area values in the Attributes menu in 3DEN
    canSetAreaShape = 0;                    // Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
    canSetAreaHeight = 0;                   // Allows for setting height or Z value in Attributes menu in 3DEN

    // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
    class Attributes: AttributesBase {
        // Module-specific arguments:

        class SubCategory_AccessPoint {
            control = "SubCategory";
            title = "Access Point";
            property = Q(SubCategory_AccessPoint);
        };
        class crates: Edit {
            displayName = "Crates";
            tooltip = "List of Crate-id's available at this AccessPoint.\nSeperate entries with space or ,\n'#ALL' will add all registered entries.";
            property = "crates";
            typeName = "STRING";
            defaultValue = "'#ALL'"; // Because this is an expression, one must have a string within a string to return a string
        };
        class deliveryModes: Edit {
            displayName = "Delivery Modes";
            tooltip = "List of DeliveryMode-id's available at this AccessPoint.\nSeperate entries with space or ,\n'#ALL' will add all registered entries.";
            property = "deliveryModes";
            typeName = "STRING";
            defaultValue = "''"; // Because this is an expression, one must have a string within a string to return a string
        };
        class destinations: Edit {
            displayName = "Destinations";
            tooltip = "List of Destination-id's available at this AccessPoint.\nSeperate entries with space or ,\n'#ALL' will add all registered entries.";
            property = "destinations";
            typeName = "STRING";
            defaultValue = "''"; // Because this is an expression, one must have a string within a string to return a string
        };


        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Adds Ace Interaction for AccessPoint on the synced objects.";
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};
