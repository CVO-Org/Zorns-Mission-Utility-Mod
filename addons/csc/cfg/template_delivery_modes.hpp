class template_delivery_modes {

    class template_spawn: base_delivery_mode {

        displayName = "Spawn";
        description_string = "Will be made available at the choosen destination."; // tripple Quotes for simply return the string

        code = QFUNC(base_spawn);

        maxCrates = 5;

        class parameters {};

        registerDefault = 1;
    };

    class template_airdrop_heli: base_delivery_mode {

        displayName = "Airdrop: Base Helicopter";
        description_code = QFUNC(base_airdrop_desc);

        code = QFUNC(base_airdrop);

        maxCrates = 2;

        cooldown = 1800;

        class parameters {
            airframe_side = "CIV";                  // String version: "WEST" "EAST" "GUER" "CIV"
            airframe_protected = "true";
            airframe_class = "C_Heli_Light_01_civil_F";


            mode = "EDGE_NEAR";
            pos_start[] = { 0, 0, 0 };
            pos_end = "RETURN";

            airdrop_alt = 100;
            airdrop_alt_forced = "true";
            airdrop_speedLimit = "LIMITED";

            airdrop_flyInHeightASL[] = { 35, 35, 35 };



            parachute_class = "B_Parachute_02_F";
            // CfgVehicles or CfgAmmo
            parachute_class_strobe = "ACE_IR_Strobe_Effect";
            parachute_class_chemlight = "Chemlight_yellow";
            parachute_class_smoke = "SmokeShellOrange";

            timeout = 900;
        };
    };

    class template_airdrop_plane: template_airdrop_heli {
        displayName = "Airdrop: Base Plane";

        maxCrates = 5;

        cooldown = 1800;

        class parameters {
            airframe_side = "CIV";                  // String version: "WEST" "EAST" "GUER" "CIV"
            airframe_protected = "true";
            airframe_class = "C_Plane_Civil_01_F";


            pos_start[] = { 8400,7400.00,0 };
            pos_end = "RETURN";

            airdrop_alt = 100;
            airdrop_alt_forced = "true";
            airdrop_speedLimit = "LIMITED";

            airdrop_flyInHeightASL[] = { 50, 50, 50 };


            parachute_class = "B_Parachute_02_F";

            // CfgVehicles or CfgAmmo
            parachute_class_strobe = "ACE_IR_Strobe_Effect";
            parachute_class_chemlight = "Chemlight_yellow";
            parachute_class_smoke = "SmokeShellOrange";
        };
    };

    class template_drone: base_delivery_mode {
        displayName = "Drone Delivery";

        description_string = "Will be delivered via a drone.";

        maxCrates = 1;

        code = QFUNC(base_drone);

        cooldown = 900;

        class parameters {

            drone_class = "B_UAV_06_F";
            drone_protected = "true";
            drone_side = "CIV";

            mode = "EDGE_NEAR";
            pos_start[] = { 0, 0, 0 };
            pos_end = "RETURN";

            alt_journey = 100;
            alt_final = 35; // should be above 20
            alt_drop = 2; // below 10 will disable objectAvoidance and hardforce the ATL
        };

        registerDefault = 1;
    };
};
