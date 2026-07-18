class CfgFunctions
{
    class ADDON            // Tag
    {
        class internal    // Category
        {
            file = PATH_TO_FUNC_SUB(internal);
            class postInit { postInit = 1; };
            class preInit { preInit = 1; };

            class initBox {};

            class open {};
            class update {};
            class addItemsFromKit_recursive {};
        };

        class config
        {
            file = PATH_TO_FUNC_SUB(config);
            class getKitFromCfg {};
            class handleConfigKits {};
            class handleConfigAutoRoles {};
            class mission_init { postInit = 1; };
        };

        class kit
        {
            file = PATH_TO_FUNC_SUB(kit);
            class addKit {};
            class createKit {};
        };


        class roles
        {
            file = PATH_TO_FUNC_SUB(roles);
            class addUnitRoles {};
            class setUnitRoles {};
            class getUnitRoles {};

            class rolesByTrait {};
        };
    };
};
