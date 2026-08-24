class CfgFunctions {
    class ADDON {
        class action {
            file = PATH_TO_FUNC_SUB(action);

            class action_statement {};
            class addIntelAction {};
            class removeintelAction {};
        };

        class api {
            file = PATH_TO_FUNC_SUB(api);

            class createIntel {};
        };

        class intel {
            file = PATH_TO_FUNC_SUB(intel);

            class handleJIP { postInit = 1; };
            class init { preInit = 1; };

            class intelFound {};
            class publishIntel {};

            class hasBeenFoundByUnit {};

            class createIntelSubject {};
            class writeIntelDiary {};
        };

        class summary {
            file = PATH_TO_FUNC_SUB(summary);

            class getGroups {};
            class updateSummary {};
        };
        class modules {
            file = PATH_TO_FUNC_SUB(modules);

            class module_intelItem_basic {};
            class module_intelItem_email {};
            class module_intelItem_handwrittenNote {};
            class module_intelItem_messages {};
        };

        class dev {
            file = PATH_TO_FUNC_SUB(dev);

            class createFontPreview {};
        };

    };
};
