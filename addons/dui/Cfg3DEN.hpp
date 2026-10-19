// https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes

class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class ADDON {
                displayName = CSTRING(cat_title); // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes {
                    class GVAR(3den_teamLeader) {

                        //--- Mandatory properties
                        displayName = CSTRING(3den_teamLeader); // Name assigned to UI control class Title
                        tooltip = CSTRING(3den_teamLeader_desc); // Tooltip assigned to UI control class Title
                        property = QGVAR(3den_teamLeader); // Unique config property name saved in SQM
                        control = "Checkbox"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

                        // Expression called when applying the attribute in Eden and at the scenario start
                            // In MP scenario, the expression is called only on server.
                            // Delayed 1-5s after mission start, so fireteam colors (assignTeam) are already established.
                        expression = Q(if (!is3DEN && {_value}) then {[ARR_3({ if (SET(enabled) && {alive _this}) then { [ARR_2(_this,true)] call FUNC(TeamLeaderStepUp) } },_this,1 + random 4)] call CBA_fnc_waitAndExecute;});

                        defaultValue = "false";

                        //--- Optional properties
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        validate = "none"; // Validate the value before saving. If the value is not of given type e.g. "number", the default value will be set. Can be "none", "expression", "condition", "number" or "variable"
                        condition = "objectControllable"; // Condition for attribute to appear (see the table below)
                    };
                };
            };
        };
    };
};
