// This file serves as an example for a missionConfig based setup of CSC for a mission.
// Insert the following into your description.ext
// #include "CfgCustomSupplyCrates.hpp"
// "true" and "false" will be converted into booleans

// "DefaultEntry" is a special case and will define the "Defaults" for all the implemented

class GVAR(crates) {

    #include "mum_csc_crates_base.hpp"

    class base_medicalCrate: baseCrate {

        displayName = "Medical Supply Crate";

        scope = 2;

        box_class = "ACE_medicalSupplyCrate_advanced";
        box_empty = "true";

        ace_medical_facility = "true";

        items[] = {
            // { "ACE_suture", 100 },
            { "ACE_surgicalKit", 1 },
            { "ACE_painkillers", 5 },
            { "ACE_bodyBag", 25 },
            { "ACE_personalAidKit", 15 },
            { "ACE_salineIV", 10 },
            { "ACE_salineIV_500", 20 },
            { "ACE_fieldDressing",  40 },
            { "ACE_packingBandage", 40 },
            { "ACE_elasticBandage", 50 },
            { "ACE_Morphine", 5 },
            { "ACE_Epinephrine", 10 }
        };
    };
};
