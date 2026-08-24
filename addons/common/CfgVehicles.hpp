class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            // class Default;
            class Edit;                 // Default edit box (i.e. text input field)
            // class Combo;                // Default combo box (i.e. drop-down menu)
            class Checkbox;             // Default checkbox (returned value is Boolean)
            // class CheckboxNumber;       // Default checkbox (returned value is Number)
            // class ModuleDescription;    // Module description
            // class Units;                // Selection of units on which the module is applied
        };

        // Description base classes (for more information see below):
        class ModuleDescription {
            // class AnyBrain;
        };
    };

    class GVAR(module_healStation): Module_F {
        // Standard object definitions:
        scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 1;                                               // Zeus visibility
        displayName = CSTRING(healStation_displayName);                   // Name displayed in the menu
        icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
        category = QGVAR(factionClass);

        function = QFUNC(module_healStation);     // Name of function triggered once conditions are met
        functionPriority = 10;                  // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        isGlobal = 0;                           // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isTriggerActivated = 0;                 // 1 for module waiting until all synced triggers are activated
        isDisposable = 1;                       // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
        is3DEN = 0;                             // 1 to run init function in Eden Editor as well
        curatorCanAttach = 0;                   // 1 to allow Zeus to attach the module to an entity

        // 3DEN Attributes Menu Options
        canSetArea = 0;                         // Allows for setting the area values in the Attributes menu in 3DEN
        canSetAreaShape = 0;                    // Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
        canSetAreaHeight = 0;                   // Allows for setting height or Z value in Attributes menu in 3DEN

        // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
        class Attributes: AttributesBase {
            // Module-specific arguments:
            class GVAR(duration): Edit {
                displayName = "Duration";
                tooltip = "Duration of the progressbar before the action is completed";
                property = QGVAR(duration);
                // Default text for the input box:
                typeName = "NUMBER";							// Value type, can be "NUMBER", "STRING" or "BOOL"
                validate = "number";
                defaultValue = 30; // Because this is an expression, one must have a string within a string to return a string
            };
            class GVAR(chance): Edit {
                displayName = "Chance";
                tooltip = "Chance of easteregg to be happening. 0 - 100";
                property = QGVAR(chance);
                typeName = "NUMBER";							// Value type, can be "NUMBER", "STRING" or "BOOL"
                validate = "number";
                defaultValue = 1; // Because this is an expression, one must have a string within a string to return a string
            };

            class ModuleDescription: ModuleDescription {}; // Module description should be shown last
        };

        // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
        class ModuleDescription: ModuleDescription {
            description = "Defines Object as a Heal Station and adds ACE Interaction to it.";    // Short description, will be formatted as structured text
            sync[] = {};                // Array of synced entities (can contain base classes)
        };
    };

    class GVAR(module_makeRemovable): Module_F {
        // Standard object definitions:
        scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 1;                                               // Zeus visibility
        displayName = CSTRING(makeRemovable_displayName);                   // Name displayed in the menu
        icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
        category = QGVAR(factionClass);

        function = QFUNC(module_makeRemovable);     // Name of function triggered once conditions are met
        functionPriority = 10;                  // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        isGlobal = 0;                           // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isTriggerActivated = 0;                 // 1 for module waiting until all synced triggers are activated
        isDisposable = 1;                       // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
        is3DEN = 0;                             // 1 to run init function in Eden Editor as well
        curatorCanAttach = 0;                   // 1 to allow Zeus to attach the module to an entity

        // 3DEN Attributes Menu Options
        canSetArea = 0;                         // Allows for setting the area values in the Attributes menu in 3DEN
        canSetAreaShape = 0;                    // Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
        canSetAreaHeight = 0;                   // Allows for setting height or Z value in Attributes menu in 3DEN

        // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):

        class Attributes: AttributesBase {
            // Module-specific arguments:
            class GVAR(duration): Edit {
                displayName = "Duration";
                tooltip = "Duration of the progressbar before the action is completed";
                property = QGVAR(duration);
                // Default text for the input box:
                typeName = "NUMBER";							// Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = 30; // Because this is an expression, one must have a string within a string to return a string
            };
            class GVAR(requireWirecutter): Checkbox {
                displayName = "Require ACE Wirecutters";
                tooltip = "The Remove-Action will only be available to those with ACE Wirecutters";
                property = QGVAR(requireWirecutter);
                // Default text for the input box:
                defaultValue = "true"; // Because this is an expression, one must have a string within a string to return a string
            };

            class ModuleDescription: ModuleDescription {}; // Module description should be shown last
        };


        // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
        class ModuleDescription: ModuleDescription {
            description = "Defines Object as Removable and adds ACE Interaction to it.";    // Short description, will be formatted as structured text
            sync[] = {};                // Array of synced entities (can contain base classes)
        };
    };
};
