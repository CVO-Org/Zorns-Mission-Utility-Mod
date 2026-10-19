class CfgVehicles {

    class ThingX;

    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class ModuleDescription;    // Module description
        };

        // Description base classes (for more information see below):
        class ModuleDescription {};
    };

    class GVAR(accessPoint): ThingX {
        author = ECSTRING(main,author);

        displayName = CSTRING(accessPoint);
        editorPreview = "";

        editorCategory = QPVAR(edCat);
        editorSubcategory = QGVAR(edSubcat);

        scope = 2;
        scopeCurator = 2;

        model = "\A3\Weapons_f\empty.p3d";
        destrType = "DestructNo";

        icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa";

        class ACE_Actions {
            class GVAR(accessPoint) {
                displayName = CSTRING(action_open);
                statement = Q([] call FUNC(open));
                condition = "true";

                distance = 2;
                position = "[0,0,0]";

                icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa";
            };
        };
    };

    class GVAR(module_disableDefaults): Module_F {
        // Standard object definitions:
        scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 0;                                               // Zeus visibility - 3DEN only, the checkbox lists are 3DEN controls
        displayName = CSTRING(module_disableDefaults);                  // Name displayed in the menu
        icon = "zrn\mum\addons\main\data\Raven_Voron_white_64.paa";    // Map icon. Delete this entry to use the default icon.
        category = QGVAR(factionClass);

        function = QFUNC(module_disableDefaults);   // Name of function triggered once conditions are met
        functionPriority = 1;                       // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        isGlobal = 0;                               // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isTriggerActivated = 0;                     // 1 for module waiting until all synced triggers are activated
        isDisposable = 1;                           // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
        is3DEN = 0;                                 // 1 to run init function in Eden Editor as well
        curatorCanAttach = 0;                       // 1 to allow Zeus to attach the module to an entity

        // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
        class Attributes: AttributesBase {
            // Value: stringified array of the disabled entries
            class GVAR(disabledKits): Default {
                property = QGVAR(disabledKits);
                control = QGVAR(disableList_kits);
                defaultValue = "'[]'";
            };
            class GVAR(disabledAutoRoles): Default {
                property = QGVAR(disabledAutoRoles);
                control = QGVAR(disableList_autoRoles);
                defaultValue = "'[]'";
            };
            class GVAR(disabledAutoTraits): Default {
                property = QGVAR(disabledAutoTraits);
                control = QGVAR(disableList_autoTraits);
                defaultValue = "'[]'";
            };

            class ModuleDescription: ModuleDescription {}; // Module description should be shown last
        };

        // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
        class ModuleDescription: ModuleDescription {
            description = CSTRING(module_disableDefaults_desc);    // Short description, will be formatted as structured text
            sync[] = {};                // Array of synced entities (can contain base classes)
        };
    };
};
