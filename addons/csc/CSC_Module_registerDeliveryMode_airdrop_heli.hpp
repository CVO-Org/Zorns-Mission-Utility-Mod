class GVAR(module_registerDeliveryMode_airDropHeli): Module_F {
    // Standard object definitions:
    scope = 2;                                                                  // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                                           // Zeus visibility
    displayName = CSTRING(module_registerDeliveryMode_airDropHeli);                    // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";                 // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_registerDeliveryMode_airDrop);                    // Name of function triggered once conditions are met
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
            defaultValue = "''";                        // Because this is an expression, one must have a string within a string to return a string
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
            defaultValue = 2;                           // Because this is an expression, one must have a string within a string to return a string
        };
        class cooldown: Edit {
            control = "EditShort";
            displayName = "Cooldown";
            tooltip = "Cooldown in seconds for this delivery method to be availabe again.\n0 will disable cooldown.";
            property = "cooldown";
            typeName = "NUMBER";
            defaultValue = 1800;                        // Because this is an expression, one must have a string within a string to return a string
        };

        class SubCategory_Airframe {
            control = "SubCategory";
            title = "Airframe";
            property = Q(SubCategory_Airframe);
        };

        class airframe_class: Edit {
            displayName = "Classname";
            tooltip = "Classname of the aircraft.";
            property = "airframe_class";
            typeName = "STRING";
            defaultValue = """C_Heli_Light_01_civil_F""";
        };
        class airframe_protected: Checkbox {
            displayName = "Protected";
            tooltip = "Makes the aircraft invincible.";
            property = "airframe_protected";
            typeName = "BOOL";
            defaultValue = "true";
        };
        class airframe_side: Combo {
            displayName = "Side";
            tooltip = "The side the aircraft should be assigned to.";
            property = "airframe_side";
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
            tooltip = "Where should the aircraft be spawned?\nStarting Position: When left empty, Module's Position will be taken.\nEdge: Nearest/Furthest Edge of the Map relative to the Start/Module Position.";
            property = "mode";
            typeName = "STRING";
            defaultValue = """EDGE_NEAR""";
            class values {
                class EDGE_NEAR {
                    default = 1;
                    name = "Edge - Nearest";
                    value = "EDGE_NEAR";
                };
                class EDGE_FAR {
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

        class airdrop_alt: Edit {
            control = "EditShort";
            displayName = "Airdrop Altitude";
            tooltip = "Flight altitude for the airdrop.";
            property = "airdrop_alt";
            typeName = "NUMBER";
            defaultValue = 75;
        };
        class airdrop_alt_forced: Checkbox {
            displayName = "Forced Altitude";
            tooltip = "Forces the aircraft to hold the altitude above.";
            property = "airdrop_alt_forced";
            typeName = "BOOL";
            defaultValue = "true";
        };
        class airdrop_speedLimit: Combo {
            displayName = "Speed Limit";
            tooltip = "Waypoint speed for the target leg.";
            property = "airdrop_speedLimit";
            typeName = "STRING";
            defaultValue = """NORMAL""";
            class values {
                class FULL {
                    default = 0;
                    name = "FULL";
                    value = "FULL";
                };
                class NORMAL {
                    default = 1;
                    name = "NORMAL";
                    value = "NORMAL";
                };
                class LIMITED {
                    default = 0;
                    name = "LIMITED";
                    value = "LIMITED";
                };
            };
        };
        class airdrop_flyInHeightASL: Edit {
            control = "EditXYZ";
            displayName = "Fly In Height ASL";
            tooltip = "ASL altitude values used during the approach.\nx - Standard Altitude (default behaviour)\ny - Combat Altitude (combat behaviour)\nz - Stealth Altitude (stealth behaviour)";
            property = "airdrop_flyInHeightASL";
            defaultValue = "[35,35,35]";
        };

        class SubCategory_Parachute {
            control = "SubCategory";
            title = "Parachute";
            property = Q(SubCategory_Parachute);
        };

        class parachute_class: Edit {
            displayName = "Parachute Class";
            tooltip = "Classname of the parachute used for the crate.";
            property = "parachute_class";
            typeName = "STRING";
            defaultValue = """B_Parachute_02_F""";
        };
        class parachute_class_strobe: Edit {
            displayName = "Strobe Class";
            tooltip = "Optional strobe effect classname.";
            property = "parachute_class_strobe";
            typeName = "STRING";
            defaultValue = """ACE_IR_Strobe_Effect""";
        };
        class parachute_class_chemlight: Edit {
            displayName = "Chemlight Class";
            tooltip = "Optional chemlight classname.";
            property = "parachute_class_chemlight";
            typeName = "STRING";
            defaultValue = """Chemlight_yellow""";
        };
        class parachute_class_smoke: Edit {
            displayName = "Smoke Class";
            tooltip = "Optional smoke classname.";
            property = "parachute_class_smoke";
            typeName = "STRING";
            defaultValue = """SmokeShellOrange""";
        };

        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Registers a Delivery Mode (Airdrop - Helicopter) to the CSC Framework. Synced connections have no effect.";
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};
