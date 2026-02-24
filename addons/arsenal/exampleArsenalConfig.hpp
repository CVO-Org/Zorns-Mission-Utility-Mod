/*
*   MUM Arsenal Define File
*   Example File:  https://github.com/CVO-Org/Zorns-Mission-Utility-Mod/blob/main/.hemtt/missions/test.VR/exampleArsenalConfig.hpp
*   Documentation: https://github.com/CVO-Org/Zorns-Mission-Utility-Mod/blob/main/addons/arsenal/readme.md
*/

class mum_arsenal_kits
{
    // Defines the Objects which shall be used as an MUM Arsenal
    editor_layer_name = "mum_arsenal";                      // All objects inside this editor layer will be turned into an arsenal
    object_variable_names[] = {"arsenal_1", "arsenal_2"};   // all objects with these variableNames will be turned into an arsenal

    // Imports Base from configFile
    import baseKit from mum_arsenal_kits;

    // Wearables / Gear
    class Base_Uniforms: baseKit {
        class items {
            class U_I_E_ParadeUniform_01_LDF_F {};
            class U_I_E_ParadeUniform_01_LDF_decorated_F {};
            class U_I_E_Uniform_01_coveralls_F {};
            class U_I_E_Uniform_01_F {};
            class U_I_E_Uniform_01_tanktop_F {};
            class U_I_E_Uniform_01_sweater_F {};
            class U_I_E_Uniform_01_shortsleeve_F {};
            class U_I_E_Uniform_01_officer_F {};
            class U_I_E_CBRN_Suit_01_EAF_F {};
        };
    };

    class Base_Vests: baseKit {
        class items {
            class V_CarrierRigKBT_01_heavy_EAF_F {};
            class V_CarrierRigKBT_01_heavy_Olive_F {};
            class V_CarrierRigKBT_01_light_EAF_F {};
            class V_CarrierRigKBT_01_light_Olive_F {};
            class V_CarrierRigKBT_01_EAF_F {};
            class V_CarrierRigKBT_01_Olive_F {};
        };
    };

    class Base_Backpacks: baseKit {
        class items {
 			class ace_gunbag_Tan {};

            class B_RadioBag_01_eaf_F {};
            class B_Carryall_eaf_F {};
            class B_AssaultPack_eaf_F {};
        };
    };

    class Base_Headgear: baseKit {
        class items {

            class H_HelmetHBK_F {};
            class H_HelmetHBK_ear_F {};
            class H_HelmetHBK_chops_F {};
            class H_HelmetHBK_headset_F {};

        };
    };

    class Base_Facewear: baseKit {
        class items {

            //vanilla goggles
            class G_Squares {};
            class G_Squares_Tinted {};
            class G_Sport_Greenblack {};
            class G_Sport_Blackred {};
            class G_Sport_Checkered {};

        };
    };

    // Weapons
    class BaseWeapons: baseKit {
        class items {

            // rifle
            class arifle_MSBS65_F {};
            // Ammo
            class 30Rnd_65x39_caseless_msbs_mag {};
            class 30Rnd_65x39_caseless_msbs_mag_Tracer {};
            // Attachements
            class optic_ico_01_f {};
        };
    };


    // ROLE KITS
    class Grenadier: baseKit {
        role = "Grenadier";
        class items {
            // rifle
            class arifle_MSBS65_GL_F {};
            // Ammo
            class 1Rnd_HE_Grenade_shell {};
            class 1Rnd_Smoke_Grenade_shell {};
            class 1Rnd_SmokeRed_Grenade_shell {};
            class 1Rnd_SmokeGreen_Grenade_shell {};

            // Attachements
            class optic_ico_01_f {};
        };
    };

    class AntiTank: baseKit {
        role = "Anti-Tank";
        class items {
            //RPG7
            class launch_RPG7_F {};
            class RPG7_F {};
        };
    };

    // Others
    class ACE_Rations: baseKit {
        condition = "missionNamespace getVariable ['ace_field_rations_enabled', true]";
        class items {
	        class ACE_MRE_BeefStew {};
	        class ACE_MRE_ChickenTikkaMasala {};
	        class ACE_MRE_ChickenHerbDumplings {};
	        class ACE_MRE_CreamChickenSoup {};
	        class ACE_MRE_CreamTomatoSoup {};
	        class ACE_MRE_LambCurry {};
	        class ACE_MRE_MeatballsPasta {};
	        class ACE_MRE_SteakVegetables {};
        };
    };

    // Custom Player Kits
    class OverlordZorn: baseKit {
        id64 = "76561197970306509";
        class items {
            class G_Balaclava_blk {};
            class H_Beret_blk {};
            class ACE_wirecutter {};
        };
    };
};
