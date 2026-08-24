#include "script_component.hpp"

class CfgPatches {
    class ADDON {

        // Meta information for editor
        name = ADDON_NAME;
        author = ECSTRING(main,author);
        authors[] = {"OverlordZorn [CVO]"};

        url = ECSTRING(main,url);

        VERSION_CONFIG;

        // Addon Specific Information
        // Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
        requiredVersion = REQUIRED_VERSION;

        // Required addons, used for setting load order.
        // When any of the addons is missing, pop-up warning will appear when launching the game.
        // Dependency on cba_help - hope is that the intel record will be made after cba's diary entries.
        requiredAddons[] = {"mum_main", "cba_common", "cba_help"};

        // List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups)
        units[] = {};

        // List of weapons (CfgWeapons classes) contained in the addon.
        weapons[] = {};
    };
};


#include "CfgFunctions.hpp"
#include "XEH/CfgXEH.hpp"

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
