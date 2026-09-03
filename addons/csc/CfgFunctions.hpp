class CfgFunctions {
    class ADDON {
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

        };

        class api {
            file = PATH_TO_FUNC_SUB(api);

            class registerAccessPoint {};

            class registerCrate {};
            class registerDeliveryMode {};
            class registerDestination {};
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

            class base_fixedPos {};
            class base_relativeTo {};

            class base_gridCoordinates {};
            class base_mapClick {};
        };

        class framework {
            file = PATH_TO_FUNC_SUB(framework);

            class handle_destination {};
            class handle_delivery {};

            class validateFrameworkIDs {};
            class createCrate {};

            class request_client {};
            class request_server {};

            class setCooldown {};
            class getCooldown {};

        };

        class ui_grid {
            file = PATH_TO_FUNC_SUB(ui_grid);

            class grid_openDialog {};

            class ui_grid_onEditChanged {};
            class ui_grid_onLoad {};
            class ui_grid_onUnload {};
        };


       class ui_request {
           file = PATH_TO_FUNC_SUB(ui_request);

            class request_openDialog {};

            class ui_request_onLoad {};
            class ui_request_onUnload {};

            class ui_request_crates_init {};

            class ui_request_crates_update {};
            class ui_request_update_arrows {};
            class ui_request_update_canRequest {};
            class ui_request_update_crate_desc {};

            class ui_request_crates_onLBSelChanged {};
            class ui_request_delivery_onSelected {};
            class ui_request_destination_onSelected {};
       };

        class misc {
            file = PATH_TO_FUNC_SUB(misc);

            class parachuteCrate {};
            class getPosEdge {};
            class getVehicleInventory {};
        };

        class modules {
            file = PATH_TO_FUNC_SUB(modules);

            // class function { /* preInit = 1; */ };

            class module_registerAccessPoint {};

            class module_registerCrate_3den {};
            class module_registerCrate_init {};

            class module_registerDestination_fixed {};
            class module_registerDestination_relative {};

            class module_registerDeliveryMode_drone {};
            class module_registerDeliveryMode_airdrop {};
        };
    };
};
