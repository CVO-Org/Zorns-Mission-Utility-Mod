class CfgFunctions
{
    class ADDON            // Tag
    {
        class COMPONENT           // Category
        {
            file = PATH_TO_FUNC;

            class preInit { preInit = 1; };
        };

        class autoInit {
            file = PATH_TO_FUNC_SUB(autoInit);
            
            class antiFlubber { postInit = 1; }; // Auto Inits the Anti Flubber Script - descrition.ext: "enableAntiFlubber = 1;"
        };
        
        class code {
            file = PATH_TO_FUNC_SUB(code);

            class getSizeOf {};
            class getBoundingBoxRealOf {};

            class pointAt {};
            
            class getMedianPosASL {};
            class getMedianPosFromUnits {};

            class allUnits_code {};
        };

        class cutscene {
            file = PATH_TO_FUNC_SUB(cutscene);
            
            class cutscene {};
            class processTimelineEntry {};
        };

        class debug {
            file = PATH_TO_FUNC_SUB(debug);

            class markAllLocations {};
            class stringPadding {};
            class ui_lnb_output {};
        };

        class helicopters {
            file = PATH_TO_FUNC_SUB(helicopters);

            class airlift_cargo {};
            class slingload_cargoOwner {};
            
            class speedLimiter {};

            class landOnRails {};
            
        };

        class layers {
            file = PATH_TO_FUNC_SUB(layers);

            class layerObjects {};
            class toggleLayerAI {};
        };

        class messages {
            file = PATH_TO_FUNC_SUB(messages);
            class preInit_messages { preInit = 1; };

            class getSenderUnit {};

            class chatMessage {};
            class chatMessage_remote {};

            class zeusMessage {};
        };

        class missionmaker {
            file = PATH_TO_FUNC_SUB(missionmaker);

            class executeUnit {};
            class fullHeal {};
            class holdaction_tp {};
            class makeCosmetic {};

            class subtitles {};
            class makeRemovable {};

            class removeNavitems {};
            class skipTimeTo {};

            class setupReadyAction {};
        };

        class vehicles {
            file = PATH_TO_FUNC_SUB(vehicles);
            
            class moveUnitsIntoVehicles {};
            class secureVehicle {};

            class orderlyDismount {};
        };
    };
};
