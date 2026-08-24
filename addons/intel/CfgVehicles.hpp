class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            // class Default;
            class Edit;                 // Default edit box (i.e. text input field)
            class Combo;                // Default combo box (i.e. drop-down menu)
            class Checkbox;             // Default checkbox (returned value is Boolean)
            // class CheckboxNumber;       // Default checkbox (returned value is Number)
            class ModuleDescription;    // Module description
            // class Units;                // Selection of units on which the module is applied
        };

        // Description base classes (for more information see below):
        class ModuleDescription {
            // class AnyBrain;
        };
    };

    #include "IntelModule_basic.hpp"
    #include "IntelModule_eMail.hpp"
    #include "IntelModule_handwrittenNote.hpp"
    #include "IntelModule_messages.hpp"
    #include "IntelModule_photo.hpp"
};
