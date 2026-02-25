class CfgSounds
{
    sounds[] = {}; // OFP required it filled, now it can be empty or absent depending on the game's version

    class GVAR(place_1)
    {
        name = "Place 1";                        // display name
        sound[] = { QPATHTOF(data\place_1.ogg), 3, 2, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;        // Arma 3 - treat titles as Structured Text (1) or not (0)
    };
        class GVAR(place_2)
    {
        name = "Place 2";                        // display name
        sound[] = { QPATHTOF(data\place_2.ogg), 3, 2, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;        // Arma 3 - treat titles as Structured Text (1) or not (0)
    };
    class GVAR(place_3)
    {
        name = "Place 3";                        // display name
        sound[] = { QPATHTOF(data\place_3.ogg), 3, 2, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;        // Arma 3 - treat titles as Structured Text (1) or not (0)
    };
    class GVAR(place_4)
    {
        name = "Place 4";                        // display name
        sound[] = { QPATHTOF(data\place_4.ogg), 3, 2, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;        // Arma 3 - treat titles as Structured Text (1) or not (0)
    };
    class GVAR(broke)
    {
        name = "Broke";                        // display name
        sound[] = { QPATHTOF(data\pickaxe_broke.ogg), 3, 2, 100 };    // file, volume, pitch, maxDistance
        titles[] = { 0, "" };            // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;        // Arma 3 - treat titles as Structured Text (1) or not (0)
    };
};
