// https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes

class ctrlStatic;
class ctrlButton;
class ctrlControlsGroup;
class ctrlControlsGroupNoScrollbars;

class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class ADDON {
                displayName = CSTRING(cat_title); // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes {
                    class GVAR(3den_roles) {

                        //--- Mandatory properties
                        displayName = CSTRING(3den_roles); // Name assigned to UI control class Title
                        tooltip = CSTRING(3den_roles_desc); // Tooltip assigned to UI control class Title
                        property = QGVAR(3den_roles); // Unique config property name saved in SQM
                        control = "Edit"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

                        // Expression called when applying the attribute in Eden and at the scenario start
                            // The expression is called twice - first for data validation, and second for actual saving
                            // Entity is passed as _this, value is passed as _value
                            // %s is replaced by attribute config name
                            // In MP scenario, the expression is called only on server.
                        expression = "_this setVariable ['%s',_value, true];";

                            // Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
                            // Entity (unit, group, marker, comment etc.) is passed as _this
                            // Returned value is the default value
                            // Used when no value is returned, or when it is of other type than NUMBER, STRING or ARRAY
                            // Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
                        defaultValue = "''";

                        //--- Optional properties
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        validate = "none"; // Validate the value before saving. If the value is not of given type e.g. "number", the default value will be set. Can be "none", "expression", "condition", "number" or "variable"
                        condition = "objectBrain"; // Condition for attribute to appear (see the table below)
                        typeName = "STRING"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants. This is a scripted feature and has no engine support. See code in (configFile >> "Cfg3DEN" >> "Attributes" >> "Combo" >> "attributeSave")
                    };
                };
            };
        };
    };

    // Custom attribute control: dynamic list of checkboxes, one per default entry. Checked = enabled.
    // Filled by mum_arsenal_fnc_disableList_load, saved as stringified array of the disabled entries.
    class Attributes {
        class GVAR(disableList): ctrlControlsGroupNoScrollbars {
            idc = -1;
            x = 0;
            y = 0;
            w = QUOTE((ATTR_TITLE_W + ATTR_CONTENT_W) * ATTR_GRID_W);
            h = QUOTE(4 * ATTR_ROW_H * ATTR_GRID_H);

            attributeSave = QUOTE(_this call FUNC(disableList_save));

            class Controls {
                class Title: ctrlStatic {
                    idc = -1;
                    style = 1; // ST_RIGHT
                    x = 0;
                    y = 0;
                    w = QUOTE((ATTR_TITLE_W - 2) * ATTR_GRID_W);
                    h = QUOTE(ATTR_ROW_H * ATTR_GRID_H);
                };
                class EnableAll: ctrlButton {
                    idc = -1;
                    text = CSTRING(disableList_enableAll);
                    onButtonClick = QUOTE([ARR_2(_this select 0,true)] call FUNC(disableList_setAll));
                    x = QUOTE((ATTR_TITLE_W - 26) * ATTR_GRID_W);
                    y = QUOTE((ATTR_ROW_H + 1) * ATTR_GRID_H);
                    w = QUOTE(24 * ATTR_GRID_W);
                    h = QUOTE(ATTR_ROW_H * ATTR_GRID_H);
                };
                class DisableAll: EnableAll {
                    text = CSTRING(disableList_disableAll);
                    onButtonClick = QUOTE([ARR_2(_this select 0,false)] call FUNC(disableList_setAll));
                    y = QUOTE((2 * ATTR_ROW_H + 2) * ATTR_GRID_H);
                };
                class Background: ctrlStatic {
                    idc = -1;
                    x = QUOTE(ATTR_TITLE_W * ATTR_GRID_W);
                    y = 0;
                    w = QUOTE(ATTR_CONTENT_W * ATTR_GRID_W);
                    h = QUOTE(4 * ATTR_ROW_H * ATTR_GRID_H);
                    colorBackground[] = {0, 0, 0, 0.3};
                };
                class List: ctrlControlsGroup {
                    idc = IDC_DISABLELIST_LIST;
                    x = QUOTE(ATTR_TITLE_W * ATTR_GRID_W);
                    y = 0;
                    w = QUOTE(ATTR_CONTENT_W * ATTR_GRID_W);
                    h = QUOTE(4 * ATTR_ROW_H * ATTR_GRID_H);
                    class Controls {}; // Filled by mum_arsenal_fnc_disableList_load
                };
            };
        };

        class GVAR(disableList_kits): GVAR(disableList) {
            h = QUOTE(12 * ATTR_ROW_H * ATTR_GRID_H);
            attributeLoad = QUOTE([ARR_3(_this,_value,'kits')] call FUNC(disableList_load));
            class Controls: Controls {
                class Title: Title {
                    text = CSTRING(module_disableDefaults_kits);
                    tooltip = CSTRING(module_disableDefaults_kits_desc);
                };
                class Background: Background {
                    h = QUOTE(12 * ATTR_ROW_H * ATTR_GRID_H);
                };
                class List: List {
                    h = QUOTE(12 * ATTR_ROW_H * ATTR_GRID_H);
                };
            };
        };

        class GVAR(disableList_autoRoles): GVAR(disableList) {
            h = QUOTE(8 * ATTR_ROW_H * ATTR_GRID_H);
            attributeLoad = QUOTE([ARR_3(_this,_value,'autoRoles')] call FUNC(disableList_load));
            class Controls: Controls {
                class Title: Title {
                    text = CSTRING(module_disableDefaults_autoRoles);
                    tooltip = CSTRING(module_disableDefaults_autoRoles_desc);
                };
                class Background: Background {
                    h = QUOTE(8 * ATTR_ROW_H * ATTR_GRID_H);
                };
                class List: List {
                    h = QUOTE(8 * ATTR_ROW_H * ATTR_GRID_H);
                };
            };
        };

        class GVAR(disableList_autoTraits): GVAR(disableList) {
            h = QUOTE(4 * ATTR_ROW_H * ATTR_GRID_H);
            attributeLoad = QUOTE([ARR_3(_this,_value,'autoTraits')] call FUNC(disableList_load));
            class Controls: Controls {
                class Title: Title {
                    text = CSTRING(module_disableDefaults_autoTraits);
                    tooltip = CSTRING(module_disableDefaults_autoTraits_desc);
                };
                class Background: Background {
                    h = QUOTE(4 * ATTR_ROW_H * ATTR_GRID_H);
                };
                class List: List {
                    h = QUOTE(4 * ATTR_ROW_H * ATTR_GRID_H);
                };
            };
        };
    };
};
