class CfgFunctions
{
    class ADDON            // Tag
    {
        class init {
            file = PATH_TO_FUNC_SUB(init);
            
            class cbaEvents { preInit = 1; };
            class missionInit { preInit = 1; };
        };

        class accessPoint {
            file = PATH_TO_FUNC_SUB(accessPoint);
            
            class createAction {};

            class createAccessPoint {};
            class createAccessPointZeus { postInit = 1; };

            class createAccessPointPlayer {};
        };
        

        class delivery {
            file = PATH_TO_FUNC_SUB(delivery);
            
            class base_spawn {};
            class base_drone {};
            class base_airdrop {};
            class base_airdrop_desc {};
        };
        
        class destination {
            file = PATH_TO_FUNC_SUB(destination);
            
            class base_mapClick {};
            class base_fixedPos {};
            class base_relativeTo {};
        };

        class framework {
            file = PATH_TO_FUNC_SUB(framework);

            class handle_destination {};
            class handle_delivery {};
            
            class getDefaultPresets {};
            class createCrate {};

            class request_client {};
            class request_server {};

        };

        
       class ui {
           file = PATH_TO_FUNC_SUB(ui);
           
            class openDialog {};
           
            class ui_onLoad {};
            class ui_onUnload {};
            
            class ui_crates_init {};

            class ui_crates_update {};
            class ui_update_arrows {};
            class ui_update_canRequest {};
            class ui_update_crate_desc {};

            class ui_crates_onLBSelChanged {};
            class ui_delivery_onSelected {};
            class ui_destination_onSelected {};
       };

        class misc {
            file = PATH_TO_FUNC_SUB(misc);
            
            class parachuteCrate {};
        };
        
    };
};
