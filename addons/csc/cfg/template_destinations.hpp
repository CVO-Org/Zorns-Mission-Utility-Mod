class template_destinations {

    class template_fixed_debug: base_destination_fixed {
        displayName = "Debug Corner";
        description = "Predefined, fixed prosition - in this case, the debug corner.";

        code = QFUNC(base_fixedPos); // Function name or stringCode

        class parameters {
            position[] = { 0, 0, 0 };
        };
    };

    class template_mapClick: base_destination_mapClick {
        displayName = "via Mapclick";
        description = "Manually define the desired destination via map-click.";

        code = QFUNC(base_mapClick);

        class parameters {};

        registerDefault = 1;
    };

    class template_infrontPlayer: base_destination_relative {
        displayName = "Infront of Player";   // Just as an example
        description = "In front of the player";

        code = QFUNC(base_relativeTo);

        class parameters {
            mode = "FRONT"; // "FRONT", "OFFSET"
            offset[] = { 0, 0, 0 };   // only used by OFFSET
            reference = "PLAYER";
        };

        registerDefault = 1;
    };
};
