class GVAR(autoRoles) {

    class base {
        condition = "";
        role = "";
        code = "";
    };

    // Medic
    class vanilla_medic: base {
        condition = "_this getUnitTrait 'medic';";
        role = "medic";
    };
    class ace_medic: vanilla_medic {
        condition = "[_this, 1] call ace_medical_treatment_fnc_isMedic;";
    };
    class ace_doctor: vanilla_medic {
        condition = "[_this, 2] call ace_medical_treatment_fnc_isMedic;";
        role = "doctor";
    };

    // Engineer
    class vanilla_engineer: base {
        condition = "_this getUnitTrait 'engineer';";
        role = "engineer";
    };
    class ace_engineer: vanilla_engineer {
        condition = "[_this, 1] call ace_repair_fnc_isEngineer;";
    };
    class ace_advEngineer: vanilla_engineer {
        condition = "[_this, 2] call ace_repair_fnc_isEngineer;";
        role = "AdvEngineer";
    };

    // Others
    class vanilla_explosiveSpecialist: base {
        condition = "_this getUnitTrait 'explosiveSpecialist';";
        role = "explosiveSpecialist";
    };
    class vanilla_UAVHacker: base {
        condition = "_this getUnitTrait 'UAVHacker';";
        role = "EWSpecialist";
    };

};

class GVAR(autoTraits) {

    class base {
        role = "";
        code = "";
    };

    class explosiveSpecialist: base {
        role = "explosiveSpecialist";
        code = "_this setUnitTrait ['explosiveSpecialist', true];";
    };

    class EWSpecialist: base {
        role = "EWSpecialist";
        code = "_this setUnitTrait ['UAVHacker', true];";
    };
};
