class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Edit;					// Default edit box (i.e. text input field)
            class Combo;				// Default combo box (i.e. drop-down menu)
            class Checkbox;				// Default checkbox (returned value is Boolean)
            class CheckboxNumber;		// Default checkbox (returned value is Number)
            class ModuleDescription;	// Module description
            class Units;				// Selection of units on which the module is applied
        };

        // Description base classes (for more information see below):
        class ModuleDescription {
            class AnyBrain;
        };
    };

    class GVAR(module_departure): Module_F {
        // Standard object definitions:
        scope = 2;										            // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 1;								            // Zeus visibility
        displayName = CSTRING(departure_displayName);               // Name displayed in the menu
        icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";	// Map icon. Delete this entry to use the default icon.
        category = QGVAR(factionClass);

        function = QFUNC(module_departure);	// Name of function triggered once conditions are met
        functionPriority = 10;				// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        isGlobal = 1;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isTriggerActivated = 1;				// 1 for module waiting until all synced triggers are activated
        isDisposable = 0;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
        is3DEN = 0;							// 1 to run init function in Eden Editor as well
        curatorCanAttach = 0;				// 1 to allow Zeus to attach the module to an entity

        // 3DEN Attributes Menu Options
        canSetArea = 0;						// Allows for setting the area values in the Attributes menu in 3DEN
        canSetAreaShape = 0;				// Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
        canSetAreaHeight = 0;				// Allows for setting height or Z value in Attributes menu in 3DEN

        // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
        class Attributes: AttributesBase {
            // Module-specific arguments:
            class GVAR(network): Edit {
                displayName = "Network Name";
                tooltip = "Destination Points with the same Network Name can be teleported to from this Departure Point";
                property = QGVAR(network);
                // Default text for the input box:
                defaultValue = """Default"""; // Because this is an expression, one must have a string within a string to return a string
            };

            class ModuleDescription: ModuleDescription {}; // Module description should be shown last
        };


        // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
        class ModuleDescription: ModuleDescription {
            description = "Defines Object as a Departure Point and adds ACE Interaction to it.";	// Short description, will be formatted as structured text
            sync[] = {};				// Array of synced entities (can contain base classes)
        };
    };

    class GVAR(module_destination): Module_F {
        // Standard object definitions:
        scope = 2;										            // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 1;								            // Zeus visibility
        displayName = CSTRING(destination_displayName);               // Name displayed in the menu
        icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";	// Map icon. Delete this entry to use the default icon.
        category = QGVAR(factionClass);

        function = QFUNC(module_destination);	// Name of function triggered once conditions are met
        functionPriority = 10;				// Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        isGlobal = 1;						// 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isTriggerActivated = 1;				// 1 for module waiting until all synced triggers are activated
        isDisposable = 0;					// 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
        is3DEN = 0;							// 1 to run init function in Eden Editor as well
        curatorCanAttach = 1;				// 1 to allow Zeus to attach the module to an entity

        // 3DEN Attributes Menu Options
        canSetArea = 0;						// Allows for setting the area values in the Attributes menu in 3DEN
        canSetAreaShape = 0;				// Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
        canSetAreaHeight = 0;				// Allows for setting height or Z value in Attributes menu in 3DEN

        // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
        class Attributes: AttributesBase {
            // Module-specific arguments:
            class GVAR(network): Edit {
                displayName = "Network Name";
                tooltip = "Destination Points with the same Network Name can be teleported to from this Departure Point";
                property = QGVAR(network);
                // Default text for the input box:
                defaultValue = """Default"""; // Because this is an expression, one must have a string within a string to return a string
            };

            class ModuleDescription: ModuleDescription {}; // Module description should be shown last
        };


        // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
        class ModuleDescription: ModuleDescription {
            description = "Defines Object as a Departure Point, which can be teleported towards to from a Departure Point.";	// Short description, will be formatted as structured text
            sync[] = {};				// Array of synced entities (can contain base classes)
        };
    };
};
