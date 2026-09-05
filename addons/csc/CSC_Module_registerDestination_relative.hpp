class GVAR(module_registerDestination_relative): Module_F {
    // Standard object definitions:
    scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                               // Zeus visibility
    displayName = CSTRING(module_registerDestination_relative);                   // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_registerDestination_relative);          // Name of function triggered once conditions are met
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
            unique = 1; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
        };
        class displayName: Edit {
            displayName = "Display Name";
            tooltip = "Name of the Destination";
            property = "displayName";
            typeName = "STRING";
            defaultValue = "''"; // Because this is an expression, one must have a string within a string to return a string
        };
        class description_string: Edit {
            displayName = "Description";
            tooltip = "Description of the Destination";
            property = "description_string";
            typeName = "STRING";
            defaultValue = "''"; // Because this is an expression, one must have a string within a string to return a string
        };

        class SubCategory_Parameters {
            control = "SubCategory";
            title = "Parameters";
            property = Q(SubCategory_Parameters);
        };

        class reference: Edit {
           displayName = "Reference";
           tooltip = "Ether 'PLAYER', 'TARGET' or global variable of an object.\n'PLAYER' to reference the player.\n'TARGET' to reference the Access Point.\nWhen left empty and synced to one object, the object is being referenced.";
           property = "reference";
           typeName = "STRING";
           defaultValue = """PLAYER""";
        };

        class mode: Combo {
           displayName = "Mode";
           tooltip = "Defines the relative Position from the reference";
           property = "mode";
           typeName = "STRING";
           defaultValue = """OFFSET""";
           class values {
                class FRONT {
                   default = 0;
                   name = "Relative Offset Front";
                   value = "FRONT";
                };
                class BEHIND {
                   default = 0;
                   name = "Relative Offset Behind";
                   value = "BEHIND";
                };
                class OFFSET {
                   default = 1;
                   name = "Fixed Offset";
                   value = "OFFSET";
                };
           };
        };

        class offset: Edit {
            control = "EditXYZ";
            displayName = "Offset";
            tooltip = "Used when mode 'OFFSET' is selected.";
            property = "offset";
            defaultValue = "[0,0,2]"; // Because this is an expression, one must have a string within a string to return a string
        };

        class randomOffset: Edit {
            control = "EditShort";
            displayName = "Random Offset";
            tooltip = "Random Offset used for randomized final position";
            property = "randomOffset";
            typeName = "NUMBER";
            defaultValue = "0"; // Because this is an expression, one must have a string within a string to return a string
        };

        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Registers a Destination to the CSC Framework.";
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};
