class GVAR(destinations)
{
    #include "mum_csc_destinations_base.hpp"

    class base_fixed_debug: baseDestination {

        displayName = "Debug Corner";
        description = "Predefined, fixed prosition - in this case, the debug corner.";

        code = QFUNC(base_fixedPos); // Function name or stringCode

        scope = 0;

        class parameters {
            position[] = { 0, 0, 0 };
        };
    };

    class base_mapClick: baseDestination {
        displayName = "via Mapclick";
        description = "Manually define the desired destination via map-click.";
        scope = 1;

        code = QFUNC(base_mapClick);

        class parameters {};
    };

    class base_infrontPlayer: baseDestination {
        displayName = "Infront of Player";   // Just as an example
        description = "In front of the player";
        scope = 1;

        code = QFUNC(base_relativeTo);

        class parameters {
            mode = "FRONT"; // "FRONT", "OFFSET"
            offset[] = { 0, 0, 0 };   // only used by OFFSET
            reference = "PLAYER";
        };
    };
};
