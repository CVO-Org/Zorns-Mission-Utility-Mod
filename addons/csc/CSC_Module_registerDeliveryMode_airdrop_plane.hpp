class GVAR(module_registerDeliveryMode_airdrop_plane): Module_F {
    // Standard object definitions:
    scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                               // Zeus visibility
    displayName = CSTRING(module_registerDestination_fixed);                   // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_registerDestination_fixed);          // Name of function triggered once conditions are met
    functionPriority = 10;                           // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
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

        class SubCategory_General {
            control = "SubCategory";
            title = "General";
            property = Q(SubCategory_General);
        };

        class id: Edit {
            displayName = "Unique Identifier";
            tooltip = "Must be a unique identifier. This will be used to reference this Destination throughout the framework.";
            property = "id";
            typeName = "STRING";
            defaultValue = "''"; // Because this is an expression, one must have a string within a string to return a string
        };
        class displayName: Edit {
            displayName = "Display Name";
            tooltip = "";
            property = "displayName";
            typeName = "STRING";
            defaultValue = "'Fixed: Debug Corner'"; // Because this is an expression, one must have a string within a string to return a string
        };
        class description: Edit {
            displayName = "Description";
            tooltip = "Description of the Destination";
            property = "description";
            typeName = "STRING";
            defaultValue = "''"; // Because this is an expression, one must have a string within a string to return a string
        };

        class SubCategory_Parameters {
            control = "SubCategory";
            title = "Parameters";
            property = Q(SubCategory_Parameters);
        };

        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Registers a Destination to the CSC Framework. Syced connections have no effect.";
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};

