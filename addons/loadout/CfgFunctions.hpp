class CfgFunctions {
    class ADDON {
        class Arsenal_Tabs {
            file = PATH_TO_FUNC_SUB(arsenal_tabs);
            class greenmag { postInit = 1; };
            class acre { postInit = 1; };
        };

        class common {
            file = PATH_TO_FUNC_SUB(common);
            class postInit { postInit = 1; };

            class saveStartingLoadout { postInit = 1; };

            class getAllItems {};
        };
    };
};
