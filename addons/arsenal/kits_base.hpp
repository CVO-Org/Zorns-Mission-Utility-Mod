// Base Kit - Accessible for Everyone
class baseKit_Medical: baseKit {
    class items {
        class ACE_packingBandage {};
        class ACE_fieldDressing {};

        class ACE_tourniquet {};
        class ACE_splint {};

        class ACE_painkillers {};
        
        class ACE_epinephrine {};

        class ACE_salineIV {};
        class ACE_salineIV_500 {};
        class ACE_salineIV_250 {};

        class ACE_personalAidKit {};

        class ACE_bodyBag {};
    };
};

class baseKit_Utility: baseKit {
    class items {
        class ace_marker_flags_red {};
        class ace_marker_flags_green {};

        class ACE_EntrenchingTool {};

        class ACE_SpraypaintGreen {};
        class ACE_SpraypaintRed {};

        class ACE_PlottingBoard {};

        class ACE_CableTie {};
        class acex_intelitems_notepad {};
    };
};

class baseKit_Orientation: baseKit {
    class items {
        class ACE_DAGR {};

        class ItemMap {};
        class ItemWatch {};

        class ItemCompass {};
        class ACE_MapTools {};

        class ACE_Flashlight_KSF1 {};
        class ACE_Chemlight_Shield {};

        class Chemlight_yellow {};
    };
};


// Base Kit - Setting Based
class ACE_Hearing_Enabled: baseKit {
    condition = "missionNamespace getVariable ['ace_hearing_enableCombatdeafness', true]"; // Find right Setting Variable
    class items {
        class ACE_EarPlugs {};
    };
};

class ACE_Overheating_Enabled: baseKit {
    condition = "missionNamespace getVariable ['ace_overheating_enabled', true]";
    class items {
        class ACE_WaterBottle {};
        class ACE_Canteen {};
    };
};

class ACE_FieldRations_Enabled: baseKit {
    condition = "missionNamespace getVariable ['ace_field_rations_enabled', true]";
    class items {
        class ACE_WaterBottle {};
        class ACE_Canteen {};
        class ACE_Humanitarian_Ration {};
    };
};


// Base Kit - Mod Dependent
class ImmersionCigs_Loaded: baseKit {
    addon_dependency = "cigs_core"; // Find right Addon to be checked
    class items {
        class cigs_lighter {};
        class cigs_matches {};
        class cigs_voron_cigpack {};
    };
};

class GreenMag_Loaded: baseKit {
    addon_dependency = "greenmag_main"; // Find right Addon to be checked
    class items {
        class greenmag_item_speedloader {};
    };
};
