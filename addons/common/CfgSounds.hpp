class CfgSounds
{
    sounds[] = {}; // OFP required it filled, now it can be empty or absent depending on the game's version

    class mum_healsound
    {
        name = "mum_healsound";                                                            // display name
        sound[] = { PATH_TO_ADDON_2(data,medical_healsound.ogg), 1, 1, 100 };        // file, volume, pitch, maxDistance
        titles[] = { 0, "[Healsound]" };                                                // subtitles

        forceTitles = 0;            // Arma 3 - display titles even if global show titles option is off (1) or not (0)
        titlesStructured = 0;        // Arma 3 - treat titles as Structured Text (1) or not (0)
    };
};
