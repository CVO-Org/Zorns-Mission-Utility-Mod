class mum_csc {

    class destinations {

        import base_destination from mum_csc;

        class test_tarp: base_destination {
            displayName = "Tarp.";   // Just as an example
            description = "On the Tarp";

            code = "mum_csc_fnc_base_relativeTo";

            scope = 2;

            class parameters {
                mode = "OFFSET"; // "BEHIND", "OFFSET"
                offset[] = { 0, 0, 1.5 };   // only used by OFFSET
                reference = "tarp"; // TARGET, PLAYER or missionNamespace variablename
            };
        };
    };

    class crates {
        import base_crate from mum_csc;

        class test_BasicAmmunation: base_crate {

            displayName = "General Ammunation Crate";
            scope = 2;

            box_class = "C_supplyCrate_F";
            box_empty = "true";

            items[] = {
                { "HandGrenade", 8 },
                { "SmokeShell", 8 },
                { "SmokeShellPurple", 2 },
                { "SmokeShellBlue", 2 },
                { "1Rnd_HE_Grenade_shell", 20 },
                { "30Rnd_545x39_Black_Mag_Yellow_F", 10},
                { "30Rnd_545x39_Black_Mag_Tracer_Yellow_F", 5},
                { "4Rnd_12Gauge_Pellets", 10},
                { "4Rnd_12Gauge_Slug", 10},
                { "ace_10rnd_762x54_tracer_mag", 5},
                { "17Rnd_9x21_Mag", 2},
                { "10Rnd_9x21_Mag", 2},
                { "greenmag_ammo_545x39_basic_60Rnd", 20},
                { "greenmag_ammo_762x54_basic_30Rnd", 10},
                { "greenmag_ammo_9x19_basic_60Rnd", 5},
                { "greenmag_ammo_9x21_basic_60Rnd", 5},
                { "greenmag_ammo_45ACP_basic_60Rnd", 10}
            };
        };
    };


};
