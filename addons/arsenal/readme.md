# MUM Arsenal - Framework for ACE Arsenal

This is an config-based Arsenal Framework for the ACE Arsenal.

This allows mission makers to easily create "kits" and make these kits available via an designated arsenal.

## Summary
- Supports Kits limited for certain "Roles"
- Auto Assigns "Roles" based on Traits
- Supports Kits based based on a players Steam64 IDs

### What is a kit?
A Kit is a collection of items made available in the Arsenal.
Optional requirements can be attached to a kit. For example: Roles, Addon dependency or a condition code.
These requirements will be evaluated every time a player opens the MUM Arsenal.

### Roles
Roles are defined by the mission makers.

Some roles will be automatically assigned, based on a units trait.
- ACE Medic / ACE Doctor
- ACE Engineer / ACE Advanced Engineer
- Explosives Specialist*
- UAVHacker / EWSpecialist*

\* will apply trait if unit has role defined but not the trait.


## How to Implement
   1. Load MUM Aux Mod
   2. Create `mum_arsenal_kits.hpp` and include the mission's `description.ext`
   3. Define Units Roles via `cvo_arsenal_fnc_addUnitRoles`.
        - Examples for the units init field:
          - `[ this, "someRole" ] call mum_arsenal_fnc_addUnitRoles;`
          - `[ this, ["someRole"] ] call mum_arsenal_fnc_addUnitRoles;`
          - `[ this, ["someRole", "anotherRole"] ] call mum_arsenal_fnc_addUnitRoles;`
          - More Infos [here](functions/roles/fn_addUnitRoles.sqf)


## Kit Configuration

### Example Kit Configurations
The following kits can be referenced as examples on how to format a kit.

Further, those kits are hardcoded through the mod itself. They can be disabled through CBA Settings when needed.

- [Base Kits - Available vor Everyone](kits_base.hpp)
- [Role Kits - Available for certain Roles](kits_role.hpp)
- [Personal Kits - Available for individual Players](kits_personal.hpp)

### Config Properties
#### General Attributes
| Attribute Name        | DataType           | Description                                                                                                 | 
| :-------------------- | ------------------ | ----------------------------------------------------------------------------------------------------------- | 
| editor_layer_name     | <STRING>           | Provide an Eden Editor layer name.<br> All Objects inside this Layer will be made into MUM Arsenal Objects. | 
| object_variable_names | <ARRAY of STRINGS> | Provide the variable names of individual objects to make them into MUM Arsenal Objects.                     | 

 #### Kit Attributes:

| Attribute Name   | DataType                | Description                                                     | Default              |
| :--------------- | ----------------------- | --------------------------------------------------------------- | -------------------- |
| addon_dependency | <STRING>                | Name of an Addon - Will Check if the Addon is currently loaded. | `""` Skip check.     |
| roles            | <STRING>                | Name/Identifyer of the Role. case-unsensitive.                  | `""` Applied to all. |
| id64             | <STRING>                | steamID64 - getPlayerUID                                        | `""` Applied to all. |
| condition        | <STRING>                | Code as String - needs to return boolean.                       | `""` Skip check.     |
| code             | <STRING>                | Code as String - needs to return array of classnames.           | `""` Skipped.        |
| items            | <CLASS with SUBCLASSES> | subclasses will get added as item classnames.                   |  |


### Regex Replace Templates
Regex to update old style Unit Role Definition to the new Function call.
Only needed when updating an old mission to the new system.
```regex
this setVariable \[""MUM_A_ROLES"",\[(.*)\]\];
[this, [$1]] call mum_arsenal_fnc_addUnitRoles;
```
