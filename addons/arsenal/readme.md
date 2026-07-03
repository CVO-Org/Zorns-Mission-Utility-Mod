# MUM Arsenal - Framework for ACE Arsenal

This is an config-based Arsenal Framework for the ACE Arsenal.

This is primarily made for reusability across multiple missions - so campaigns or missions with a repeating player loadouts or "Zeus Templates".
This allows mission makers to create "kits" (basically a list of classnames with optional conditions) and add these kits to designated arsenal objects.
These Kits can be conditional, meaning they can be assigned to certain roles or player ID's or else.

Example mission folder can be found [here](https://github.com/CVO-Org/Zorns-Mission-Utility-Mod/blob/main/.hemtt/missions/arsenal.VR).

##
> [!IMPORTANT]
> There are no modules and no "easy way" to set things up. Understanding basic config and SQF is a essential to have good time with this.
> These Addons are made by me for me to make my life easier and reduce repeated effort.
> I am happy to help with details, but basic sqf and config knowledge is expected.
##

## Summary
- Supports Kits limited for certain "Roles"
- Auto Assigns "Roles" based on Traits
- Supports Kits based based on a players Steam64 IDs

### How to Implement
   1. Load Zorns Mission Utility Mod
   2. Create `mum_arsenal.hpp` and include in the mission's `description.ext`
   3. Define Arsenal Objects, either via editor layer name or objectVariable or both in `mum_arsenal.hpp`
   4. Define Units Roles.
   5. Define kits in `mum_arsenal.hpp`.

## Roles

### What is a role?
Roles are simple "tags" defined by the mission makers via a function call on the unit.

Roles are case-insensitive and will be converted to lowercase ANSI characters.


### Auto Roles - Automatic Role Assignement

Certain roles will be automatically assigned, based on ace or vanilla traits.

| Condition                             | Mum Arsenal Role (String) | Further                                             |
| ------------------------------------- | ------------------------- | --------------------------------------------------- |
| ACE Medical Trait = 1                 | `"Medic"`                 |                                                     |
| ACE Medical Trait = 2                 | `"Doctor"`                |                                                     |
| ACE Engineer Trait = 1                | `"Engineer"`              |                                                     |
| ACE Engineer Trait = 2                | `"AdvEngineer"`           |                                                     |
| Vanilla Trait `"medic"`               | `"Medic"`                 |                                                     |
| Vanilla Trait `"engineer"`            | `"Engineer"`              |                                                     |
| Vanilla Trait `"explosiveSpecialist"` | `"explosiveSpecialist"`   | Unit with role will also be given the vanilla trait |
| Vanilla Trait `"UAVHacker"`           | `"EWSpecialist"`          | Unit with role will also be given the vanilla trait |

### Auto Traits - Automatic Trait Assignement
Certain Traits will be automatically assigned, based on the Arsenal Roles.

| Condition                                | Vanilla Trait           |
| ---------------------------------------- | ----------------------- |
| Mum Arsenal Role `"explosiveSpecialist"` | `"explosiveSpecialist"` |
| Mum Arsenal Role `"EWSpecialist"`        | `"EWSpecialist"`        |

### How to Assign an Arsenal Role

#### 1. 3den Editor Attribute

![alt text](https://github.com/CVO-Org/Zorns-Mission-Utility-Mod/blob/main/docs/img/arsenal_3den_roles.png)

One or more Roles can be assigned like this.
Example: `Marksman` or `firstRole, secondRole`.

#### 2. Script
Roles are added to a unit with `mum_arsenal_fnc_addUnitRoles`.
This can be done either via a units Init Field in the 3den Editor or other script application.

Examples for the units init field:
- `[ this, "someRole" ] call mum_arsenal_fnc_addUnitRoles;`
- `[ this, ["someRole"] ] call mum_arsenal_fnc_addUnitRoles;`
- `[ this, ["someRole", "anotherRole"] ] call mum_arsenal_fnc_addUnitRoles;`

More Infos [here](functions/roles/fn_addUnitRoles.sqf)


## Kits

### What is a kit?
A Kit is a collection of items made available in the Arsenal.
Optional requirements can be attached to a kit. For example: Roles, Addon dependency or a condition code.
These requirements will be evaluated every time a player opens the MUM Arsenal.

### Example Kit Configurations

The following kits can be referenced as examples on how to format a kit.

Further, the following kits are **hardcoded** through the mod itself. They can be disabled through [CBA Settings](#disable-default-kits).

- [Base Kits - Available for Everyone](kits_base.hpp)
- [Role Kits - Available for certain Roles](kits_role.hpp)
- [Personal Kits - Available for individual Players](kits_personal.hpp)



### Config Properties
#### General Attributes
| Attribute Name        | DataType           | Description                                                                                                 |
| :-------------------- | ------------------ | ----------------------------------------------------------------------------------------------------------- |
| editor_layer_name     | <STRING>           | Provide an Eden Editor layer name.<br> All Objects inside this Layer will be made into MUM Arsenal Objects. |
| object_variable_names | <ARRAY of STRINGS> | Provide the variable names of individual objects to make them into MUM Arsenal Objects.                     |

 #### Kit Attributes:

| Attribute Name   | DataType                | Description                                           | Default              |
| :--------------- | ----------------------- | ----------------------------------------------------- | -------------------- |
| addon_dependency | <STRING>                | Name of an Addon - Check if  loaded.                  | `""` Skip check.     |
| roles            | <STRING>                | Name/Identifier of the Role. case-insensitive. ANSI only.       | `""` Applied to all. |
| id64             | <STRING>                | steamID64 (getPlayerUID)                              | `""` Applied to all. |
| condition        | <STRING>                | Code as String - needs to return boolean.             | `""` Skip check.     |
| code             | <STRING>                | Code as String - needs to return array of classnames. | `""` Skipped.        |
| items            | <CLASS with SUBCLASSES> | subclasses will get added as item classnames.         |                      |

Note: parameters for the condition and code are `params ["_unit", "_items"];`.


### Disable Default Kits

The default "baseKits" that come with the mod can be disabled via two ways

#### 1. Individually via CBA Settings
![Image showcasing the cba settings](https://github.com/CVO-Org/Zorns-Mission-Utility-Mod/blob/main/docs/img/arsenal_disable_defaultKits.png)

#### 2. All at once via description.ext
```cpp
// Inside description.ext
mum_arsenal_ignoreBaseKits = 1;
mum_arsenal_ignoreBaseRoleKits = 1;
```
