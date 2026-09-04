class default_destinations {

    class default_fixed_debug: base_destination_fixed {
        displayName = "Debug Corner";
        description_string = "Predefined, fixed prosition - in this case, the debug corner.";

        code = QFUNC(base_fixedPos); // Function name or stringCode

        class parameters {
            position[] = { 0, 0, 0 };
        };
    };


    class default_map: base_destination_mapClick {
        registerDefault = 1;
    };

    class default_grid: base_destination_gridCoordinates {
        registerDefault = 1;
    };

    class default_player: base_destination_relative {
        displayName = "Player";   // Just as an example
        description_string = "In front of the player";

        class parameters {
            mode = "FRONT"; // "FRONT", "OFFSET"
            reference = "PLAYER";
        };

        registerDefault = 1;
    };
};
