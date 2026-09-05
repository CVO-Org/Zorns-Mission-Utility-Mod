class GVAR(module_registerCrate): Module_F {
    // Standard object definitions:
    scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
    scopeCurator = 1;                                               // Zeus visibility
    displayName = CSTRING(module_registerCrate);                    // Name displayed in the menu
    icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";     // Map icon. Delete this entry to use the default icon.
    category = QGVAR(factionClass);

    function = QFUNC(module_registerCrate_3den);                    // Name of function triggered once conditions are met
    functionPriority = 9;                                           // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
    isGlobal = 0;                                                   // 0 for server only execution, 1 for global execution, 2 for persistent global execution
    isTriggerActivated = 0;                                         // 1 for module waiting until all synced triggers are activated
    isDisposable = 1;                                               // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
    is3DEN = 1;                                                     // 1 to run init function in Eden Editor as well
    curatorCanAttach = 0;                                           // 1 to allow Zeus to attach the module to an entity

    // 3DEN Attributes Menu Options
    canSetArea = 0;                                                 // Allows for setting the area values in the Attributes menu in 3DEN
    canSetAreaShape = 0;                                            // Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
    canSetAreaHeight = 0;                                           // Allows for setting height or Z value in Attributes menu in 3DEN

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
            tooltip = "Must be a unique identifier. This will be used to reference this crate throughout the framework.\nWhen left empty, ID will be auto-generated.";
            property = "id";
            typeName = "STRING";
            defaultValue = "''"; // Because this is an expression, one must have a string within a string to return a string
            unique = 1; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
        };
        class displayName: Edit {
            displayName = "Display Name";
            tooltip = "Name of the Crate";
            property = "displayName";
            typeName = "STRING";
            defaultValue = "''"; // Because this is an expression, one must have a string within a string to return a string
        };

        class SubCategory_Crate {
            control = "SubCategory";
            title = "Crate";
            property = Q(SubCategory_Crate);
        };

        class box_class: Edit {
            displayName = "Crate Classname";
            tooltip = "When left empty, the classname of the linked crate is used.\nWhen defined, this overwrites the classname of the linked crate.";
            property = "box_class";
            typeName = "STRING";
            defaultValue = "'C_supplyCrate_F'"; // Because this is an expression, one must have a string within a string to return a string
        };

        class SubCategory_CrateContent {
            control = "SubCategory";
            title = "Crate Content";
            property = Q(SubCategory_CrateContent);
        };

        class items: Edit {
            control = "EditMulti5";
            displayName = "Items";
            tooltip = "Items added to the crate as amount classname pairs.\nInput is being internally converted. No need to use [].\nLinebreak can be used.\nExample:\n 5 ACE_fieldDressing\n50 ACE_elasticBandage";
            property = "items";
            typeName = "STRING";
            defaultValue = "''";
        };

        class box_empty: Checkbox {
            displayName = "Empty Crate";
            tooltip = "Removes the Crate of its default content.";
            property = "box_empty";
            defaultValue = "true"; // Because this is an expression, one must have a string within a string to return a string
        };
        class SubCategory_aceMedical {
            control = "SubCategory";
            title = "ACE Medical";
            property = Q(SubCategory_aceMedical);
        };
        class ace_medical_facility: Checkbox {
            displayName = "Medical Facility";
            tooltip = "Turns the crate into an ACE Medical Facility";
            property = "ace_medical_facility";
            defaultValue = "false"; // Because this is an expression, one must have a string within a string to return a string
        };
        class ace_medical_vehicle: Checkbox {
            displayName = "Medical Vehicle";
            tooltip = "Turns the crate into an ACE Medical Vehicle";
            property = "ace_medical_vehicle";
            defaultValue = "false";
        };


        class SubCategory_aceRepair {
            control = "SubCategory";
            title = "ACE Repair";
            property = Q(SubCategory_aceRepair);
        };

        class ace_repair_facility: Checkbox {
            displayName = "Repair Facility";
            tooltip = "Turns the crate into an ACE Repair Facility";
            property = "ace_repair_facility";
            defaultValue = "false"; // Because this is an expression, one must have a string within a string to return a string
        };
        class ace_repair_vehicle: Checkbox {
            displayName = "Repair Vehicle";
            tooltip = "Turns the crate into an ACE Repair Vehicle";
            property = "ace_repair_vehicle";
            defaultValue = "false";
        };

        class SubCategory_Rearm {
            control = "SubCategory";
            title = "ACE Rearm";
            property = Q(SubCategory_Rearm);
        };

        class ace_rearm_source: Checkbox {
            displayName = "ACE Rearm Source";
            tooltip = "Turns the crate into an ACE Rearm Source";
            property = "ace_rearm_source";
            defaultValue = "false"; // Because this is an expression, one must have a string within a string to return a string
        };
        class ace_rearm_source_value: Edit {
            control = "EditShort";
            displayName = "ACE Rearm Source Value";
            tooltip = "Defines the ACE Rearm Source Value";
            property = "ace_rearm_source_value";
            typeName = "NUMBER";
            defaultValue = "50"; // Because this is an expression, one must have a string within a string to return a string
        };

        class SubCategory_Refuel {
            control = "SubCategory";
            title = "ACE Refuel";
            property = Q(SubCategory_Refuel);
        };

        class ace_refuel_source: Checkbox {
            displayName = "ACE Refuel Source";
            tooltip = "Turns the crate into an ACE Refuel Source";
            property = "ace_refuel_source";
            defaultValue = "false"; // Because this is an expression, one must have a string within a string to return a string
        };
        class ace_refuel_source_value: Edit {
            control = "EditShort";
            displayName = "Fuel Value";
            tooltip = "Defines the ACE Refuel Source Value";
            property = "ace_refuel_source_value";
            typeName = "NUMBER";
            defaultValue = "50"; // Because this is an expression, one must have a string within a string to return a string
        };

        class ace_refuel_source_nozzlePos: Edit {
            control = "EditXYZ";
            displayName = "Fuel Nozzle Position";
            tooltip = "Defines the Position of the Fuel Nozzle";
            property = "ace_refuel_source_nozzlePos";
            defaultValue = "[0,0,0]"; // Because this is an expression, one must have a string within a string to return a string
        };


        // ACE DRAG
        class SubCategory_aceDragging {
            control = "SubCategory";
            title = "ACE Dragging";
            property = Q(SubCategory_aceDragging);
        };

        class ace_drag_canDrag: Checkbox {
            displayName = "Drag: Can be dragged";
            tooltip = "Defines if this crate can be ACE dragged";
            property = "ace_drag_canDrag";
            typeName = "BOOL";
            defaultValue = "true";
        };
        class ace_drag_relPOS: Edit {
            control = "EditXYZ";
            displayName = "Offset Position";
            tooltip = "Defines the position of the crate relative to the unit while dragging.";
            property = "ace_drag_relPOS";
            defaultValue = "[0,1.5,0]"; // Because this is an expression, one must have a string within a string to return a string
        };
        class ace_drag_dir: Edit {
            control = "EditShort";
            displayName = "Offset Direction";
            tooltip = "Direction the crate is pointing when being dragged.";
            property = "ace_drag_dir";
            typeName = "NUMBER";
            defaultValue = "0";
        };
        class ace_drag_ignoreWeight: Checkbox {
            displayName = "Drag: Ignore Weight";
            tooltip = "Ignores the weight of the crate and can always be dragged";
            property = "ace_drag_ignoreWeight";
            typeName = "BOOL";
            defaultValue = "true";
        };


        // ACE CARRY
        class SubCategory_aceCarrying {
            control = "SubCategory";
            title = "ACE Carrying";
            property = Q(SubCategory_aceCarrying);
        };
        class ace_carry_canCarry: Checkbox {
            displayName = "Carry: Can be carried";
            tooltip = "Defines if this crate can be ACE carried.";
            property = "ace_carry_canCarry";
            typeName = "BOOL";
            defaultValue = "true";
        };
        class ace_carry_relPOS: Edit {
            control = "EditXYZ";
            displayName = "Offset Position";
            tooltip = "Defines the position of the crate relative to the unit while carrying.";
            property = "ace_carry_relPOS";
            defaultValue = "[0,1,1]"; // Because this is an expression, one must have a string within a string to return a string
        };
        class ace_carry_dir: Edit {
            control = "EditShort";
            displayName = "Offset Direction";
            tooltip = "Direction the crate is pointing when being carried.";
            property = "ace_carry_dir";
            typeName = "NUMBER";
            defaultValue = "0";
        };
        class ace_carry_ignoreWeight: Checkbox {
            displayName = "Carry: Ignore Weight";
            tooltip = "Ignores the weight of the crate and can always be carried.";
            property = "ace_carry_ignoreWeight";
            typeName = "BOOL";
            defaultValue = "false";
        };

        class SubCategory_aceCargo {
            control = "SubCategory";
            title = "ACE Cargo";
            property = Q(SubCategory_aceCargo);
        };

        class ace_cargo_setSpace: Edit {
            control = "EditShort";
            displayName = "Cargo Space";
            tooltip = "Defines how much ACE Cargo space is available inside the crate.\nThe space required by added spare parts is added automatically.";
            property = "ace_cargo_setSpace";
            typeName = "NUMBER";
            defaultValue = "0";
        };

        class ace_cargo_setSize: Edit {
            control = "EditShort";
            displayName = "Crate Size";
            tooltip = "Defines the ACE Cargo size of the crate itself.\n-1 to leave leave it at default.";
            property = "ace_cargo_setSize";
            typeName = "NUMBER";
            defaultValue = -1;
        };

        class SubCategory_aceLogisticsSpareParts {
            control = "SubCategory";
            title = "ACE Logistics Spareparts";
            property = Q(SubCategory_aceLogisticsSpareParts);
        };
        class ace_cargo_add_spareWheels: Edit {
            control = "EditShort";
            displayName = "Spare Wheels";
            tooltip = "Adds ACE Spare Wheels to the crates ace cargo.";
            property = "ace_cargo_add_spareWheels";
            typeName = "NUMBER";
            defaultValue = "0";
        };
        class ace_cargo_add_tracks: Edit {
            control = "EditShort";
            displayName = "Spare Tracks";
            tooltip = "Adds ACE Spare Tracks to the crates ace cargo.";
            property = "ace_cargo_add_tracks";
            typeName = "NUMBER";
            defaultValue = "0";
        };
        class ace_cargo_add_jerrycans: Edit {
            control = "EditShort";
            displayName = "Jerry Cans";
            tooltip = "Adds ACE Jerry Cans to the crates ace cargo.";
            property = "ace_cargo_add_jerrycans";
            typeName = "NUMBER";
            defaultValue = "0";
        };

        class ModuleDescription: ModuleDescription {}; // Module description should be shown last
    };


    // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
    class ModuleDescription: ModuleDescription {
        description = "Registers the linked crate to the CSC Framework. Deletes the linked crate. Will only take one/the first linked crate into account and ignores the rest.";
        sync[] = {};                // Array of synced entities (can contain base classes)
    };
};
