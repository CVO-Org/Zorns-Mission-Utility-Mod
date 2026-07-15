class CfgFunctions
{
    class ADDON
    {
        class internal {
            file = PATH_TO_FUNC_SUB(internal);
            
            // class function { /* preInit = 1; */ };
            class network {};

            class addAction {};
            class addAction_children {};
            class getName {};

            class teleport {};
        };

        class public {
            file = PATH_TO_FUNC_SUB(public);
            
            class departure {};
            class destination {};
            class destination_remove {};
        };

        class ui {
            file = PATH_TO_FUNC_SUB(ui);
            
            class openDialog {};

            class ui_update {};
            class ui_update_map {};

            class ui_onLoad {};
            class ui_onUnload {};
            class ui_onLBSelChanged {};


        };
    };
};
