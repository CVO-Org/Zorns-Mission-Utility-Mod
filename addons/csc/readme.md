# MUM Custom Supply Crates (CSC)

A framework that lets players request predefined supply crates in the field.

Players open a request dialog through an ACE interaction on an object (an *access point*), pick the crates they need, a *destination* and a *delivery mode*, and the crates arrive by helicopter, plane, drone or simply spawn at the destination.

Everything can be set up with Eden modules, in `description.ext` or via script.

- [How it works](#how-it-works)
- [Quick start (Eden)](#quick-start-eden)
- [Eden modules](#eden-modules)
- [Mission config (`description.ext`)](#mission-config-descriptionext)
- [Reference: Crates](#reference-crates)
- [Reference: Delivery modes](#reference-delivery-modes)
- [Reference: Destinations](#reference-destinations)
- [Cooldowns](#cooldowns)
- [Zeus](#zeus)
- [Scripting API](#scripting-api)


## How it works

The framework is built from four kinds of entries. Each entry has a unique **ID**, which is used to reference it everywhere else. IDs are case-insensitive (stored lowercase).

| Entry | What it is |
|---|---|
| **Crate** | A crate class plus its content (items, backpacks) and optional ACE features (medical facility, rearm source, cargo, ...). |
| **Delivery mode** | *How* crates get delivered: spawn, airdrop or drone. Defines the max. amount of crates per request and an optional cooldown. |
| **Destination** | *Where* crates get delivered: a fixed position, relative to an object, a map click or grid coordinates. |
| **Access point** | An object with an ACE interaction that opens the request dialog. Defines which crates, delivery modes and destinations are available there. |

A request runs like this:

1. The player uses **Request Custom Supply Crates** on an access point and fills out the dialog.
2. The destination is resolved on the player's machine (e.g. the map opens for a map click).
3. The server creates the crates and hands them to the delivery mode.
4. The delivery mode brings the crates to the destination and, if set, starts the cooldown.

The following entries are registered by default and can be used right away:

| Type | ID | Description |
|---|---|---|
| Delivery mode | `default_spawn` | Crates spawn at the destination. Up to 5 crates, no cooldown. |
| Delivery mode | `default_drone` | A drone carries one crate to the destination. 900 s cooldown. |
| Destination | `default_map` | The player clicks on the map. |
| Destination | `default_grid` | The player enters grid coordinates. |
| Destination | `default_player` | In front of the requesting player. |

There are no default crates. You always define your own.


## Quick start (Eden)

All modules are found under **Systems (F5) → Modules → MUM - Custom Supply Crates**.

1. Place a crate object (e.g. a supply box) and fill its inventory with the Eden arsenal / inventory editor.
2. Place a **Register Crate** module, give it a *Display Name* and **sync it to the crate**. Clear the *Crate Classname* field if the synced crate's class should be used.
   The crate's inventory becomes the content of the registered crate and the placed crate is deleted at mission start.
3. Place a **Register Access Point** module and sync it to the object players should interact with (a laptop, a flag pole, a vehicle, ...).
   Set *Delivery Modes* and *Destinations* to `#ALL` (or list specific IDs).
4. Start the mission and use the ACE interaction **Request Custom Supply Crates** on that object.

For more control, add your own delivery modes and destinations with the other modules.


## Eden modules

Every attribute has a tooltip in Eden. This section only covers what is not obvious from the tooltips.

> [!IMPORTANT]
> Delivery mode and destination modules **require** an ID. Unlike crates, they are not auto-generated, and the registration fails without one.
> Also give them a *Display Name*, otherwise the entry shows up empty in the dialog.

### Register Access Point
- Adds the request interaction to **every synced object**.
- *Crates*, *Delivery Modes* and *Destinations* take a list of IDs separated by spaces or commas, or `#ALL` for every registered entry.
- *Crates* defaults to `#ALL`. *Delivery Modes* and *Destinations* default to empty, which means **none are available** at this access point.

### Register Crate
- Optionally sync **one** crate object. Its inventory (items and backpacks) is added to the crate content and the object is deleted afterwards. Additional synced objects are ignored.
- *Crate Classname* overrides the synced object's class. Clear the field to use the synced object's class.
- *Items* takes `amount classname` pairs, one per line or separated by spaces/commas:
  ```
  5 ACE_fieldDressing
  50 ACE_elasticBandage
  ```
- All other attributes match the [crate keys](#reference-crates).

### Register Delivery - Airdrop Helicopter / Airdrop Plane
- Both register the same [airdrop](#airdrop) delivery mode, only their defaults differ.
- *Start Position* left at `[0,0,0]` uses the module's position.

### Register Delivery - Drone
- Registers a [drone](#drone) delivery mode.
- *Start Position* left at `[0,0,0]` uses the module's position.

### Register Destination - Fixed Position
- Registers a [fixed position](#fixed-position) destination.
- *Fixed Position* left at `[0,0,0]` uses the module's position.

### Register Destination - Relative Position
- Registers a [relative position](#relative-position) destination.
- Leave *Reference* empty and sync the module to one object to use that object as reference.


## Mission config (`description.ext`)

Entries can be defined in `description.ext` under `class mum_csc`. The class name of each entry is its ID.

```cpp
class mum_csc {
    class crates {
        class my_ammo_crate {
            displayName = "Ammunition Crate";
            box_class = "Box_NATO_Ammo_F";
            items[] = {
                { "30Rnd_65x39_caseless_mag", 40 },
                { "HandGrenade", 12 },
                { "B_Kitbag_mcamo", 2 }     // backpacks go into items[] as well
            };
        };
    };

    class delivery_modes {
        class my_heli_drop {
            displayName = "Airdrop: Ghost Hawk";
            description_code = "mum_csc_fnc_base_airdrop_desc";
            code = "mum_csc_fnc_base_airdrop";
            maxCrates = 2;
            cooldown = 900;

            class parameters {
                airframe_class = "B_Heli_Transport_01_F";
                airframe_side = "WEST";
                pos_end = "RETURN";
                airdrop_alt = 150;
            };
        };
    };

    class destinations {
        class my_fob {
            displayName = "FOB Alpha";
            description_string = "Landing zone next to the FOB.";
            code = "mum_csc_fnc_base_fixedPos";

            class parameters {
                position[] = { 4500, 6200, 0 };
                radius = 25;
            };
        };
    };
};
```

### Values
- `"true"` and `"false"` as strings are converted to booleans.
- `code` and `description_code` take either a **function name** (e.g. `"mum_csc_fnc_base_airdrop"`) or **SQF code as a string**.
- Keys you leave out fall back to the [crate](#reference-crates) or delivery mode / destination defaults.
- `class parameters` replaces the defaults as a whole. Any parameter you leave out falls back to the default listed in the reference below.

### Registration order and overriding
Entries are registered in this order:

1. Default entries of the mod (see [How it works](#how-it-works))
2. Entries from other mods' `configFile >> "mum_csc"`
3. Entries from the mission's `description.ext`

A mission entry with an ID that is already registered **replaces** that entry (with a warning in the RPT). This way a mission can, for example, redefine `default_drone` with a different cooldown. Any other duplicate ID is rejected with an error.

The replacement is complete, not merged with the previous entry: define every key and parameter you need, as you would for a new entry.

The mod config also contains unregistered templates (`default_heli`, `default_plane`, `default_medicalCrate`, `default_fixed_debug`) in [cfg/](cfg/). They are good starting points to copy into your mission.


## Reference: Crates

Keys of a crate entry. In config, booleans can be given as `"true"`/`"false"`.

| Key | Default | Description |
|---|---|---|
| `displayName` | `"Base Crate"` | Name shown in the dialog and as ACE cargo name. |
| `box_class` | `"C_supplyCrate_F"` | Class of the crate object. |
| `box_empty` | `true` | Removes the default inventory of `box_class` before adding `items`. |
| `items` | `[]` | Content as `[classname, amount]` pairs. Items, weapons, magazines and backpacks are all listed here. |
| `ace_medical_facility` | `false` | Crate counts as an ACE medical facility. |
| `ace_medical_vehicle` | `false` | Crate counts as an ACE medical vehicle. |
| `ace_repair_facility` | `false` | Crate counts as an ACE repair facility. |
| `ace_repair_vehicle` | `false` | Crate counts as an ACE repair vehicle. |
| `ace_rearm_source` | `false` | Crate is an ACE rearm source. |
| `ace_rearm_source_value` | `50` | Rearm supply amount. |
| `ace_refuel_source` | `false` | Crate is an ACE refuel source. |
| `ace_refuel_source_value` | `50` | Fuel amount in liters. |
| `ace_refuel_source_nozzlePos` | `[0,0,0]` | Nozzle position relative to the crate. |
| `ace_drag_canDrag` | `true` | Can be dragged. |
| `ace_drag_relPOS` | `[0,1.5,0]` | Offset while dragging. |
| `ace_drag_dir` | `0` | Direction while dragging. |
| `ace_drag_ignoreWeight` | `true` | Can be dragged regardless of weight. |
| `ace_carry_canCarry` | `true` | Can be carried. |
| `ace_carry_relPOS` | `[0,1,1]` | Offset while carrying. |
| `ace_carry_dir` | `0` | Direction while carrying. |
| `ace_carry_ignoreWeight` | `false` | Can be carried regardless of weight. |
| `ace_cargo_setSize` | `-1` | ACE cargo size of the crate itself. `-1` keeps the class default. |
| `ace_cargo_setSpace` | `0` | ACE cargo space inside the crate. The space needed for spare parts below is added automatically. |
| `ace_cargo_add_spareWheels` | `0` | Spare wheels loaded into the crate's ACE cargo. |
| `ace_cargo_add_tracks` | `0` | Spare tracks loaded into the crate's ACE cargo. |
| `ace_cargo_add_jerrycans` | `0` | Jerry cans loaded into the crate's ACE cargo. |

> [!NOTE]
> A crate has **no ACE cargo space** unless `ace_cargo_setSpace` or spare parts are set, even if `box_class` normally has some.


## Reference: Delivery modes

Keys of a delivery mode entry:

| Key | Default | Description |
|---|---|---|
| `displayName` | `""` | Name shown in the dialog. |
| `description_string` | `""` | Description shown in the dialog. Structured text is supported. |
| `description_code` | `""` | Function name or code returning an additional description line. Receives the delivery mode hashmap as `_this`. |
| `code` | `""` | Function name or code executing the delivery. See [custom delivery modes](#custom-delivery-modes). |
| `maxCrates` | `1` | Max. amount of crates per request. |
| `cooldown` | `0` | Cooldown in seconds after use. `0` disables it. See [Cooldowns](#cooldowns). |
| `parameters` | | Parameters passed to `code`. See below. |

### Spawn
`code = "mum_csc_fnc_base_spawn"` - no parameters.

Crates are placed at the destination, stacked on top of each other with the largest crate at the bottom, one per second.

### Airdrop
`code = "mum_csc_fnc_base_airdrop"`, `description_code = "mum_csc_fnc_base_airdrop_desc"` (shows aircraft and drop altitude).

An aircraft flies to the destination and drops the crates by parachute, one per second.

| Parameter | Default | Description |
|---|---|---|
| `airframe_class` | `"C_Heli_Light_01_civil_F"` | Aircraft class. Helicopters and planes both work. |
| `airframe_side` | `"CIV"` | `"WEST"`, `"EAST"`, `"GUER"` or `"CIV"`. |
| `airframe_protected` | `true` | Aircraft and crew are invincible. |
| `mode` | `"EDGE_NEAR"` | Where the aircraft spawns:<br>`"EDGE_NEAR"`: map edge nearest to `pos_start`<br>`"EDGE_FAR"`: map corner furthest from `pos_start`<br>`"STARTPOS"`: at `pos_start` |
| `pos_start` | `[0,0,0]` | Reference / spawn position, see `mode`. |
| `pos_end` | | After the drop: `"RETURN"` flies back to the spawn position, `"CONTINUE"` flies on in the same direction. The aircraft is deleted on arrival. **Always set this**; anything else sends the aircraft to `[0,0,0]`. |
| `airdrop_alt` | `50` | Drop altitude in meters above the drop zone. |
| `timeout` | `900` | If the aircraft has not reached the drop zone after this many seconds, aircraft and crates are deleted. |
| `parachute_class` | `"B_Parachute_02_F"` | Parachute class. |
| `parachute_class_strobe` | `"ACE_IR_Strobe_Effect"` | Strobe attached above the parachute, removed on landing. `""` to disable. |
| `parachute_class_chemlight` | `"Chemlight_yellow"` | Chemlight attached to the crate. `""` to disable. |
| `parachute_class_smoke` | `"SmokeShellYellow"` | Smoke created once the crate has landed. `""` to disable. |

A parachute that gets stuck above ground (e.g. in a tree) releases its crate, so it drops to the ground.

### Drone
`code = "mum_csc_fnc_base_drone"`

A drone carries the crates hanging below it, descends at the destination and releases them after a short warning beep.

| Parameter | Default | Description |
|---|---|---|
| `drone_class` | `"B_UAV_06_F"` | Drone class. |
| `drone_side` | `"CIV"` | `"WEST"`, `"EAST"`, `"GUER"` or `"CIV"`. |
| `drone_protected` | `true` | Drone and crew are invincible. |
| `mode` | `"EDGE_NEAR"` | Same as for [airdrop](#airdrop). |
| `pos_start` | `[0,0,0]` | Same as for [airdrop](#airdrop). |
| `pos_end` | | Same as for [airdrop](#airdrop). **Always set this.** |
| `alt_journey` | `50` | Travel altitude. |
| `alt_final` | `35` | Altitude on final approach. Should be above 20. |
| `alt_drop` | `9` | Altitude at the drop point (max. 9.9, crate height is added). Below 10 the drone ignores obstacles and holds the altitude. |

Keep `maxCrates` low (the default drone mode uses 1), as all crates hang below the drone.


## Reference: Destinations

Keys of a destination entry:

| Key | Default | Description |
|---|---|---|
| `displayName` | `""` | Name shown in the dialog. |
| `description_string` | `""` | Description shown in the dialog. |
| `code` | `""` | Function name or code resolving the position. See [custom destinations](#custom-destinations). |
| `parameters` | | Parameters passed to `code`. See below. |

### Fixed position
`code = "mum_csc_fnc_base_fixedPos"`

| Parameter | Default | Description |
|---|---|---|
| `position` | `[0,0,0]` | Position `[x, y, z]`. |
| `radius` | `0` | If set, a random position within this radius is used. |

### Relative position
`code = "mum_csc_fnc_base_relativeTo"`

| Parameter | Default | Description |
|---|---|---|
| `reference` | | `"PLAYER"`: the requesting player<br>`"TARGET"`: the access point object<br>Any other string: name of a global variable holding an object<br>Via script, an object can also be passed directly. |
| `mode` | `"FRONT"` | `"FRONT"` / `"BEHIND"`: in front of / behind the reference, with enough space for the largest requested crate<br>`"OFFSET"`: reference position (ASL) + `offset` |
| `offset` | `[0,0,2]` | Only used by `"OFFSET"`. |
| `randomOffset` | `0` | Shifts the result by `-x`, `0` or `+x` meters on each axis. |

If the reference can't be found, the destination is `[0,0,0]`.

### Map click
`code = "mum_csc_fnc_base_mapClick"` - no parameters.

The map opens and the player clicks the destination. **Alt + click** aborts. Times out after 180 seconds.

### Grid coordinates
`code = "mum_csc_fnc_base_gridCoordinates"` - no parameters.

A dialog asks for easting and northing. Both need the same amount of digits (e.g. `045` / `123` or `04512` / `12345`).


## Cooldowns
- A cooldown belongs to the **delivery mode**, not to an access point. Using a delivery mode at one access point blocks it at all others until the cooldown is over.
- The remaining cooldown is shown in the dialog and the request button is disabled meanwhile.


## Zeus
Zeus gets the ACE Zeus interaction **Request Custom Supply Crates** with access to all registered crates, delivery modes and destinations.

- Zeus requests ignore cooldowns and do not start them.
- For destinations that need player input (map click, grid), the Zeus interface closes and reopens afterwards.
- Spawned crates and aircraft are added to all curators.


## Scripting API

All register functions run on the **server only** and are ignored elsewhere. Call them from `initServer.sqf` or behind an `isServer` check.

### `mum_csc_fnc_registerCrate`
```sqf
// 0: Crate data <HASHMAP> - see "Reference: Crates", plus "id"
// 1: Overwrite an existing entry with the same ID <BOOL> (default: false)
// Returns: true on success

[createHashMapFromArray [
    ["id", "my_medical_crate"],
    ["displayName", "Medical Crate"],
    ["box_class", "ACE_medicalSupplyCrate_advanced"],
    ["ace_medical_facility", true],
    ["items", [
        ["ACE_fieldDressing", 40],
        ["ACE_salineIV_500", 20]
    ]]
]] call mum_csc_fnc_registerCrate;
```
Without an `id`, one is generated (`mum_csc_crate_<n>`). Handy if every access point uses `#ALL` anyway.

### `mum_csc_fnc_registerDeliveryMode` / `mum_csc_fnc_registerDestination`
Same signature as `registerCrate`, but the `id` is required. `parameters` is a hashmap.

```sqf
[createHashMapFromArray [
    ["id", "lz_north"],
    ["displayName", "LZ North"],
    ["code", "mum_csc_fnc_base_fixedPos"],
    ["parameters", createHashMapFromArray [
        ["position", getPosASL lz_north],
        ["radius", 10]
    ]]
]] call mum_csc_fnc_registerDestination;
```

### `mum_csc_fnc_registerAccessPoint`
```sqf
// 0: Object <OBJECT>
// 1: Access point ID <STRING> (default: "" - auto-generated)
// 2: Crate IDs <ARRAY or "#ALL"> (default: "#ALL")
// 3: Delivery mode IDs <ARRAY or "#ALL"> (default: [] - none)
// 4: Destination IDs <ARRAY or "#ALL"> (default: [] - none)
// 5: Additional parameters <HASHMAP> (optional)
// Returns: true

[laptop_1, "hq", "#ALL", ["default_spawn", "my_heli_drop"], "#ALL"] call mum_csc_fnc_registerAccessPoint;
```

Additional parameters:

| Key | Description |
|---|---|
| `conditionType` | `"ALWAYS"` (default) or `"CUSTOM"`. |
| `conditionCodeCustom` | With `"CUSTOM"`: ACE action condition code, called with `[_target, _player]` (access point, player). |

```sqf
// Only officers can request crates
[
    laptop_1, "hq", "#ALL", "#ALL", "#ALL",
    createHashMapFromArray [
        ["conditionType", "CUSTOM"],
        ["conditionCodeCustom", {
            params ["_target", "_player"];
            rank _player in ["CAPTAIN", "MAJOR", "COLONEL"]
        }]
    ]
] call mum_csc_fnc_registerAccessPoint;
```

Calling it multiple times on the same object adds one interaction per call.

### `mum_csc_fnc_createCrate`
Creates a registered crate directly, without a request. Server only.
```sqf
private _crate = [mum_csc_crates get "my_medical_crate"] call mum_csc_fnc_createCrate;
_crate setPosATL (player getPos [5, getDir player]);
```
The crate is created near the bottom-left map corner; move it where you need it.

### Custom delivery modes
`code` is called on the **server** with `[_request, _parameters]`:

| `_request` key | Description |
|---|---|
| `crates` | Array of the created crate objects. |
| `destination` | Position from the destination. |
| `delivery_mode` | ID of the delivery mode. |
| `requester` | The requesting player. |
| `target` | The access point object. |
| `isZeus` | `true` if requested via Zeus. |

`_parameters` is the `parameters` hashmap of the delivery mode. The crates already exist, your code only has to move them. See [fn_base_spawn.sqf](functions/delivery/fn_base_spawn.sqf) for a minimal example.

### Custom destinations
`code` is called on the **requesting player's machine** with `[_request, _parameters]`. Here `crates` contains the requested crate IDs, not objects.

Return either:
- a position `[x, y, z]`, or
- the name of a `missionNamespace` variable as a string. The framework then waits (up to 181 s) until that variable holds a position `[x, y, z]`, or `false` to abort the request. Use this for anything that needs player input; see [fn_base_mapClick.sqf](functions/destination/fn_base_mapClick.sqf).

### Events
| Event | Type | Arguments | Description |
|---|---|---|---|
| `mum_csc_api_crateSpawned` | Server | `[_crate]` | A crate was created and filled, before it is handed to the delivery mode. |

```sqf
["mum_csc_api_crateSpawned", {
    params ["_crate"];
    _crate setVariable ["my_tag_isSupplyCrate", true, true];
}] call CBA_fnc_addEventHandler;
```
