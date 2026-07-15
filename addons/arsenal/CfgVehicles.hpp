class CfgVehicles {

    class ThingX;

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
                displayName = "Open Arsenal";
                statement = Q([] call FUNC(open));
                condition = "true";

                distance = 2;
                position = "[0,0,0]";

                icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\rifle_ca.paa";
            };
        };
    };
};
