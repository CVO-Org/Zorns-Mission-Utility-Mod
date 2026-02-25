// ["mum_ogg_sounds_metal23", "mum_ogg_sounds_metal400", "mum_ogg_sounds_metal77", "mum_ogg_sounds_metal899",
//  "mum_ogg_sounds_radio68", "mum_ogg_sounds_radio81", "mum_ogg_sounds_radio82",
//  "mum_ogg_sounds_swamp190", "mum_ogg_sounds_swamp239", "mum_ogg_sounds_swamp349",
//  "mum_ogg_sounds_swamp714", "mum_ogg_sounds_swamp934",
//  "mum_ogg_sounds_wispers101", "mum_ogg_sounds_wispers192", "mum_ogg_sounds_wispers282", "mum_ogg_sounds_wispers91"]


class CfgSounds
{
    sounds[] = {}; // OFP required it filled, now it can be empty or absent depending on the game's version

    class GVAR(drone400)
    {
        name = "drone400";                        // display name
        sound[] = { QPATHTOF(data\drone400.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 41;
    };
    class GVAR(drone934)
    {
        name = "drone934";                        // display name
        sound[] = { QPATHTOF(data\drone934.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 94;
    };

    class GVAR(metal23)
    {
        name = "metal23";                        // display name
        sound[] = { QPATHTOF(data\metal23.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 3;
    };

    class GVAR(metal77)
    {
        name = "metal77";                        // display name
        sound[] = { QPATHTOF(data\metal77.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 8;
    };

    class GVAR(metal899)
    {
        name = "metal899";                        // display name
        sound[] = { QPATHTOF(data\metal899.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 90;
    };

    class GVAR(radio68)
    {
        name = "radio68";                        // display name
        sound[] = { QPATHTOF(data\radio68.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 7;
    };

    class GVAR(radio81)
    {
        name = "radio81";                        // display name
        sound[] = { QPATHTOF(data\radio81.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 9;
    };

    class GVAR(radio82)
    {
        name = "radio82";                        // display name
        sound[] = { QPATHTOF(data\radio82.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 9;
    };

    class GVAR(swamp190)
    {
        name = "swamp190";                        // display name
        sound[] = { QPATHTOF(data\swamp190.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 19;
    };

    class GVAR(swamp239)
    {
        name = "swamp239";                        // display name
        sound[] = { QPATHTOF(data\swamp239.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 24;
    };

    class GVAR(swamp349)
    {
        name = "swamp349";                        // display name
        sound[] = { QPATHTOF(data\swamp349.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 35;
    };

    class GVAR(swamp714)
    {
        name = "swamp714";                        // display name
        sound[] = { QPATHTOF(data\swamp714.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 72;
    };


    class GVAR(wispers101)
    {
        name = "wispers101";                        // display name
        sound[] = { QPATHTOF(data\wispers101.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 11;
    };

    class GVAR(wispers192)
    {
        name = "wispers192";                        // display name
        sound[] = { QPATHTOF(data\wispers192.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 20;
    };

    class GVAR(wispers282)
    {
        name = "wispers282";                        // display name
        sound[] = { QPATHTOF(data\wispers282.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 29;
    };

    class GVAR(wispers91)
    {
        name = "wispers91";                        // display name
        sound[] = { QPATHTOF(data\wispers91.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 10;
    };

    class GVAR(numberstations1060)
    {
        name = "numberstations1060";                        // display name
        sound[] = { QPATHTOF(data\numberstations1060.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 107;
    };

    class GVAR(numberstations116)
    {
        name = "numberstations116";                        // display name
        sound[] = { QPATHTOF(data\numberstations116.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 12;
    };

    class GVAR(numberstations125)
    {
        name = "numberstations125";                        // display name
        sound[] = { QPATHTOF(data\numberstations125.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 13;
    };

    class GVAR(numberstations244)
    {
        name = "numberstations244";                        // display name
        sound[] = { QPATHTOF(data\numberstations244.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 25;
    };

    class GVAR(numberstations410)
    {
        name = "numberstations410";                        // display name
        sound[] = { QPATHTOF(data\numberstations410.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 41;
    };

    class GVAR(numberstations85)
    {
        name = "numberstations85";                        // display name
        sound[] = { QPATHTOF(data\numberstations85.ogg), 1, 1, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;       // Arma 3 - treat titles as Structured Text (1) or not (0)

        duration = 9;
    };

};
