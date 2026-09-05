class GVAR(module_registerDeliveryMode_drone): Module_F {
    // Standard object definitions:
    scope = 2;                                                                  // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                                           // Zeus visibility
    displayName = CSTRING(module_registerDeliveryMode_drone);                   // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";                 // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_registerDeliveryMode_drone);                    // Name of function triggered once conditions are met
    functionPriority = 10;                                                  // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
    isGlobal = 0;                                                           // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isTriggerActivated = 0;                                                 // 1 for module waiting until all synced triggers are activated
    isDisposable = 1;                                                       // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
    is3DEN = 0;                                                             // 1 to run init function in Eden Editor as well
    curatorCanAttach = 0;                                                   // 1 to allow Zeus to attach the module to an entity

    // 3DEN Attributes Menu Options
    canSetArea = 0;                                                         // Allows for setting the area values in the Attributes menu in 3DEN
    canSetAreaShape = 0;                                                    // Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
    canSetAreaHeight = 0;                                                   // Allows for setting height or Z value in Attributes menu in 3DEN

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
            tooltip = "";
            property = "displayName";
            typeName = "STRING";
            defaultValue = "''";                        // Because this is an expression, one must have a string within a string to return a string
        };
        class description_string: Edit {
            displayName = "Description";
            tooltip = "Description of the Delivery Method";
            property = "description_string";
            typeName = "STRING";
            defaultValue = "''";                        // Because this is an expression, one must have a string within a string to return a string
        };
        class maxCrates: Edit {
            control = "EditShort";
            displayName = "Max Crates";
            tooltip = "Maximum Amount of crates for this Delivery Method";
            property = "maxCrates";
            typeName = "NUMBER";
            defaultValue = 1;                           // Because this is an expression, one must have a string within a string to return a string
        };
        class cooldown: Edit {
            control = "EditShort";
            displayName = "Cooldown";
            tooltip = "Cooldown in seconds for this delivery method to be availabe again.\n0 will disable cooldown.";
            property = "cooldown";
            typeName = "NUMBER";
            defaultValue = 900;                         // Because this is an expression, one must have a string within a string to return a string
        };

        class SubCategory_Drone {
            control = "SubCategory";
            title = "Drone";
            property = Q(SubCategory_Drone);
        };

        class drone_class: Edit {
            displayName = "Classname";
            tooltip = "Classname of the drone";
            property = "drone_class";
            typeName = "STRING";
            defaultValue = """B_UAV_06_F""";
        };
        class drone_protected: Checkbox {
            displayName = "Protected";
            tooltip = "Makes the Drone invincible.";
            property = "drone_protected";
            typeName = "BOOL";
            defaultValue = "true";
        };
        class drone_side: Combo {
            displayName = "Side";
            tooltip = "The side the drone should be assigned to.";
            property = "drone_side";
            typeName = "STRING";
            defaultValue = """CIV""";
            class values {
               class CIV {
                  default = 1;
                  name = "CIV";
                  value = "CIV";
               };
                class WEST {
                    default = 0;
                    name = "WEST";
                    value = "WEST";
                };
                class EAST {
                    default = 0;
                    name = "EAST";
                    value = "EAST";
                };
                class GUER {
                    default = 0;
                    name = "GUER";
                    value = "GUER";
                };
           };
        };

        class SubCategory_startingPosition {
            control = "SubCategory";
            title = "Starting Position";
            property = Q(SubCategory_startingPosition);
        };

        class mode: Combo {
            displayName = "Mode";
            tooltip = "Where should the Drone be spawned?\nStarting Position: When left empty, Module's Position will be taken.\nEdge: Nearest/Furhtest Edge of the Map relative to the Start/Module Position.";
            property = "mode";
            typeName = "STRING";
            defaultValue = """EDGE_NEAR""";
            class values {
                class EDGE_NEAR {
                    default = 1;
                    name = "Edge - Nearest";
                    value = "EDGE_NEAR";
                };
                class EDGE_FAR  {
                    default = 0;
                    name = "Edge - Furthest";
                    value = "EDGE_FAR";
                };
                class STARTPOS {
                    default = 0;
                    name = "Start/Module Pos";
                    value = "STARTPOS";
                };
            };
        };

        class pos_start: Edit {
            control = "EditXYZ";
            displayName = "Start Position";
            tooltip = "When left at default [0,0,0], the module's position will be taken.";
            property = "pos_start";
            defaultValue = "[0,0,0]"; // Because this is an expression, one must have a string within a string to return a string
        };

        class pos_end: Combo {
            displayName = "After Drop";
            tooltip = "Defines the behavior after the drop.";
            property = Q(pos_end);
            typeName = "STRING";
            defaultValue = """RETURN""";
            class values {
                class RETURN {
                    default = 1;
                    name = "RETURN";
                    value = "RETURN";
                };
                class CONTINUE {
                    default = 0;
                    name = "CONTINUE";
                    value = "CONTINUE";
                };
            };
        };

        class SubCategory_Altitudes {
            control = "SubCategory";
            title = "Altitudes";
            property = Q(SubCategory_Altitudes);
        };

        class alt_journey: Edit {
            control = "EditShort";
            displayName = "Journey";
            tooltip = "Travel Altitude";
            property = "alt_journey";
            typeName = "NUMBER";
            defaultValue = """100""";
        };
        class alt_final: Edit {
            control = "EditShort";
            displayName = "Final Approach";
            tooltip = "Altitude during final approach.\nShould be above 20m.";
            property = "alt_final";
            typeName = "NUMBER";
            defaultValue = """35""";
        };
        class alt_drop: Edit {
            control = "EditShort";
            displayName = "Drop Point";
            tooltip = "Target Altitude for the droppoint.\nShould be below 10 as this will deactivate objectAvoidance and hardforce ATL.";
            property = "alt_drop";
            typeName = "NUMBER";
            defaultValue = """2""";
        };
        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Registers a Destination to the CSC Framework. Syced connections have no effect.";
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};

