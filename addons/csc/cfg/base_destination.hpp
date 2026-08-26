class base_destination {

    displayName = "";
    description = "";

    code = "";



    class parameters {};
};

class base_destination_fixed: base_destination {

    displayName = "Base Fixed Position";
    description = "Predefined, fixed prosition.";

    code = QFUNC(base_fixedPos); // Function name or stringCode



    class parameters {
        position[] = { 0, 0, 0 };
    };
};

class base_destination_mapClick: base_destination {
    displayName = "Base Map-Click";
    description = "Define the desired destination via map-click on the map.";


    code = QFUNC(base_mapClick);

    class parameters {};
};

class base_destination_relative: base_destination {
    displayName = "Base Relative Position";   // Just as an example
    description = "Destination relative to an Object";


    code = QFUNC(base_relativeTo);

    class parameters {
        mode = "FRONT"; // "FRONT", "OFFSET"
        offset[] = { 0, 0, 0 };   // only used by OFFSET
        reference = "PLAYER";
    };
};
