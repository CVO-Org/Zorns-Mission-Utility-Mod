#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to return roles based on a unit's traits. This will not add the roles to the unit.
*
* Arguments:
*
* Return Value:
* _roles - array of roles.
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [
    [ "_unit",  ACE_player, [objNull] ],
    [ "_roles", [],         [[]]      ]
];

if (isNil "_unit") exitWith { [] };

// Detectes ACE MEDIC and ACE Engineer
if ( [_unit, 1] call ace_medical_treatment_fnc_isMedic )  then { _roles pushBackUnique "Medic" };
if ( [_unit, 1] call ace_repair_fnc_isEngineer )           then { _roles pushBackUnique "Engineer" };

if ( [_unit, 2] call ace_medical_treatment_fnc_isMedic )  then { _roles pushBackUnique "Doctor" };
if ( [_unit, 2] call ace_repair_fnc_isEngineer )           then { _roles pushBackUnique "AdvEngineer" };

// explosiveSpecialist -> Explosive Specialist
if ( _unit getUnitTrait "explosiveSpecialist" ) then { _roles pushBackUnique "explosiveSpecialist"; } else {
    if ( "explosiveSpecialist" in _roles ) then { _unit setUnitTrait ["explosiveSpecialist", true]; };
};

// UAVHacker -> EW Specialist
if ( _unit getUnitTrait "UAVHacker" ) then { _roles pushBackUnique "EWSpecialist"} else {
    if ( "EWSpecialist" in _roles ) then { _unit setUnitTrait ["UAVHacker", true]; };
};

_roles apply { toLowerANSI _x } // Return
