// ACE MEDICAL
class BaseRoleKit_Medic: baseKit {
    role = "Medic";
    class items {
        class ACE_quikclot {};
        class ACE_elasticBandage {};
        
        class ACE_adenosine {};
        class ACE_morphine {};

        class ACE_plasmaIV {};
        class ACE_plasmaIV_500 {};
        class ACE_plasmaIV_250 {};

        class ACE_bloodIV {};
        class ACE_bloodIV_500 {};
        class ACE_bloodIV_250 {};

        class ACE_surgicalKit {};
    };
};
 
class BaseRoleKit_Medic_suture: baseKit {
    role = "medic";
    condition = "missionNamespace getVariable ['ace_medical_treatment_consumeSurgicalKit',0] isEqualTo 2";
    class items {
        class ACE_suture {};
    };
};

class BaseRoleKit_Doctor: baseKit {
    role = "Doctor";
    class items {
    };
};


// ACE ENGINEER
class BaseRoleKit_Engineer: baseKit {
    role = "Engineer";
    class items {
        class ACE_wirecutter {};
        class ACE_ToolKit {};
    };
};

class BaseRoleKit_AdvEngineer: baseKit {
    role = "AdvEngineer";
    class items {
        class ACE_Fortify {};
    };
};


// EXPLOSIVE SPECIALIST
class BaseRoleKit_ExplosiveSpecialist: baseKit {
    role = "ExplosiveSpecialist";
    class items {
        class ACE_VMH3 {};
        class ACE_VMM3 {};
        class ACE_DefusalKit {};

        class DemoCharge_Remote_Mag {};
        class SatchelCharge_Remote_Mag {};
    };
};
class BaseRoleKit_ExplosiveSpecialist_IEDD: baseKit {
    addon_dependency = "iedd_main";
    role = "ExplosiveSpecialist";
    class items {
        class iedd_item_notebook {};
    };
};

class BaseRoleKit_ExplosiveSpecialist_convertFuses: baseKit {
    role = "ExplosiveSpecialist";
    condition = "missionNamespace getvariable ['ace_grenades_convertExplosives', false]";
    class items {
        class ACE_DemoCharge_Remote_Mag_Throwable {};
        class ACE_SatchelCharge_Remote_Mag_Throwable {};
    };
};


// Machinegunner
class BaseRoleKit_Machinegunner: baseKit {
    role = "Machinegunner";
    class items {
        class ACE_SpareBarrel {};
    };
};


// Marksman
class BaseRoleKit_Marksman: baseKit {
    role = "Marksman";
    class items {
        class ACE_Tripod {};
        class ACE_RangeCard {};
        class Rangefinder {};
    };
};

// EW Specialist
class BaseRoleKit_EWSpecialist: baseKit {
    role = "EWSpecialist";
    class items {
        //spectrum device
        class hgun_esd_01_F {};
        class acc_esd_01_flashlight {};
        class muzzle_antenna_01_f {};
        class muzzle_antenna_03_f {};
        class muzzle_antenna_02_f {};
    };
};


// RTO
class BaseRoleKit_RTO: baseKit {
    role = "RTO";
    class items {
        class ACRE_PRC77 {};
        class ACRE_VHF30108SPIKE {}; 
        class ACRE_VHF30108 {}; 
        class ACRE_VHF30108MAST {};
    };
};

// UAV
class BaseRoleKit_UAV: baseKit {
    role = "UAV";
    class items {
        class ACE_UAVBattery {};
    };
    code = "switch (str side ACE_player) do {
        case 'WEST': { 'B_UavTerminal' };
        case 'EAST': { 'O_UavTerminal' };
        case 'GEUR': { 'I_UavTerminal' };
        case 'CIV':  { 'C_UavTerminal' };
        default { '' };
    };";
};
